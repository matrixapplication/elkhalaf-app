import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:alkhalafsheep/_helpers/shared_pref.dart';
import 'package:alkhalafsheep/models/profile_model.dart';
import 'package:alkhalafsheep/network/apis.dart' as api;
import 'package:alkhalafsheep/utilities/echo.dart';
import 'package:provider/provider.dart';

class NotificationsFCM {
  String? currentUserId;
  String? userName;
  String? userEmail;
  String? userImage;
  String userOnline = 'online';
  String? userFCMToken;
  String? userPhone;

  // final FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();


  NotificationsFCM(BuildContext context) {
    ProfileModel profileModel =
        Provider.of<ProfileModel>(context, listen: false);
    Echo('FCM NotificationsFCM userId ${profileModel.id}');
    if (profileModel.id != null) {
      registerNotification();
      configLocalNotification();
    }
  }

  void registerNotification() {
    Echo('FCM registerNotification');
    firebaseMessaging.requestPermission();
    // firebaseMessaging.requestNotificationPermissions();

    // firebaseMessaging.configure(onMessage: (Map<String, dynamic> message) {
    //   Echo('FCM registerNotification onMessage $message');
    //   showNotification(message['notification'] != null ? message['notification'] : message);
    //   return;
    // }, onResume: (Map<String, dynamic> message) {
    //   Echo('FCM onResume onMessage $message');
    //   return;
    // }, onLaunch: (Map<String, dynamic> message) {
    //   Echo('FCM onLaunch onMessage $message');
    //   return;
    // });
    Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
      print("Handling a background message: ${message.messageId}");
      // Add your handling logic here
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      Echo('FCM onMessage $message');
      showNotification(message.notification);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Echo('FCM onLaunch onMessage $message');
      // Handle the notification when the app is in the foreground
    });

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);



// Call this function to initialize Firebase messaging
    void initializeFirebaseMessaging() {
      FirebaseMessaging.instance
          .getInitialMessage()
          .then((RemoteMessage? initialMessage) {
        if (initialMessage != null) {
          Echo('FCM getInitialMessage $initialMessage');
          // Handle the initial notification when the app is launched
        }
      });

      FirebaseMessaging.instance.subscribeToTopic('your_topic_name');
    }

    firebaseMessaging.getToken().then((token) {
      Echo('FCM registerNotification token $token');
      networkSaveFCM(token);
    });
  }

  void configLocalNotification() {
    Echo('FCM configLocalNotification');
    var initializationSettingsAndroid = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings(
      defaultPresentSound: true,
      defaultPresentBadge: true,
      defaultPresentAlert: true,
    );
    var initializationSettings = new InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void showNotification(message) async {
    Echo("showNotification");
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      Platform.isAndroid ? 'com.matrixclouds.alkhalafsheep' : 'com.matrixclouds.alkhalafsheep',
      'com.matrixclouds.alkhalafsheep',
      '682',
       playSound: true,
      enableVibration: true,
      importance: Importance.max,
      priority: Priority.high,
    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);

    if (Platform.isIOS) {
      Echo('showNotification ${message.toString()}');
      if (message != null) if (message['aps'] == null) {
        await flutterLocalNotificationsPlugin.show(0, message['title'].toString(), message['body'].toString(), platformChannelSpecifics, payload: json.encode(message));
      } else {
        await flutterLocalNotificationsPlugin.show(0, message['aps']['alert']['title'].toString(), message['aps']['alert']['body'].toString(), platformChannelSpecifics, payload: json.encode(message));
      }
    } else {
      await flutterLocalNotificationsPlugin.show(0, message['title'].toString(), message['body'].toString(), platformChannelSpecifics, payload: json.encode(message));
    }
  }


  void networkSaveFCM(String? fcm) async {

    YemenyPrefs prefs = YemenyPrefs();
    String? lang = await prefs.getLang();
    String? token = await prefs.getToken();

    Map<String, dynamic> queryParameters = Map();
    queryParameters['token'] = fcm;
    try {
      Dio dio = Dio();
      dio.interceptors.add(LogInterceptor(responseBody: true));
      dio.options.headers['Content-Language'] = lang;
      dio.options.headers["authorization"] = "Bearer ${token}";
      dio.options.headers['content-Type'] = 'application/json';

      await dio.post( api.kFCMApi ,queryParameters: queryParameters)
          .whenComplete(() {});
    } on DioError catch (e) {}
  }
}
