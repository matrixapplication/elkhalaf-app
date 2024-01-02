
import 'package:alkhalafsheep/UI/register/password_edit_text.dart';
import 'package:alkhalafsheep/_helpers/shared_pref.dart';
import 'package:alkhalafsheep/components/loading_widget.dart';
import 'package:alkhalafsheep/models/profile_model.dart';
import 'package:alkhalafsheep/network/apis.dart';
import 'package:alkhalafsheep/network_models/profile_response.dart';
import 'package:alkhalafsheep/network_models/response_status.dart';
import 'package:alkhalafsheep/utilities/constants.dart';
import 'package:alkhalafsheep/utilities/echo.dart';
import 'package:alkhalafsheep/utilities/mystrings.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static const id = "profile";

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var scaffoldKey;
  final formKey = GlobalKey<FormState>();

  String? inputUserName = '';
  String? inputPhone = '';
  String? inputPassword = '';
  String inputOldPassword = '';
  String? inputConfirmPassword = '';

  @override
  void initState() {
    super.initState();
  }

  updateUserNameOnFormSave(String? text) {
    inputUserName = text;
  }

  updateUserPhoneOnFormSave(String? text) {
    inputPhone = text;
  }

  updateUserConfirmPasswordOnFormSave(String? text) {
    inputConfirmPassword = text;
  }

  updatePasswordOnFormSave(String? text) {
    inputPassword = text;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            title: Text(YemString.profile, style: kWhiteTextColor),
            backgroundColor: kPrimaryColor,
            centerTitle: true,
          ),
          body:
          FutureBuilder<ProfileModel?>(
            future: networkGetProfile(),
            builder: (BuildContext context,
                AsyncSnapshot<ProfileModel?> snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 20),
                      Image.asset(
                        kLogoPath,
                        height: 140,
                      ),
                      registerFormLayout(),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                //show error
                return LoadingWidget(isItProgressIndicator: true,isItVerticalList: true,);
              } else {
                //show Loading
                return LoadingWidget(isItProgressIndicator: true,isItVerticalList: true,);
              }
            },
          ),


        ),
      ),
    );
  }

  Widget registerFormLayout() {
    FocusNode focusNodeEmail = new FocusNode();
    FocusNode focusNodePhone = new FocusNode();
    FocusNode focusNodePassword = new FocusNode();
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 12),
            Material(
              elevation: 2.0,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: TextFormField(
                initialValue: inputUserName,
                decoration: InputDecoration(

                    border: InputBorder.none,
                    errorStyle: TextStyle(),
                    labelStyle: TextStyle(color: Colors.grey[500]),
                    hintStyle:TextStyle(color: Colors.grey[500]),
//                  labelText: YemString.name,
                  hintText: YemString.name,
                  counterStyle: TextStyle(color: Colors.green),
                    prefixIcon: Material(
                      elevation: 0,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: Icon(
                        Icons.person,
                        color: kPrimaryColor,
                      ),
                    ),
                    enabled: false,
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 25, vertical: 13)
                ),
                keyboardType: TextInputType.text,
                validator: (text) {
                  return text!.length < 2 ? YemString.invalid_name : null;
                },
                textInputAction: TextInputAction.next,
                onSaved: updateUserNameOnFormSave,
                onFieldSubmitted: (String value) {
                  FocusScope.of(context).requestFocus(focusNodeEmail);
                },
              ),
            ),
            SizedBox(height: 12),
            Material(
              elevation: 2.0,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: TextFormField(
                initialValue: inputPhone,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelStyle: TextStyle(color: Colors.grey[500]),
                  hintStyle:TextStyle(color: Colors.grey[500]),
//                  labelText: YemString.phone,
                  hintText: YemString.phone,
                    prefixIcon: Material(
                      elevation: 0,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: Icon(
                        Icons.phone,
                        color: kPrimaryColor,
                      ),
                    ),
                    enabled: false,
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 25, vertical: 13)
                ),
                keyboardType: TextInputType.phone,
                validator: (text) {
                  bool isItShort = text!.length > 5;
                  return isItShort ? null : YemString.invalid_phone;
                },
                onSaved: updateUserPhoneOnFormSave,
              ),
            ),
            SizedBox(height: 12),
            Material(
              elevation: 2.0,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: TextFormField(
                decoration: InputDecoration(
                    border: InputBorder.none,
//                  labelText: YemString.confirmation_password,
                    hintText: 'كلمة السر الحالية',
                    prefixIcon: Material(
                      elevation: 0,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: Icon(
                        Icons.lock,
                        color: kPrimaryColor,
                      ),
                    ),
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 25, vertical: 13)
                ),
                obscureText: obscurePassword,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                validator: (text) {
                  bool passwordValid = text!.length > 7;
                  return passwordValid ? null : YemString.invalid_password;
                },
                onSaved: updateUserConfirmPasswordOnFormSave,
              ),
            ),
            SizedBox(height: 12),
            Material(
              elevation: 2.0,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: TextFormField(
                decoration: InputDecoration(
                    border: InputBorder.none,
//                  labelText: YemString.password,
                  hintText: 'كلمة السر الجديدة',
                    prefixIcon: Material(
                      elevation: 0,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: Icon(
                        Icons.lock,
                        color: kPrimaryColor,
                      ),
                    ),
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 25, vertical: 13)
                ),
                obscureText: obscurePassword,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                validator: (text) {
                  bool passwordValid = text!.length > 7;
                  return passwordValid ? null : YemString.invalid_password;
                return null;
                },
                onSaved: updatePasswordOnFormSave,
                onChanged: updatePasswordOnFormSave,
              ),
            ),
            SizedBox(height: 12),
            Material(
              elevation: 2.0,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
//                  labelText: YemString.confirmation_password,
                  hintText: YemString.confirmation_password,
                  prefixIcon: Material(
                    elevation: 0,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: Icon(
                      Icons.lock,
                      color: kPrimaryColor,
                    ),
                  ),
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 25, vertical: 13)
                ),
                obscureText: obscurePassword,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                validator: (text) {
                  if (inputPassword != text) {
                    return YemString.confirmation_password_not_valid;
                  } else {
                    return null;
                  }
                },
                onSaved: updateUserConfirmPasswordOnFormSave,
              ),
            ),

            SizedBox(height: 20),
            submitButton(),
          ],
        ),
      ),
    );
  }

  Widget submitButton() {
    return  GestureDetector(
      onTap: (){

        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          Flushbar(
            titleText: Text(''),
            message: YemString.updateing_data,
            duration: Duration(seconds: 2),
            flushbarPosition: FlushbarPosition.BOTTOM,
            backgroundColor: Colors.green,
          )..show(context);

          networkEditProfile(
            name: inputUserName,
            phone: inputPhone,
            password: inputPassword,
            oldPassword:  inputOldPassword,
          );
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        margin: EdgeInsets.all(12),
        width: double.infinity,
        decoration: BoxDecoration(
          color:kPrimarySwatchColor ,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey, width: 0.8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.edit,color: Colors.white,),
                SizedBox(width: 12),
                Text( YemString.update,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void networkEditProfile({String? name, String? phone, String? password, String? oldPassword}) async {

    YemenyPrefs prefs = YemenyPrefs();
    String? lang = await prefs.getLang();
    String? token = await prefs.getToken();

    try {
      Dio dio = Dio();
      dio.interceptors.add(LogInterceptor(responseBody: true));
      dio.options.headers['Content-Language'] = lang;
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers["authorization"] = "Bearer ${token}";

      Map<String, dynamic> queryParameters = Map();
      queryParameters['name'] = name;
      queryParameters['old_password'] = oldPassword;
      queryParameters['password'] = password;
      queryParameters['password_confirmation'] = password;

      Response response = await dio
          .post(kUpdateProfile, queryParameters: queryParameters)
          .whenComplete(() {});

      final basicJsonResponse = JsonBasicResponse.fromJson(response.data);
      if (basicJsonResponse.status == YemString.successNoTranslate) {
        YemenyPrefs prefs = YemenyPrefs();
        await prefs.setUserName(name!);
        await prefs.setPhone(phone!);

        Provider.of<ProfileModel>(context, listen: false).name = name;
        Provider.of<ProfileModel>(context, listen: false).phone = phone;

        Flushbar(
          titleText: Text(''),
          message: YemString.data_changed_successfully,
          duration: Duration(seconds: 2),
          flushbarPosition: FlushbarPosition.BOTTOM,
          backgroundColor: Colors.green,
        )..show(context);

      } else {
      }
    } on DioError catch (e) {

    }
  }
  Future<ProfileModel?> networkGetProfile() async {

    YemenyPrefs prefs = YemenyPrefs();
    String? lang = await prefs.getLang();
    String? token = await prefs.getToken();

    try {
      Dio dio = Dio();
      dio.interceptors.add(LogInterceptor(responseBody: true));
      dio.options.headers['Content-Language'] = lang;
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers["authorization"] = "Bearer ${token}";


      Response response = await dio
          .get(kGetProfile)
          .whenComplete(() {});

      final basicJsonResponse = JsonBasicResponse.fromJson(response.data);
      if (basicJsonResponse.status == YemString.successNoTranslate) {
        final jsonResponse = JsonProfileResponse.fromJson(response.data);



        YemenyPrefs prefs = YemenyPrefs();
        await prefs.setUserName(jsonResponse.data!.name!);
        await prefs.setEmail(jsonResponse.data!.email);
        await prefs.setPhone(jsonResponse.data!.phone!);
        await prefs.setUserId('${jsonResponse.data!.id}');
        await prefs.setPhoto(jsonResponse.data!.avatar);

        Provider.of<ProfileModel>(context, listen: false).id =
        '${jsonResponse.data!.id}';
        Provider.of<ProfileModel>(context, listen: false).email =
        '${jsonResponse.data!.email}';
        Provider.of<ProfileModel>(context, listen: false).name =
            jsonResponse.data!.name;
        Provider.of<ProfileModel>(context, listen: false).phone =
            jsonResponse.data!.phone;
        Provider.of<ProfileModel>(context, listen: false).image =
            jsonResponse.data!.avatar;

        inputPhone = jsonResponse.data!.phone;
        inputUserName = jsonResponse.data!.name;



        ProfileModel profileModel = new ProfileModel();
        profileModel.name = inputUserName;
        profileModel.phone = inputPhone;
        return profileModel;
      } else {

      }
      return null;
    } on DioError catch (e) {

      return null;
    }
  }
}
