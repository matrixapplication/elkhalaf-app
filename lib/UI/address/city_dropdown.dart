import 'package:alkhalafsheep/network_models/countries_response.dart';
import 'package:alkhalafsheep/utilities/mystrings.dart';
import 'package:flutter/material.dart';

class CityDropDown extends StatelessWidget {
  final Function? updateCity;
  final String? value;
  final List<City>? cityList;

  CityDropDown({this.updateCity, this.value, this.cityList});

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuItem<String>> _dropDownMenuItems =
        cityList!.map((city) {
      return DropdownMenuItem<String>(
        value: '${city.id}',
        child: Container(
            width: 200,
            child: Text(
              '${city.city}',
              overflow: TextOverflow.ellipsis,
            )),
      );
    }).toList();

    String cityPlaceHolder = YemString.city;
    String cityHint = YemString.city;
    String cityOnError = YemString.select_valid_city;

    String? validate(text) {
      return value!.length > 0 ? null : cityOnError;
    }

    return DropdownButtonFormField<String>(
      autovalidate: false,
      isDense: true,
      decoration: InputDecoration(
        icon: Icon(Icons.location_city),
        border: InputBorder.none,
        labelText: cityPlaceHolder,
        labelStyle: TextStyle(fontSize: 13),
        hintText: cityHint,
      ),
      items: _dropDownMenuItems,
      value: value,
      onChanged: updateCity as void Function(String?)?,
      onSaved: updateCity as void Function(String?)?,
      validator: (text) {
        return validate(text);
      },
    );
  }
}
