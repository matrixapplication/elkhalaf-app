import 'package:alkhalafsheep/UI/home/home_controller.dart';
import 'package:alkhalafsheep/_helpers/shared_pref.dart';
import 'package:alkhalafsheep/components/loading_widget.dart';
import 'package:alkhalafsheep/network/apis.dart';
import 'package:alkhalafsheep/network_models/countries_response.dart';
import 'package:alkhalafsheep/network_models/response_status.dart';
import 'package:alkhalafsheep/utilities/echo.dart';
import 'package:alkhalafsheep/utilities/mystrings.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'address_view.dart';

class AddressController extends StatefulWidget {
  static const id = 'address';

  @override
  _AddressControllerState createState() => _AddressControllerState();
}

class _AddressControllerState extends State<AddressController> {
//  AddressModel model;
  bool _loading = false;
  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  final _formKey = GlobalKey<FormState>();
  List<City> cityList = [];

  @override
  void initState() {
    networkGetCountries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Datum>?>(
      future: networkGetCountries(),
      builder: (BuildContext context, AsyncSnapshot<List<Datum>?> snapshot) {
        if (snapshot.hasData) {
          return AddressView(
            formKey: _formKey,
            loading: false,
            scaffoldKey: _scaffoldKey,
            submitForm: this.submitForm,
            countryList: snapshot.data,
            cityList: cityList,
          );
        } else if (snapshot.hasError) {
          //show error
          return LoadingWidget(
            isItProgressIndicator: true,
            isItVerticalList: true,
          );
        } else {
          //show Loading
          return LoadingWidget(
            isItProgressIndicator: true,
            isItVerticalList: true,
          );
        }
      },
    );
  }

  void refreshPage() {
    setState(() {});
  }

  void submitForm(
      {required String countryId,
      required String cityId,
      required String countryName,
      required String cityName}) async {
    //save data
    YemenyPrefs prefs = new YemenyPrefs();
    await prefs.setCountryId(int.parse(countryId));
    await prefs.setCountryName(countryName);
    await prefs.setCityId(int.parse(cityId));
    await prefs.setCityName(cityName);

    goToHome();
  }

  void goToHome() {
    Navigator.pushNamedAndRemoveUntil(
        context, HomeController.id, (Route<dynamic> route) => false);
  }

  Future<List<Datum>?> networkGetCountries() async {
    YemenyPrefs prefs = YemenyPrefs();
    String? lang = await prefs.getLang();

    try {
      Dio dio = Dio();
      dio.interceptors.add(LogInterceptor(responseBody: true));
      dio.options.headers['Content-Language'] = lang;

      Response response = await dio.get(kCountryApi);
      final basicJsonResponse = JsonBasicResponse.fromJson(response.data);
      if (basicJsonResponse.status == YemString.successNoTranslate) {
        final jsonResponse = JsonCountriesResponse.fromJson(response.data);

        return jsonResponse.data;
      } else {
        _scaffoldKey.currentState!.showSnackBar(SnackBar(
          content: Text(basicJsonResponse.message!),
        ));
        return null;
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
      return null;
    }
  }
}
