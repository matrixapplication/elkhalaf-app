import 'package:alkhalafsheep/network_models/countries_response.dart';
import 'package:alkhalafsheep/utilities/mystrings.dart';
import 'package:flutter/material.dart';

class CountryDropDown extends StatelessWidget {
  final Function? updateCountry;
  final String? value;
  final List<Datum>? countryList;

  CountryDropDown({this.updateCountry, this.value, this.countryList});

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuItem<String>> _dropDownMenuItems =
        countryList!.map((country) {
      return DropdownMenuItem<String>(
        value: '${country.id}',
        child: Container(
            width: 200,
            child: Text(
              '${country.country}',
              overflow: TextOverflow.ellipsis,
            )),
      );
    }).toList();

    String countryPlaceHolder = YemString.country;
    String countryHint = YemString.country;
    String countryOnError = YemString.select_valid_country;

    String? validate(text) {
      return value!.length > 0 ? null : countryOnError;
    }

    return DropdownButtonFormField<String>(
      autovalidateMode: AutovalidateMode.disabled,
      isDense: true,
      decoration: InputDecoration(
        icon: Icon(Icons.flag),
        border: InputBorder.none,
        labelText: countryPlaceHolder,
        labelStyle: TextStyle(fontSize: 13),
      ),
      items: _dropDownMenuItems,
      value: value,
      onChanged: updateCountry as void Function(String?)?,
      onSaved: updateCountry as void Function(String?)?,
      validator: (text) {
        return validate(text);
      },
    );
  }
}
