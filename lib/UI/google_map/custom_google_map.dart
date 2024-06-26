import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../main.dart';
import 'address_location_model.dart';
import 'custom_elevated_button.dart';
import 'custom_text_field.dart';
import 'package:geocoding/geocoding.dart';
typedef OnTap = Future<bool> Function(AddressLocationModel addressModel);

class CustomGoogleMapScreen extends StatefulWidget {
  final double lat;
  final double long;
  final OnTap onTap; // Added onReplyTap
  const CustomGoogleMapScreen({super.key, required this.lat, required this.long, required this.onTap});

  @override
  State<CustomGoogleMapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<CustomGoogleMapScreen> {
  late GoogleMapController mapController;
  LatLng? markerPosition; // Initial position (San Francisco)
  @override
  void initState() {
    markerPosition =LatLng(widget.lat, widget.long);
    getAddressPosition(LatLng(widget.lat, widget.long));
    super.initState();
  }
  TextEditingController searchController = TextEditingController();
   var getLat='';
   var getLong='';
   var getCountry='';
   var getBigCity='';
   var getCity='';
   var getLocality='';
   var getStreet='';
  var titlePosition='';
  LatLng? currentPosition;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('الخريطة',
        style: TextStyle(
          fontSize: 25,
          decoration: TextDecoration.none,
          fontWeight: FontWeight.w700,
        ),
        )),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding:  EdgeInsets.symmetric(vertical: 10,horizontal: 16),
            child: CustomTextField(
                hintText: 'بحث',
                controller: searchController,
                prefixIcon:
                Icon(Icons.search_sharp, color: Colors.grey.shade400),
                onFieldSubmitted: (String val){
                  _searchPlace();
                },
                textInputAction: TextInputAction.search,
                borderColor: Colors.grey.shade300),
          ),
          Expanded(
            child:
            GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                setState(() {
                  mapController = controller;
                });
              },
              onTap: (LatLng position) {
                _updateMarker(position);
                getAddressPosition(position);
              },
              initialCameraPosition: CameraPosition(
                target: markerPosition!,
                zoom: 14.0,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('markerId'),
                  infoWindow: InfoWindow(title: titlePosition),
                  position: markerPosition!,
                  draggable: true,
                  onDragEnd: (LatLng newPosition) {
                    _updateMarker(newPosition);
                  },
                ),
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25 ,vertical: 10),
            child: Container(
              height: 40,
              width: MediaQuery.of(context).size.width*0.9,
              decoration:BoxDecoration(
                   borderRadius: BorderRadius.circular(40)),
              child: CustomElevatedButton(
                borderRadius: 8,
                  width: MediaQuery.of(context).size.width*0.9,
                  backgroundColor: Theme.of(context).primaryColor,
                  onTap: ()async{
                  // if(getCountry.isEmpty){
                  //   LatLng latLng=LatLng(widget.lat, widget.long);
                  //   setState(() {
                  //     getAddressPosition(latLng);
                  //   });
                  // }
                    AddressLocationModel addressModel =AddressLocationModel(
                      lat: getLat.isEmpty?widget.lat.toString():getLat ,
                      long: getLong.isEmpty?widget.long.toString():getLong,
                      country: getCountry.isEmpty?'':getCountry,
                      bigCity: getBigCity.isEmpty?'':getBigCity,
                      city: getCity.isEmpty?'':getCity,
                      street: getStreet.isEmpty?'':getStreet,
                      locality: getLocality.isEmpty?'':getLocality,
                    );
                    await widget.onTap(addressModel);
                  },
                  fontSize: 20,
                  buttonText: 'حفظ'),
            ),
          ),

        ],
      ),
    );
  }
  Future<void> getAddressPosition(LatLng position)async {
    List<Placemark> p = await placemarkFromCoordinates(position.latitude, position.longitude);
    // print(p[0].country);
    // print(p[0].administrativeArea);
    // print(p[0].locality);
    // print(p[0].street);
    // print(p[0].name);
    // print(p[0].subAdministrativeArea);
    setState(() {
      getCountry=p[0].country.toString();
      getBigCity=p[0].administrativeArea.toString();
      getCity=p[0].subAdministrativeArea.toString();
      getLocality=p[0].locality.toString();
      getStreet=p[0].street.toString();
      titlePosition = '${p[0].street}';
    });
  }
  void _updateMarker(LatLng newPosition) {
    setState((){
      getAddressPosition(newPosition);
      getLat=newPosition.latitude.toString();
      getLong=newPosition.longitude.toString();
      appLatLng=newPosition;
      currentPosition=newPosition;
      markerPosition = newPosition;
    });
  }
  Future<void> _searchPlace() async {
    try {

      List<Location> locations = await locationFromAddress(searchController.text);
      LatLng latLng =LatLng(locations.first.latitude, locations.first.longitude);
      if (locations.isNotEmpty) {
        mapController.animateCamera(
          CameraUpdate.newLatLng(latLng),
        );
        _updateMarker(latLng);
      } else {
         print('No location found for the provided address.');
      }
    } catch (e) {
       print('Error during geocoding: $e');
    }
  }

}

