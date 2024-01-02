import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:alkhalafsheep/UI/home/home_controller.dart';
import 'package:alkhalafsheep/UI/intro/intro_screen.dart';
import 'package:alkhalafsheep/_helpers/shared_pref.dart';
import 'package:alkhalafsheep/models/profile_model.dart';
import 'package:alkhalafsheep/network_models/checkout_response.dart';
import 'package:alkhalafsheep/network_models/main_response.dart';
import 'package:alkhalafsheep/network_models/payment_options_response.dart';
import 'package:alkhalafsheep/network_models/response_status.dart';
import 'package:alkhalafsheep/provider/cart_provider.dart';
import 'package:alkhalafsheep/provider/main_provider.dart';
import 'package:alkhalafsheep/utilities/echo.dart';
import 'package:alkhalafsheep/utilities/mystrings.dart';
import 'package:provider/provider.dart';

import 'apis.dart';
import 'network_setup.dart';

class NetworkRequests {

  Future<MainData?> main(BuildContext context) async {
    MainDataProvider mainDataProvider = Provider.of<MainDataProvider>(
        context, listen: false);
    if (mainDataProvider.mainData != null &&
        mainDataProvider.mainData!.products != null &&
        mainDataProvider.mainData!.products!.length > 0) {
      return mainDataProvider.mainData;
    }

    Dio dio = await networkHeaderSetup(false, timeout: 10);
    try {
      Response response = await dio.get(kMainApi).whenComplete(() {});

      if (response.statusCode == 200 || response.statusCode == 201) {
        JsonBasicResponse basicJsonResponse =
        JsonBasicResponse.fromJson(response.data);
        if (basicJsonResponse.status == YemString.successNoTranslate) {
          MainResponse apiResponse = MainResponse.fromMap(response.data);
          mainDataProvider.mainData = apiResponse.data;


          ProfileModel profileProvider =
          Provider.of<ProfileModel>(context, listen: false);
          YemenyPrefs pref = YemenyPrefs();
          String? token = await pref.getToken();
          if (token != null && token != '') {
            profileProvider.id = await pref.getUserId();
            profileProvider.name = await pref.getUserName();
            profileProvider.tokenId = token;
            profileProvider.email = await pref.getEmail();
            profileProvider.phone = await pref.getPhone();
            profileProvider.image = await pref.getPhoto();
            profileProvider.cityId = await pref.getCityId();
            profileProvider.cityName = await pref.getCityName();
            profileProvider.countryName = await pref.getCountryName();
            profileProvider.countryId = await pref.getCountryId();
            profileProvider.isAdmin = await pref.getIsTypeAdmin();
          }


          return apiResponse.data;
        } else {
          return Future.error('auth');
        }
      } else {
        return Future.error('server');
      }
    } on DioError catch (error) {
      return Future.error(networkHandleError(error));
    }
  }


  Future<PaymentMethods?> paymentOptionsRequest(BuildContext context) async {
    CartProvider cartProvider = Provider.of<CartProvider>(
        context, listen: false);

    Dio dio = await networkHeaderSetup(false, timeout: 10);
    try {
      Response response = await dio.post(kPaymentOptions,).whenComplete(() {});

      if (response.statusCode == 200 || response.statusCode == 201) {
        JsonBasicResponse basicJsonResponse =
        JsonBasicResponse.fromJson(response.data);
        if (basicJsonResponse.status == YemString.successNoTranslate) {
            JsonPaymentOptionsResponse apiResponse = JsonPaymentOptionsResponse.fromJson(response.data);

            return apiResponse.data;
        } else {
          return Future.error('auth');
        }
      } else {
        return Future.error('server');
      }
    } on DioError catch (error) {
      return Future.error(networkHandleError(error));
    }
  }
}

