import 'dart:io';

import 'package:alkhalafsheep/UI/home/home_controller.dart';
import 'package:alkhalafsheep/_helpers/shared_pref.dart';
import 'package:alkhalafsheep/components/loading_widget.dart';
import 'package:alkhalafsheep/models/profile_model.dart';
import 'package:alkhalafsheep/network/apis.dart';
import 'package:alkhalafsheep/network_models/register_response.dart';
import 'package:alkhalafsheep/network_models/response_status.dart';
import 'package:alkhalafsheep/network_models/verification_response.dart';
import 'package:alkhalafsheep/utilities/constants.dart';
import 'package:alkhalafsheep/utilities/echo.dart';
import 'package:alkhalafsheep/utilities/mystrings.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

class VerificationCodeController extends StatefulWidget {
  static String id = 'verification';
  final JsonRegisterResponse? registerResponse;

  const VerificationCodeController({this.registerResponse});

  @override
  _VerificationCodeControllerState createState() =>
      _VerificationCodeControllerState();
}

class _VerificationCodeControllerState
    extends State<VerificationCodeController> {
  TextEditingController _verificationController = TextEditingController();
  bool _loading = false;

  Future<bool> onBackPress() {
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPress,
      child: SafeArea(
        child: Scaffold(
          body: _loading
              ? LoadingWidget()
              : verificationLayout(_verificationController),
        ),
      ),
    );
  }

  Widget verificationLayout(TextEditingController noteController) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.verified_user,
            color: Colors.green,
            size: 120,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              YemString.verification_message,
              style: kTextPrimaryHeader,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.registerResponse!.data!.phone!,
              style: kTextGreyBody,
            ),
          ),
          Container(
            margin: EdgeInsets.all(50),
            padding: EdgeInsets.all(6),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: YemString.verification_code_message,
                  labelText: YemString.verification_code),
              keyboardType: TextInputType.number,
              minLines: 1,
              onChanged: (text) {
                verify(text);
              },
              maxLines: 1,
              controller: _verificationController,
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor), // Set the background color
            ),
            onPressed: () {},
            child: Text(
              YemString.verify,
              style: kWhiteTextColor,
            ),
          ),
          SizedBox(height: 20),
          GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(YemString.back)),
        ],
      ),
    );
  }

  void verify(String text) {
    if (text == widget.registerResponse!.data!.smsCode) {
      Echo(' ${widget.registerResponse!.data!.smsCode} == ${text}');
      networkVerify(smsCode: widget.registerResponse!.data!.smsCode);
    }
  }

  void networkVerify({
    String? smsCode,
  }) async {
    setState(() {
      _loading = true;
    });
    YemenyPrefs prefs = YemenyPrefs();

    try {
      Dio dio = Dio();
      dio.interceptors.add(LogInterceptor(responseBody: true));
      Map<String, dynamic> queryParameters = Map();
      queryParameters['sms_code'] = smsCode;

      Response response = await dio
          .post(kVerifyApi, queryParameters: queryParameters)
          .whenComplete(() {
      });
      final basicJsonResponse = JsonBasicResponse.fromJson(response.data);
      if (basicJsonResponse.status == YemString.successNoTranslate) {
        final registerResponse =
            JsonVerificatioResponse.fromJson(response.data);

        await prefs.setUserName(registerResponse.data!.name!);
        await prefs.setEmail(registerResponse.data!.email);
        await prefs.setPhone(registerResponse.data!.phone!);
        await prefs.setToken(registerResponse.data!.token!);
        await prefs.setUserId('${registerResponse.data!.id}');
        await prefs.setPhoto(registerResponse.data!.avatar);

        Provider.of<ProfileModel>(context, listen: false).id =
            '${registerResponse.data!.id}';
        Provider.of<ProfileModel>(context, listen: false).email =
            '${registerResponse.data!.email}';
        Provider.of<ProfileModel>(context, listen: false).tokenId =
            registerResponse.data!.token;
        Provider.of<ProfileModel>(context, listen: false).name =
            registerResponse.data!.name;
        Provider.of<ProfileModel>(context, listen: false).phone =
            registerResponse.data!.phone;
        Provider.of<ProfileModel>(context, listen: false).image =
            registerResponse.data!.avatar;

        sleep(const Duration(seconds: 1));
        goToHome();
      } else {
        setState(() {
          _loading = false;
        });
      }

      print(basicJsonResponse.status);
    } on DioError catch (e) {
      setState(() {
        _loading = false;
      });
    }
  }

  void goToHome() {
    Navigator.pushNamedAndRemoveUntil(
        context, HomeController.id, (Route<dynamic> route) => false);
  }
}
