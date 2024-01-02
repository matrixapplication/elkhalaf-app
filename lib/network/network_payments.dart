import 'package:alkhalafsheep/models/payment_model.dart';
import 'package:alkhalafsheep/network_models/payment_options_response.dart';
import 'package:alkhalafsheep/network_models/response_status.dart';
import 'package:alkhalafsheep/utilities/mystrings.dart';
import 'package:dio/dio.dart';

import 'apis.dart';
import 'network_setup.dart';

Future<List<PaymentModel>> networkPaymentOptions() async {
  Dio dio = await networkHeaderSetup(false);
  try {
    Response response = await dio.post(kPaymentOptions).whenComplete(() {});

    if (response.statusCode == 200 || response.statusCode == 201) {
      JsonBasicResponse basicJsonResponse = JsonBasicResponse.fromJson(response.data);
      if (basicJsonResponse.status == YemString.successNoTranslate) {
        JsonPaymentOptionsResponse apiResponse = JsonPaymentOptionsResponse.fromJson(response.data);
        List<PaymentModel> list = [];
        apiResponse.data!.data!.map((e) {
          list.add(PaymentModel(
              id: e.id,
              name: e.name,
              branchCountry: e.branchCountry,
              branchNumber: e.branchNumber,
              ibanNumber: e.ibanNumber,
              logo: e.logo,
              number: e.number,
              serviceName: e.serviceName));
        }).toList();
        return list;
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
