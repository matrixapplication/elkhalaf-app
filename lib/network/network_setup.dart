import 'package:alkhalafsheep/_helpers/shared_pref.dart';
import 'package:alkhalafsheep/network_models/response_status.dart';
import 'package:alkhalafsheep/utilities/echo.dart';
import 'package:dio/dio.dart';


Future<Dio> networkHeaderSetup(bool requireAuth,{int timeout = 12}) async {
  YemenyPrefs prefs = YemenyPrefs();
  String? token = await prefs.getToken();
  String lang ='ar';

  Dio dio = new Dio();
  dio.options.connectTimeout = Duration(milliseconds: timeout * 1000);
  dio.interceptors.add(LogInterceptor(responseBody: true));
  dio.options.headers['content-Type'] = 'application/json';
  dio.options.headers['Content-Language'] = lang;
  if (token != null) dio.options.headers["authorization"] = "Bearer $token";

  if (requireAuth) {
    if (token == null) {
      return Future.error('auth');
    }
  }

  return dio;
}

String networkHandleError(DioError error) {
  switch (error.type) {
    case DioErrorType.connectionTimeout:
      Echo('e1 DioErrorType.CONNECT_TIMEOUT');
      return 'network';
    case DioErrorType.receiveTimeout:
      Echo('e1 DioErrorType.RECEIVE_TIMEOUT');
      return 'network';
    case DioErrorType.sendTimeout:
      Echo('e1 DioErrorType.SEND_TIMEOUT');
      return 'network';
    case DioErrorType.badResponse:
      Echo('e1 DioErrorType.RESPONSE');
      // return 'server';
      break;
    case DioErrorType.cancel:
      Echo('e1 DioErrorType.CANCEL');
      break;
    case DioErrorType.unknown:
      break;
    case DioExceptionType.badCertificate:
      // TODO: Handle this case.
      break;
    case DioExceptionType.connectionError:
      // TODO: Handle this case.
      break;
  }
  Echo('dio catch error -> ${error.type}');
  Echo('dio catch error -> ${error.message}');
  Echo('dio catch error -> ${error.error.toString()}');
  Echo('dio catch error -> ${error.error}');
  Echo('dio catch error -> ${error.response}');
  // Echo('dio catch error -> ${error.request}');
  Echo('dio catch error -> ${error.hashCode}');

  if (error.response!.statusCode == 404 ||error.response!.statusCode == 302)
    return 'auth';
  else if (error.response!.statusCode == 500)
    return 'server';
  else if (error.response != null) {
    JsonBasicResponse dateResponse = JsonBasicResponse.fromJson(error.response!.data);
    return '${dateResponse.message}';
  } else
    return 'network';
}