import 'package:alkhalafsheep/_helpers/shared_pref.dart';
import 'package:alkhalafsheep/elements/auth_error.dart';
import 'package:alkhalafsheep/models/order_address_model.dart';
import 'package:alkhalafsheep/network/apis.dart';
import 'package:alkhalafsheep/network_models/addresses_response.dart';
import 'package:alkhalafsheep/network_models/cities_response.dart';
import 'package:alkhalafsheep/network_models/response_status.dart';
import 'package:alkhalafsheep/utilities/constants.dart';
import 'package:alkhalafsheep/utilities/echo.dart';
import 'package:alkhalafsheep/utilities/mystrings.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'cities_dropdown.dart';

class OrderAddressesController extends StatefulWidget {
  @override
  _OrderAddressesControllerState createState() => _OrderAddressesControllerState();
}

class _OrderAddressesControllerState extends State<OrderAddressesController> {
  List<SingleCity> cities = [];
  String? cityName;
  String? cityId;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: FutureBuilder<List<OrderAddressModel>?>(
        future: networkOrderAddresses(),
        builder: (BuildContext context, AsyncSnapshot<List<OrderAddressModel>?> snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: GestureDetector(
                          onTap: () {
                            showAddressDialog(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('إضافة عنوان جديد'),
                              Icon(Icons.add),
                            ],
                          )),
                    ),
                  ),
                  SizedBox(height: 12),
                  widgetOrderAddressesController(snapshot.data!),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return AuthErrorWidget();
          } else {
            return Center(
              child: Container(
                child: Text(YemString.loading),
              ),
            );
          }
        },
      )),
    );
  }

  Widget widgetOrderAddressesController(List<OrderAddressModel> orders) {
    return orders.length > 0
        ? SingleChildScrollView(
            child: Column(
            children: <Widget>[
              ...orders.map((e) {
                return WidgetSingleAddress(e);
              }).toList(),
            ],
          ))
        : Container();
  }

  Widget WidgetSingleAddress(OrderAddressModel e) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(8),
      child: ListTile(
        leading: Icon(Icons.location_on),
        title: Text(e.address!, style: kTextPrimaryHeader),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${YemString.homeNumber}: ${e.house_number}',
              style: kTextGreyBody,
            ),
            Text(
              '${YemString.city}: ${e.cityName}',
              style: kTextGreyBody,
            ),
          ],
        ),
        trailing: InkWell(
            onTap: () {
              networkDeletedOrderAddress(e.id);
            },
            child: Icon(
              Icons.delete,
              color: Colors.red[200],
            )),
      ),
    );
  }

  Future<List<OrderAddressModel>?> networkOrderAddresses() async {
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
          .get(
            kOrderAddresses,
          )
          .whenComplete(() {});
      final basicJsonResponse = JsonBasicResponse.fromJson(response.data);
      Echo('basicJsonResponse ${basicJsonResponse.status}');
      if (basicJsonResponse.status == YemString.successNoTranslate) {
        AddressesResponse apiResponse = AddressesResponse.fromJson(response.data);
        Echo('token ');

        List<OrderAddressModel> list = [];
        apiResponse.data!.map((e) {
          Echo('token ${e.address}');
          list.add(OrderAddressModel(
              id: e.id,
              address: e.address,
              user: e.user,
              isMain: e.isMain,
              house_number: e.houseNumber,
              cityId: e.city,
              cityName: e.cityName));
        }).toList();

        return list;
      } else {
        return null;
      }
    } on DioError catch (e) {
      return null;
    }
  }

  showAddressDialog(BuildContext context) {
    cityId = null;
    final _addressController = TextEditingController();
    final _homeNoController = TextEditingController();
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.orange,
            body: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,

                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('إضافة عنوان جديد',style: TextStyle(color: Colors.white,fontSize: 18)),
                  ),

                  Container(
                    margin: EdgeInsets.all(12),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(200)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.location_on,size: 50,color: Colors.white,),
                    ),
                  ),
                  Container(
                    decoration:BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    child: TextField(
                      decoration: InputDecoration( border: InputBorder.none,hintText: YemString.address),
                      minLines: 2,
                      maxLines: 3,
                      controller: _addressController,
                    ),
                  ),
                  Container(
                    decoration:BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    child: TextField(
                      decoration: InputDecoration(border: InputBorder.none,hintText: YemString.homeNumber),
                      keyboardType: TextInputType.number,
                      minLines: 1,
                      maxLines: 1,
                      controller: _homeNoController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CitiesDropDown(
                      city: cityName,
                      cities: cities,
                      updateCounty: (text) {
                        cityId = text;
                      },
                    ),
                  ),


                  GestureDetector(
                    onTap: () async {
                      final address = _addressController.text.trim();
                      final homeNumber = _homeNoController.text.trim();

                      if (address.isNotEmpty && homeNumber.isNotEmpty&& cityId != null && cityId!.isNotEmpty) {
                        networkAddNewAddress(address, homeNumber,cityId);
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      margin: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.grey, width: 0.8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            SizedBox(width: 20),
                            Text(
                              'إضافة',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('عودة',style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),

          );
        });
  }

  void networkAddNewAddress(String address, String homeNumber,String? cityId) async {
    YemenyPrefs prefs = YemenyPrefs();
    String? lang = await prefs.getLang();
    String? token = await prefs.getToken();

    try {
      Dio dio = Dio();
      dio.interceptors.add(LogInterceptor(responseBody: true));
      dio.options.headers['Content-Language'] = lang;
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers["authorization"] = "Bearer $token";

      Map<String, dynamic> queryParameters = Map();
      queryParameters['address'] = address;
      queryParameters['house_number'] = homeNumber;
      queryParameters['isMain'] = 1;
      queryParameters['city'] = cityId;
      queryParameters['id'] = cityId;
      queryParameters['city_id'] = cityId;

      Response response = await dio.post(kAddNewAddress, queryParameters: queryParameters).whenComplete(() {});

      final basicJsonResponse = JsonBasicResponse.fromJson(response.data);
      if (basicJsonResponse.status == YemString.successNoTranslate) {
        setState(() {});
      } else {}
    } on DioError catch (e) {}
  }

  void networkDeletedOrderAddress(int? id) async {
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
      queryParameters['isMain'] = 1;

      Response response = await dio
          .delete(
            '$kAddNewAddress/${id.toString()}',
          )
          .whenComplete(() {});

      final basicJsonResponse = JsonBasicResponse.fromJson(response.data);
      if (basicJsonResponse.status == YemString.successNoTranslate) {
        setState(() {});
      } else {}
    } on DioError catch (e) {}
  }
}
