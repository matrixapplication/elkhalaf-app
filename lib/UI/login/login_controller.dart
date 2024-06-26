import 'package:alkhalafsheep/UI/admin/admin_orders_controller.dart';
import 'package:alkhalafsheep/UI/register/register_controller.dart';
import 'package:alkhalafsheep/_helpers/shared_pref.dart';
import 'package:alkhalafsheep/models/profile_model.dart';
import 'package:alkhalafsheep/network/apis.dart';
import 'package:alkhalafsheep/network_models/login_response.dart';
import 'package:alkhalafsheep/network_models/response_status.dart';
import 'package:alkhalafsheep/utilities/echo.dart';
import 'package:alkhalafsheep/utilities/mystrings.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home/home_controller.dart';
import 'login_view.dart';

class LoginController extends StatefulWidget {
  static const id = 'login';

  @override
  _LoginControllerState createState() => _LoginControllerState();
}

class _LoginControllerState extends State<LoginController> {
  bool _loading = false;
  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return LoginView(
      formKey: _formKey,
      loading: _loading,
      scaffoldKey: _scaffoldKey,
      submitForm: this.submitForm,
      navigateForgetPassword: this.navigateForgetPassword,
      navigateSignUp: this.navigateSignUp,
    );
  }

  void submitForm(String phone, String password) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _loading = !_loading;
      });
      networkLogin(phone, password);
    }
  }

  void navigateForgetPassword() {}

  void navigateSignUp() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => RegisterController(),
        transitionsBuilder: (context, animation1, animation2, child) =>
            FadeTransition(opacity: animation1, child: child),
        transitionDuration: Duration(milliseconds: 600),
      ),
    );
  }

  void admin() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => AdminOrdersController(),
        ),
            (route) => false);
  }

  void goToHome() {
    Navigator.pushNamedAndRemoveUntil(
        context, HomeController.id, (Route<dynamic> route) => false);
  }

  void networkLogin(String phone, String password) async {
    try {
      Echo('1');
      Dio dio = Dio();
      dio.interceptors.add(LogInterceptor(responseBody: true));
      Map<String, dynamic> queryParameters = Map();
      queryParameters['phone'] = phone;
      queryParameters['password'] = password;

      Response response = await dio
          .post(kLoginApi, queryParameters: queryParameters)
          .whenComplete(() {});
      final basicJsonResponse = JsonBasicResponse.fromJson(response.data);
      if (basicJsonResponse.status == YemString.successNoTranslate) {
        final loginResponse = JsonLoginResponse.fromJson(response.data);
        YemenyPrefs prefs = YemenyPrefs();
        await prefs.setUserName(loginResponse.data?.name??'');
        await prefs.setEmail(loginResponse.data?.email??'');
        await prefs.setPhone(loginResponse.data?.phone??'');
        await prefs.setToken(loginResponse.data?.token??'');
        await prefs.setUserId('${loginResponse.data?.id??0.0}');
        await prefs.setPhoto(loginResponse.data?.avatar??'');
        await prefs
            .setIsTypeAdmin(loginResponse.data!.type == 0 ? true : false);

        Provider.of<ProfileModel>(context, listen: false).id =
            '${loginResponse.data!.id}';
        Provider.of<ProfileModel>(context, listen: false).email =
            '${loginResponse.data!.email}';
        Provider.of<ProfileModel>(context, listen: false).tokenId =
            loginResponse.data!.token;
        Provider.of<ProfileModel>(context, listen: false).name =
            loginResponse.data!.name;
        Provider.of<ProfileModel>(context, listen: false).phone =
            loginResponse.data!.phone;
        Provider.of<ProfileModel>(context, listen: false).image =
            loginResponse.data!.avatar;
        Provider.of<ProfileModel>(context, listen: false).isAdmin =
            loginResponse.data!.type == 0 ? true : false;

        if (loginResponse.data!.type == 0)
          admin();
        else
          goToHome();
      } else {
        _scaffoldKey.currentState!.showSnackBar(SnackBar(
          content: Text(basicJsonResponse.message!),
        ));
        setState(() {
          _loading = !_loading;
        });
      }
    } on DioError catch (e) {
      if (e.response != null) {
        Echo('e1 ${e.response!.data}');
        Echo('e2 ${e.response!.headers}');
        // Echo('e3 ${e.response.request}');
        final basicJsonResponse = JsonBasicResponse.fromJson(e.response!.data);
        _scaffoldKey.currentState!.showSnackBar(SnackBar(
          content: Text(basicJsonResponse.message!),
        ));
      } else {
        // Echo('e4 ${e.request}');
        Echo('e5 ${e.message}');
        _scaffoldKey.currentState!.showSnackBar(SnackBar(
          content: Text(YemString.oopsSomethingWentWrong),
        ));
      }
      setState(() {
        _loading = !_loading;
      });
    }
  }
}
