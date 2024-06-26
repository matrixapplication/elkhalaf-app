import 'package:alkhalafsheep/models/payment_model.dart';
import 'package:alkhalafsheep/network_models/my_orders_response.dart';
import 'package:alkhalafsheep/network_models/payment_options_response.dart';
import 'package:alkhalafsheep/network_models/response_status.dart';
import 'package:alkhalafsheep/utilities/echo.dart';
import 'package:alkhalafsheep/utilities/mystrings.dart';
import 'package:dio/dio.dart';

import 'apis.dart';
import 'network_setup.dart';

Future<List<SingleOrder>?> networkMyOrders(int page,int oldOrder) async {
  Dio dio = await networkHeaderSetup(true);
  try {
    Map<String, dynamic> queryParameters = Map();
    queryParameters['page'] = '$page';
    queryParameters['oldOrders'] = oldOrder;

    queryParameters.forEach((key, value) {
      Echo('key=$key value=$value');
    });
    Response response = await dio.get(kMyOrders,queryParameters: queryParameters).whenComplete(() {});
    print('ssssee${response.toString()}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      JsonBasicResponse basicJsonResponse = JsonBasicResponse.fromJson(response.data);
      if (basicJsonResponse.status == YemString.successNoTranslate) {
        JsonMyOrdersResponse apiResponse = JsonMyOrdersResponse.fromJson(response.data);

        return apiResponse.data!.data;
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
