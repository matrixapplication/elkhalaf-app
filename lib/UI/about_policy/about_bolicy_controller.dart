import 'package:alkhalafsheep/_helpers/shared_pref.dart';
import 'package:alkhalafsheep/components/loading_widget.dart';
import 'package:alkhalafsheep/network/apis.dart';
import 'package:alkhalafsheep/network_models/about_policy_response.dart';
import 'package:alkhalafsheep/network_models/response_status.dart';
import 'package:alkhalafsheep/utilities/constants.dart';
import 'package:alkhalafsheep/utilities/mystrings.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class AboutPolicyController extends StatefulWidget {
  static const id = 'about';
  final String? pageId;

  AboutPolicyController({this.pageId});

  @override
  _AboutPolicyControllerState createState() => _AboutPolicyControllerState();
}

class _AboutPolicyControllerState extends State<AboutPolicyController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text(
              widget.pageId == 'about' ? YemString.about : YemString.policy_terms,
              style: kWhiteTextColor,
            ),
            backgroundColor: kPrimaryColor,
            centerTitle: true),
        body: FutureBuilder<JsonAboutAndPolicyResponse?>(
          future: networkGetPageData(),
          builder: (BuildContext context,
              AsyncSnapshot<JsonAboutAndPolicyResponse?> snapshot) {
            if (snapshot.hasData) {
              //show Data
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      ...snapshot.data!.data!.map((e) {
                        return HtmlWidget(
                          snapshot.data!.data!.first.content!,
                          onTapUrl: (url) => showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text('onTapUrl'),
                              content: Text(url),
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
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
        ),
      ),
    );
  }

  Future<JsonAboutAndPolicyResponse?> networkGetPageData() async {
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
//      queryParameters['page'] = '1';

      Response response = await dio
          .get('$kAboutPolicy/${widget.pageId}',
              queryParameters: queryParameters)
          .whenComplete(() {});
      final basicJsonResponse = JsonBasicResponse.fromJson(response.data);
      if (basicJsonResponse.status == YemString.successNoTranslate) {
        JsonAboutAndPolicyResponse apiResponse =
            JsonAboutAndPolicyResponse.fromJson(response.data);

        return apiResponse;
      } else {
        return null;
      }
    } on DioError catch (e) {
      return null;
    }
  }
}
