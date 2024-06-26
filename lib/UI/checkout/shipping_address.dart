import 'package:alkhalafsheep/UI/checkout/payment_methods_controller.dart';
import 'package:alkhalafsheep/UI/order_addresses/cities_dropdown.dart';
import 'package:alkhalafsheep/_helpers/shared_pref.dart';
import 'package:alkhalafsheep/components/loading_widget.dart';
import 'package:alkhalafsheep/models/order_address_model.dart';
import 'package:alkhalafsheep/network/apis.dart';
import 'package:alkhalafsheep/network/cities_request.dart';
import 'package:alkhalafsheep/network_models/addresses_response.dart';
import 'package:alkhalafsheep/network_models/cities_response.dart';
import 'package:alkhalafsheep/network_models/response_status.dart';
import 'package:alkhalafsheep/provider/cart_provider.dart';
import 'package:alkhalafsheep/utilities/constants.dart';
import 'package:alkhalafsheep/utilities/mystrings.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../utilities/constants.dart';
import '../google_map/address_location_model.dart';
import '../google_map/custom_google_map.dart';

class ShippingAddress extends StatefulWidget {
  static const String id = 'shipping_address';

  @override
  _ShippingAddressState createState() => _ShippingAddressState();
}

class _ShippingAddressState extends State<ShippingAddress> {
  List<OrderAddressModel> orderAddressModel = [];
  List<SingleCity>? cities = [];
  int? _shippingAddressId = 0;
  bool _loading = true;
  bool errorPage = false;
  String? selectedAddress = '';
  double selectedLatitude = 0;
  double selectedLongitude = 0;
  final _addressController = TextEditingController();
  final _homeNoController = TextEditingController();
  String? cityName;
  String? cityId;
  AddressLocationModel? selectedPlace;
  var _scaffold = new GlobalKey<ScaffoldState>();

 
  @override
  void initState() {
    networkOrderAddresses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColor,
      child: SafeArea(
        child: Scaffold(
            key: _scaffold,
            appBar: AppBar(
                title: Text(
                  YemString.shippingAddress,
                  style: kWhiteTextColor,
                ),
                backgroundColor: kPrimaryColor,
                centerTitle: true),
            body: _loading
                  ? LoadingWidget(isItProgressIndicator: true)
                  : errorPage
                      ? Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(YemString.network_issue),
                              Text(YemString.swipeDownToRefresh),
                            ],
                          ),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 4.0,
                              ),
                              Container(
                                  color: Colors.grey.shade200,
                                  padding: EdgeInsets.all(8.0),
                                  margin: EdgeInsets.all(12),
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(YemString.deliver_address
                                          .toUpperCase()),
                                      InkWell(
                                          onTap: () {
                                            showAddressDialog(context);
                                          },
                                          child: Text(
                                            YemString.add_new_address
                                                .toUpperCase(),
                                            style: TextStyle(
                                                color: Colors.blueAccent),
                                          )),
                                    ],
                                  )),
                              Column(
                                children: <Widget>[
                                  if (orderAddressModel.length < 1)
                                    Card(
                                      margin: EdgeInsets.all(16),
                                      elevation: 2,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Container(
                                            margin: const EdgeInsets.all(10.0),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: kPrimaryColor,
                                                    width: 0.5),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4))),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: TextField(
                                                decoration: InputDecoration(
                                                  hintText: YemString.address,
                                                  border: InputBorder.none,
                                                ),
                                                minLines: 3,
                                                maxLines: 6,
                                                controller: _addressController,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.all(10.0),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: kPrimaryColor,
                                                    width: 0.5),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(4))),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: TextField(
                                                decoration: InputDecoration(
                                                  hintText:
                                                      YemString.homeNumber,
                                                  border: InputBorder.none,
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                                minLines: 1,
                                                maxLines: 1,
                                                controller: _homeNoController,
                                              ),
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
                                              final address = _addressController
                                                  .text
                                                  .trim();
                                              final homeNumber =
                                                  _homeNoController.text.trim();

                                              if (address.isNotEmpty &&
                                                  homeNumber.isNotEmpty &&
                                                  cityId != null &&
                                                  cityId!.isNotEmpty) {
                                                networkAddNewAddress(address,
                                                    homeNumber, cityId);
                                              }
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8),
                                              margin: EdgeInsets.all(12),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: kPrimaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                    color: Colors.grey,
                                                    width: 0.8),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.check,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(width: 20),
                                                    Text(
                                                      'حفظ',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ...orderAddressModel.map((e) {
                                    return RadioListTile(
                                      selected: true,
                                      value: e.id,
                                      groupValue: _shippingAddressId,
                                      title: Text(
                                        e.address!,
                                        style: kTextBlackBody,
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                      onChanged: (dynamic value) {
                                        setState(() {
                                          _shippingAddressId = value;
                                        });
                                      },
                                    );
                                  }).toList(),
                                ],
                              ),

                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Divider(),
                              ),
                              //

                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        color: selectedLatitude == 0
                                            ? kPrimarySwatchColor
                                            : Colors.green,
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: Colors.grey, width: 0.8),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 8),
                                        child: InkWell(
                                          child: Text(
                                              selectedLatitude == 0
                                                  ? YemString.locationOnMap
                                                  : YemString.pickedOnMapDone,
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          onTap: () async {
                                            // bool status = await locationPermission();
                                            // if(!status) return;
                                            //
                                            LocationPermission per = await Geolocator.checkPermission();

                                            if (per ==
                                                LocationPermission.deniedForever) return;
                                            if (per == LocationPermission.denied) {
                                              LocationPermission per2 =
                                                  await Geolocator
                                                      .requestPermission();
                                              if (per2 ==
                                                      LocationPermission
                                                          .denied ||
                                                  per2 ==
                                                      LocationPermission
                                                          .deniedForever)
                                                return;
                                            }

                                            Position position = await Geolocator
                                                .getCurrentPosition();
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                            CustomGoogleMapScreen(lat: position.latitude, long: position.longitude,
                                              onTap: (AddressLocationModel addressModel) {
                                              setState(() {
                                                selectedLatitude =double.parse('${addressModel.lat.toString()}');
                                                selectedLongitude =double.parse('${addressModel.long.toString()}');
                                                selectedPlace =addressModel;
                                                Navigator.pop(context);
                                              });
                                                return Future.value(true);
                                              },
                                            )
                                            ));
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //     builder: (context) {
                                            //       return PlacePicker(
                                            //         apiKey:
                                            //             'AIzaSyCBCiEuSLzUEH9sAPCY50fR02diH_hXGTs',
                                            //         initialPosition: LatLng(
                                            //             position.latitude,
                                            //             position.longitude),
                                            //         useCurrentLocation: true,
                                            //         selectInitialPosition:
                                            //             false,
                                            //         usePlaceDetailSearch: false,
                                            //         pinBuilder:
                                            //             (context, state) {
                                            //           if (state ==
                                            //               PinState.Idle) {
                                            //             return Icon(
                                            //                 Icons.location_on,
                                            //                 color:
                                            //                     kPrimaryColor,
                                            //                 size: 40);
                                            //           } else {
                                            //             return Icon(
                                            //                 Icons.location_on,
                                            //                 color:
                                            //                     kPrimaryColor2,
                                            //                 size: 40);
                                            //           }
                                            //         },
                                            //
                                            //         selectedPlaceWidgetBuilder:
                                            //             (_, selectedPlace, state, isSearchBarFocused) {
                                            //           return FloatingCard(
                                            //             bottomPosition: 0.0,
                                            //             // MediaQuery.of(context) will cause rebuild. See MediaQuery document for the information.
                                            //             leftPosition: 0.0,
                                            //             rightPosition: 0.0,
                                            //             width: 200,
                                            //             borderRadius:
                                            //                 BorderRadius
                                            //                     .circular(12.0),
                                            //             child: Container(
                                            //               margin: EdgeInsets.all(8),
                                            //             decoration: BoxDecoration(
                                            //             color: selectedLatitude == 0
                                            //               ? kPrimarySwatchColor
                                            //                   : Colors.green,
                                            //               borderRadius: BorderRadius.circular(12),
                                            //               border: Border.all(
                                            //               color: Colors.grey, width: 0.8),
                                            //             ),
                                            //               child: GestureDetector(
                                            //                   onTap: () {
                                            //                     if(selectedPlace != null) {
                                            //                       selectedLatitude = selectedPlace.geometry!.location.lat;
                                            //                       selectedLongitude =selectedPlace.geometry!.location.lng;
                                            //
                                            //                       selectedAddress = selectedPlace.formattedAddress;
                                            //                       Navigator.of(
                                            //                           context)
                                            //                           .pop();
                                            //
                                            //                       setState(() {});
                                            //                     }
                                            //                   },
                                            //                   child: Padding(
                                            //                     padding: const EdgeInsets.all(8.0),
                                            //                     child: Center(child: Text("تحديد",style: TextStyle(color: Colors.white),)),
                                            //                   )),
                                            //
                                            //             ),
                                            //           );
                                            //         },
                                            //         //forceSearchOnZoomChanged: true,
                                            //         //automaticallyImplyAppBarLeading: false,
                                            //         //autocompleteLanguage: "ko",
                                            //         //region: 'au',
                                            //         //selectInitialPosition: true,
                                            //         // selectedPlaceWidgetBuilder: (_, selectedPlace, state, isSearchBarFocused) {
                                            //         //   print("state: $state, isSearchBarFocused: $isSearchBarFocused");
                                            //         //   return isSearchBarFocused
                                            //         //       ? Container()
                                            //         //       : FloatingCard(
                                            //         //           bottomPosition: 0.0, // MediaQuery.of(context) will cause rebuild. See MediaQuery document for the information.
                                            //         //           leftPosition: 0.0,
                                            //         //           rightPosition: 0.0,
                                            //         //           width: 500,
                                            //         //           borderRadius: BorderRadius.circular(12.0),
                                            //         //           child: state == SearchingState.Searching
                                            //         //               ? Center(child: CircularProgressIndicator())
                                            //         //               : RaisedButton(
                                            //         //                   child: Text("Pick Here"),
                                            //         //                   onPressed: () {
                                            //         //                     // IMPORTANT: You MUST manage selectedPlace data yourself as using this build will not invoke onPlacePicker as
                                            //         //                     //            this will override default 'Select here' Button.
                                            //         //                     print("do something with [selectedPlace] data");
                                            //         //                     Navigator.of(context).pop();
                                            //         //                   },
                                            //         //                 ),
                                            //         //         );
                                            //         // },
                                            //
                                            //         // },
                                            //       );
                                            //     },
                                            //   ),
                                            // );
                                          },
                                        ),
                                      ),
                                    ),
                                    selectedPlace == null
                                        ? Container()
                                        : Text('${selectedPlace!.city ?? ""}${selectedPlace!.street ?? ""}'),
                                  ],
                                ),
                              ),

                              if (selectedAddress != null && selectedAddress!.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text('$selectedAddress'),
                                ),
                              if (selectedLatitude != 0)
                                Text('$selectedLatitude , $selectedLongitude'),
                              GestureDetector(
                                onTap: () {
                                  if (_shippingAddressId == 0 &&
                                      selectedLatitude == 0) {
                                    Flushbar(
                                      titleText: Text(''),
                                      message: 'يرجي اختيار/اضافة عنوان الشحن ',
                                      duration: Duration(seconds: 2),
                                      flushbarPosition: FlushbarPosition.BOTTOM,
                                      backgroundColor: Colors.red,
                                    )..show(context);
                                    return;
                                  } else {
                                    CartProvider cartProvider =
                                        Provider.of<CartProvider>(context,
                                            listen: false);
                                    cartProvider.shippingId =
                                        '${_shippingAddressId}';
                                    Navigator.of(context)
                                        .pushNamed(PaymentOptionsController.id);
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  margin: EdgeInsets.all(12),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: kPrimarySwatchColor,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: Colors.grey, width: 0.8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(
                                        YemString.continuez,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
           ),
      ),
    );
  }

  networkOrderAddresses() async {
    cities = await networkCities();
    orderAddressModel.clear();
    YemenyPrefs prefs = YemenyPrefs();
    String? lang = await prefs.getLang();
    String? token = await prefs.getToken();

    try {
      Dio dio = Dio();
      dio.interceptors.add(LogInterceptor(responseBody: true));
      dio.options.headers['Content-Language'] = lang;
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers["authorization"] = "Bearer $token";
      Response response = await dio
          .get(
            kOrderAddresses,
          )
          .whenComplete(() {});
      final basicJsonResponse = JsonBasicResponse.fromJson(response.data);
      if (basicJsonResponse.status == YemString.successNoTranslate) {
        AddressesResponse apiResponse =
            AddressesResponse.fromJson(response.data);

        List<OrderAddressModel> list = [];
        apiResponse.data!.map((e) {
          list.add(OrderAddressModel(
              id: e.id,
              address: e.address,
              user: e.user,
              isMain: e.isMain,
              house_number: e.houseNumber,
              cityId: e.city,
              cityName: e.cityName));
        }).toList();

        orderAddressModel = list;
        setState(() {
          _loading = false;
          errorPage = false;
        });
      } else {}
    } on DioError catch (e) {
      setState(() {
        _loading = false;
        errorPage = true;
      });
    }
  }

  void networkAddNewAddress(
      String address, String homeNumber, String? cityId) async {
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

      Response response = await dio
          .post(kAddNewAddress, queryParameters: queryParameters)
          .whenComplete(() {});

      final basicJsonResponse = JsonBasicResponse.fromJson(response.data);
      if (basicJsonResponse.status == YemString.successNoTranslate) {
        refreshPage();
      } else {}
    } on DioError catch (e) {}
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
                    child: Text('إضافة عنوان جديد',
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                  Container(
                    margin: EdgeInsets.all(12),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(200)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.location_on,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: YemString.address),
                      minLines: 2,
                      maxLines: 3,
                      controller: _addressController,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: YemString.homeNumber),
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

                      if (address.isNotEmpty &&
                          homeNumber.isNotEmpty &&
                          cityId != null &&
                          cityId!.isNotEmpty) {
                        networkAddNewAddress(address, homeNumber, cityId);
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
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          Text('عودة', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void refreshPage() {
    orderAddressModel.clear();
    setState(() {
      _loading = true;
      errorPage = false;
    });

    networkOrderAddresses();
  }

  Future<bool> locationPermission() async {
    var status = await Permission.location.status;
    if (status.isGranted) {
      return true;
    } else {
      var status = await Permission.location.request();
      if (status.isGranted) {
        return true;
      } else {
        return false;
      }
    }
  }
}
