import 'package:alkhalafsheep/models/payment_model.dart';
import 'package:alkhalafsheep/network_models/cities_response.dart';
import 'package:alkhalafsheep/network_models/my_orders_response.dart';
import 'package:alkhalafsheep/network_models/payment_options_response.dart';
import 'package:alkhalafsheep/network_models/response_status.dart';
import 'package:alkhalafsheep/utilities/mystrings.dart';
import 'package:dio/dio.dart';

import 'apis.dart';
import 'network_setup.dart';

Future<List<SingleCity>?> networkCities() async {
  Dio dio = await networkHeaderSetup(false);
  try {
    Response response = await dio.get(kCitiesApi).whenComplete(() {});


    if (response.statusCode == 200 || response.statusCode == 201) {
      JsonBasicResponse basicJsonResponse = JsonBasicResponse.fromJson(response.data);
      if (basicJsonResponse.status == YemString.successNoTranslate) {
        CitiesResponse apiResponse = CitiesResponse.fromMap(response.data);

        return apiResponse.data;
      } else {
        return Future.error('auth');
      }
    } else {
      return Future.error('auth');
    }
  } on DioError catch (error) {
    return Future.error(networkHandleError(error));
  }
}
