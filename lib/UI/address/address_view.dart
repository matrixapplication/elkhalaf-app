import 'package:alkhalafsheep/UI/address/city_dropdown.dart';
import 'package:alkhalafsheep/network_models/countries_response.dart';
import 'package:alkhalafsheep/utilities/constants.dart';
import 'package:alkhalafsheep/utilities/echo.dart';
import 'package:alkhalafsheep/utilities/mystrings.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import 'country_dropdown.dart';

class AddressView extends StatefulWidget {
  final submitForm;
  final bool? loading;
  final scaffoldKey;
  final formKey;
  final List<Datum>? countryList;
  final List<City>? cityList;

  AddressView({
    @override this.loading,
    @override this.scaffoldKey,
    @override this.formKey,
    @override this.submitForm,
    @override this.countryList,
    @override this.cityList,
  });

  @override
  _AddressViewState createState() => _AddressViewState();
}

class _AddressViewState extends State<AddressView> {
  String? inputCountryId;
  String? inputCityId;

  String? inputCountryName;
  String? inputCityName;

  @override
  void initState() {
    super.initState();
    Echo('initState ${widget.countryList!.length}');

   /* if (widget.countryList.length == 1) {
      inputCountryId = '${widget.countryList[0].id}';
      inputCountryName = '${widget.countryList[0].country}';
      setState(() {
        updateCountryFormSave(inputCountryId);
      });
    }*/

   /* if (widget.cityList.length == 1) {
      inputCityId = '${widget.cityList[0].id}';
      inputCityName = '${widget.cityList[0].city}';
      widget.submitForm(
        countryId: inputCountryId,
        cityId: inputCityId,
        countryName: inputCountryName,
        cityName: inputCityName,
      );
    }*/
  }

  @override
  Widget build(BuildContext context) {
    double devicePixRatio = MediaQuery.of(context).devicePixelRatio;

    return Scaffold(
      key: widget.scaffoldKey,
      body: addressLayout(devicePixRatio),
    );
  }

  updateCountryFormSave(String id) {
    Echo('updateCountryFormSave $id');
    inputCountryId = id;
    inputCityId = null;
    widget.countryList!.map((e) {
      if ('${e.id}' == inputCountryId) {
        widget.cityList!.clear();
        e.cities!.map((e) {
          if ('${e.countryId}' == inputCountryId) {
            widget.cityList!.add(new City(id: e.id, city: e.city));
          }
        }).toList();
      }
    }).toList();

    setState(() {
      inputCityId = null;
      widget.cityList;
      inputCountryId;
    });
  }

  updateCityFormSave(String text) {
    //Save countryName And cityName
    widget.countryList!.map((e) {
      if ('${e.id}' == inputCountryId) {
        inputCountryName = e.country;
        e.cities!.map((e) {
          if ('${e.id}' == inputCityId) {
            inputCityName = e.city;
          }
        }).toList();
      }
    }).toList();

    setState(() {
      inputCityId = text;
    });
  }

  Widget addressLayout(double devicePixRatio) {
    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              logoHeroAnim(devicePixRatio),
              SizedBox(height: 4),
              addressFormLayout(),
            ],
          ),
        ),
      ),
    );
  }

  Hero logoHeroAnim(double devicePixRatio) {
    return Hero(
      tag: "logo",
      child: Image.asset(
        kLogoPath,
        height: 180,
      ),
    );
  }

  Widget addressFormLayout() {
    return Form(
      key: widget.formKey,
      child: Column(
        children: <Widget>[
          widget.loading!
              ? Container(
                  margin: EdgeInsets.symmetric(horizontal: 18),
                  child: LinearProgressIndicator())
              : Container(),
         /* widget.countryList.length == 1
              ? Container()
              : */Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: CountryDropDown(
                      updateCountry: updateCountryFormSave,
                      value: inputCountryId,
                      countryList: widget.countryList,
                    ),
                  ),
                ),
          Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: CityDropDown(
                updateCity: updateCityFormSave,
                value: inputCityId,
                cityList: widget.cityList,
              ),
            ),
          ),
          SizedBox(height: 10),
          submitButton(),
        ],
      ),
    );
  }

  Widget submitButton() {
    return GFButton(
      color: kPrimaryColor,
      onPressed: widget.loading!
          ? null
          : () {
              if (inputCityId != null && inputCountryId != null) if (widget
                  .formKey.currentState
                  .validate()) {
                widget.formKey.currentState.save();
                widget.submitForm(
                  countryId: inputCountryId,
                  cityId: inputCityId,
                  countryName: inputCountryName,
                  cityName: inputCityName,
                );
              }
            },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Text(
          YemString.continuez,
          style: kWhiteTextColor,
        ),
      ),
    );
  }
}
