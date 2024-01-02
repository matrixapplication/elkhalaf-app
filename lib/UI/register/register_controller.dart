import 'dart:io';

import 'package:alkhalafsheep/UI/login/login_controller.dart';
import 'package:alkhalafsheep/_helpers/shared_pref.dart';
import 'package:alkhalafsheep/models/profile_model.dart';
import 'package:alkhalafsheep/network/apis.dart';
import 'package:alkhalafsheep/network_models/register_response.dart';
import 'package:alkhalafsheep/network_models/response_status.dart';
import 'package:alkhalafsheep/utilities/echo.dart';
import 'package:alkhalafsheep/utilities/mystrings.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home/home_controller.dart';
import 'register_model.dart';
import 'register_view.dart';
import 'verification_code_controller.dart';

class RegisterController extends StatefulWidget {
  static const id = 'register';

  @override
  _RegisterControllerState createState() => _RegisterControllerState();
}

class _RegisterControllerState extends State<RegisterController> {
  RegisterModel? model;
  bool _loading = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RegisterView(
      formKey: _formKey,
      loading: _loading,
      scaffoldKey: _scaffoldKey,
      submitForm: this.submitForm,
      navigateSignIn: this.navigateSignIn,
    );
  }

  void submitForm({
    String? name,
//    String email,
    String? phone,
    String? password,
    String? countryId,
  }) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _loading = !_loading;
      });
      networkRegister(
        name: name,
//        email: email,
        phone: phone!,
        password: password,
        country: countryId,
      );
    }
  }

  void navigateForgetPassword() {}

  void navigateSignIn() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => LoginController(),
        transitionsBuilder: (context, animation1, animation2, child) =>
            FadeTransition(opacity: animation1, child: child),
        transitionDuration: Duration(milliseconds: 600),
      ),
    );
  }



  void networkRegister({
    String? name,
    String? email,
    required String phone,
    String? password,
    String? country,
  }) async {
    YemenyPrefs prefs = YemenyPrefs();
    int? countryId = await prefs.getCountryId();
    int? cityId = await prefs.getCityId();

    try {
      Dio dio = Dio();
      dio.interceptors.add(LogInterceptor(responseBody: true));
      Map<String, dynamic> queryParameters = Map();
      queryParameters['name'] = name;
      if(phone.startsWith('0',0)){
        phone.replaceFirst('0', '',0);
        queryParameters['phone'] = phone;
      }else{
        queryParameters['phone'] = phone;
      }
      queryParameters['password'] = password;
      queryParameters['password_confirmation'] = password;
      if (countryId != null) queryParameters['country'] = countryId;
      if (cityId != null) queryParameters['city'] = cityId;

      Response response = await dio
          .post(kRegisterApi, queryParameters: queryParameters)
          .whenComplete(() {
        setState(() {
          _loading = false;
        });
      });
      final basicJsonResponse = JsonBasicResponse.fromJson(response.data);
      if (basicJsonResponse.status == YemString.successNoTranslate) {
        final registerResponse = JsonRegisterResponse.fromJson(response.data);
        YemenyPrefs prefs = YemenyPrefs();
        await prefs.setUserName(registerResponse.data!.name!);
        await prefs.setPhone(registerResponse.data!.phone!);
        await prefs.setToken(registerResponse.data!.token!);
        await prefs.setUserId('${registerResponse.data!.id}');

        Provider.of<ProfileModel>(context, listen: false).id =
        '${registerResponse.data!.id}';
        Provider.of<ProfileModel>(context, listen: false).tokenId =
            registerResponse.data!.token;
        Provider.of<ProfileModel>(context, listen: false).name =
            registerResponse.data!.name;
        Provider.of<ProfileModel>(context, listen: false).phone =
            registerResponse.data!.phone;
        Navigator.pushNamedAndRemoveUntil(
            context, HomeController.id, (Route<dynamic> route) => false);

//        Navigator.push(
//          context,
//          PageRouteBuilder(
//            pageBuilder: (context, animation1, animation2) => VerificationCodeController(registerResponse: registerResponse,),
//            transitionsBuilder: (context, animation1, animation2, child) =>
//                FadeTransition(opacity: animation1, child: child),
//            transitionDuration: Duration(milliseconds: 600),
//          ),
//        );

      } else {
        _scaffoldKey.currentState!.showSnackBar(SnackBar(
          content: Text(basicJsonResponse.message!),
        ));
      }

      print(basicJsonResponse.status);
    } on DioError catch (e) {
      setState(() {
        _loading = false;
      });

      if (e.response != null) {
        Echo('e1 ${e.response!.data}');
        Echo('e2 ${e.response!.headers}');
        // Echo('e3 ${e.response.request}');

        final basicJsonResponse = JsonBasicResponse.fromJson(e.response!.data);
        if(basicJsonResponse == null){
          _scaffoldKey.currentState!.showSnackBar(SnackBar(
            content: Text(YemString.oopsSomethingWentWrong),
          ));

        }else{
          _scaffoldKey.currentState!.showSnackBar(SnackBar(
            content: Text(basicJsonResponse.message!),
          ));

        }

      } else {
        // Echo('e4 ${e.request}');
        Echo('e5 ${e.message}');
        _scaffoldKey.currentState!.showSnackBar(SnackBar(
          content: Text(YemString.oopsSomethingWentWrong),
        ));
      }
    }
  }
}
