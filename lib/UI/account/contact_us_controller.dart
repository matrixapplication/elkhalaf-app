import 'package:alkhalafsheep/elements/alerts.dart';
import 'package:alkhalafsheep/models/profile_model.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:alkhalafsheep/_helpers/shared_pref.dart';
import 'package:alkhalafsheep/components/loading_widget.dart';
import 'package:alkhalafsheep/network/apis.dart';
import 'package:alkhalafsheep/network_models/response_status.dart';
import 'package:alkhalafsheep/utilities/constants.dart';
import 'package:alkhalafsheep/utilities/echo.dart';
import 'package:alkhalafsheep/utilities/mystrings.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:social_media_buttons/social_media_button.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../provider/main_provider.dart';
import 'email_edit_text.dart';
import 'message_edit_text.dart';
import 'name_edit_text.dart';
import 'phone_edit_text.dart';

class ContactUs extends StatefulWidget {
  static const id = "contactUs";

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final _formKey = GlobalKey<FormState>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ProfileModel? profileModel;
  bool _loading = false;

  String inputPhone = '';
  String inputEmail = '';
  String inputName = '';
  String inputMessage = '';

  @override
  Widget build(BuildContext context) {
    profileModel = Provider.of<ProfileModel>(context, listen: false);
    MainDataProvider mainDataProvider =
    Provider.of<MainDataProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(YemString.contact_us, style: kWhiteTextColor),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: _loading
          ? LoadingWidget(isItProgressIndicator: true)
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 4),
              //  Padding(
              //    padding: const EdgeInsets.all(16.0),
              //    child: Text('اقتراحتكم تهمنا وتدفعنا الي التميز والتطور ، فلا تبخلوا علينا . نحن في انتظاركم',textAlign: TextAlign.center,),
              //  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: contactFormLayout(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: <Widget>[
                    //     Flexible(
                    //       flex: 1,
                    //       child: AvatarGlow(
                    //         glowColor: Color(0xFF0D47A1),
                    //         child: Material(
                    //           elevation: 8.0,
                    //           shape: CircleBorder(),
                    //           child: SocialMediaButton.snapchat(
                    //             url: '',
                    //             size: 35,
                    //             color: Colors.blue[900],
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     Flexible(
                    //       flex: 1,
                    //       child: AvatarGlow(
                    //         glowColor: Colors.blue,
                    //         child: Material(
                    //           elevation: 8.0,
                    //           shape: CircleBorder(),
                    //           child: SocialMediaButton.twitter(
                    //             url: '',
                    //             size: 35,
                    //             color: Colors.blue,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     Flexible(
                    //       flex: 1,
                    //       child: AvatarGlow(
                    //         glowColor: Colors.blue,
                    //         child: Material(
                    //           elevation: 8.0,
                    //           shape: CircleBorder(),
                    //           child: SocialMediaButton.instagram(
                    //             url: '',
                    //             size: 35,
                    //             color: Colors.blue,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     Flexible(
                    //       flex: 1,
                    //       child: AvatarGlow(
                    //         glowColor: Colors.green,
                    //         child: Material(
                    //           elevation: 8.0,
                    //           shape: CircleBorder(),
                    //           child: SocialMediaButton.whatsapp(
                    //             url: '',
                    //             size: 35,
                    //             color: Colors.green,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        if (mainDataProvider.mainData != null &&
                            mainDataProvider.mainData!.snapchat != null &&
                            mainDataProvider.mainData!.snapchat!.isNotEmpty)
                          Flexible(
                            flex: 1,
                            child: AvatarGlow(
                              glowColor: Colors.green,
                              child: InkWell(
                                onTap: (){
                                  launch('${mainDataProvider.mainData!.snapchat}');
                                },
                                child: Material(
                                    elevation: 8.0,
                                    shape: CircleBorder(),
                                    child:Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset('assets/img/snapchat.webp',
                                        width: 30,
                                        height: 30,
                                      ),
                                    )
                                ),
                              ),
                            ),
                          ),

                        if (mainDataProvider.mainData != null &&
                            mainDataProvider.mainData!.twitter != null &&
                            mainDataProvider.mainData!.twitter!.isNotEmpty)
                          Flexible(
                            flex: 1,
                            child: AvatarGlow(
                              glowColor: Colors.green,
                              child: InkWell(
                                onTap: (){
                                  launch('${mainDataProvider.mainData!.twitter}');
                                },
                                child: Material(
                                    elevation: 8.0,
                                    shape: CircleBorder(),
                                    child:Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset('assets/img/twitter.png',
                                        width: 35,
                                        height: 35,
                                      ),
                                    )
                                ),
                              ),
                            ),
                          ),

                        if (mainDataProvider.mainData != null &&
                            mainDataProvider.mainData!.instagram != null &&
                            mainDataProvider.mainData!.instagram!.isNotEmpty)
                          Flexible(
                            flex: 1,
                            child: AvatarGlow(
                              glowColor: Colors.green,
                              child: InkWell(
                                onTap: (){
                                  launch('${mainDataProvider.mainData!.instagram}');
                                },
                                child: Material(
                                    elevation: 8.0,
                                    shape: CircleBorder(),
                                    child:Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset('assets/img/instegram.png',
                                        // width: 35,
                                        // height: 35,
                                      ),
                                    )
                                ),
                              ),
                            ),
                          ),
                        if (mainDataProvider.mainData != null &&
                            mainDataProvider.mainData!.tiktok != null &&
                            mainDataProvider.mainData!.tiktok!.isNotEmpty)
                          Flexible(
                            flex: 1,
                            child: AvatarGlow(
                              glowColor: Colors.black,

                              child: GestureDetector(
                                onTap: (){
                                  launch('${mainDataProvider.mainData!.tiktok}');
                                },
                                child: Material(
                                  elevation: 8.0,
                                  shape: CircleBorder(),
                                  child: Image.asset(
                                    'assets/img/ic_tiktok.png',
                                    width: 45,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        if (mainDataProvider.mainData != null &&
                            mainDataProvider.mainData!.whatsapp != null &&
                            mainDataProvider.mainData!.whatsapp!.isNotEmpty)
                          Flexible(
                            flex: 1,
                            child: AvatarGlow(
                              glowColor: Colors.green,
                              child: InkWell(
                                onTap: (){
                                  launch('${mainDataProvider.mainData!.whatsapp}');
                                },
                                child: Material(
                                    elevation: 8.0,
                                    shape: CircleBorder(),
                                    child:Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset('assets/img/whats.png',
                                        width: 35,
                                        height: 35,
                                      ),
                                    )
                                ),
                              ),
                            ),
                          ),
                      ],
                    )
                  ),
                ],
              ),
            ),
    );
  }

  Widget contactFormLayout() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: <Widget>[
            if (_loading) LinearProgressIndicator(),
            SizedBox(height: 8),
            NameEditText(
              value: profileModel != null && profileModel!.name != null
                  ? profileModel!.name
                  : '',
              updateName: (x) => inputName = x.toString(),
            ),
            SizedBox(height: 8),
            EmailEditText(
              value: profileModel != null && profileModel!.email != null
                  ? profileModel!.email
                  : '',
              updateEmail: (x) => inputEmail = x.toString(),
            ),
            SizedBox(height: 8),
            PhoneEditText(
              value: profileModel != null && profileModel!.phone != null
                  ? profileModel!.phone
                  : '',
              updatePhone: (x) => inputPhone = x.toString(),
            ),
            SizedBox(height: 8),
            MessageEditText(
              updateMessage: (x) => inputMessage = x.toString(),
            ),
            SizedBox(height: 20),
            submitButton(),
          ],
        ),
      ),
    );
  }

  Widget submitButton() {
    return InkWell(
      onTap: _loading ? null : submitForm,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32), color: kPrimaryColor),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              YemString.send,
              style: kWhiteTextColor,
            ),
          ),
        ),
      ),
    );
  }

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _loading = !_loading;
      });
      networkSendContactUs();
    }
  }

  void networkSendContactUs() async {
    setState(() {
      _loading = true;
    });

    YemenyPrefs prefs = YemenyPrefs();
    String? lang = await prefs.getLang();

    try {
      Dio dio = Dio();
      dio.interceptors.add(LogInterceptor(responseBody: true));
      dio.options.headers['Content-Language'] = lang;
      Map<String, dynamic> queryParameters = Map();
      queryParameters['name'] = inputName;
      queryParameters['email'] = inputEmail;
      queryParameters['phone'] = inputPhone;
      queryParameters['message'] = inputMessage;
      Response response = await dio
          .post(kContactUsApi, queryParameters: queryParameters)
          .whenComplete(() {});
      final basicJsonResponse = JsonBasicResponse.fromJson(response.data);
      if (basicJsonResponse.status == YemString.successNoTranslate) {
        // Flushbar(
        //   titleText: Text(
        //     YemString.success,
        //     style: kWhiteTextColor,
        //   ),
        //   message: YemString.success_send,
        //   duration: Duration(seconds: 2),
        //   flushbarPosition: FlushbarPosition.,
        //   backgroundColor: kPrimaryColor,
        // )..show(context);


        Alerts.showToast( YemString.success_send,Toast.LENGTH_LONG,ToastGravity.CENTER);

        setState(() {
          _loading = false;
          inputName = '';
          inputEmail = '';
          inputPhone = '';
          inputMessage = '';
        });
      } else {
        Flushbar(
          titleText: Text(
            YemString.error,
            style: kWhiteTextColor,
          ),
          message: basicJsonResponse.message,
          duration: Duration(seconds: 2),
          flushbarPosition: FlushbarPosition.TOP,
          backgroundColor: Colors.red,
        )..show(context);

        setState(() {
          _loading = false;
        });
      }
    } on DioError catch (e) {
      if (e.response != null) {
        Echo('e1 ${e.response!.data}');
        Echo('e2 ${e.response!.headers}');
        // Echo('e3 ${e.response.request}');
        final basicJsonResponse = JsonBasicResponse.fromJson(e.response!.data);

        Flushbar(
          titleText: Text(
            YemString.error,
            style: kWhiteTextColor,
          ),
          message: basicJsonResponse.message,
          duration: Duration(seconds: 2),
          flushbarPosition: FlushbarPosition.TOP,
          backgroundColor: Colors.red,
        )..show(context);
      } else {
        // Echo('e4 ${e.request}');
        Echo('e5 ${e.message}');

        Flushbar(
          titleText: Text(
            YemString.error,
            style: kWhiteTextColor,
          ),
          message: YemString.oopsSomethingWentWrong,
          duration: Duration(seconds: 2),
          flushbarPosition: FlushbarPosition.TOP,
          backgroundColor: Colors.red,
        )..show(context);
      }
      setState(() {
        _loading = !_loading;
      });
    }
  }
}
