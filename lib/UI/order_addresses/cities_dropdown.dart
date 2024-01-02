import 'package:alkhalafsheep/elements/CircularLoadingWidget.dart';
import 'package:alkhalafsheep/network/cities_request.dart';
import 'package:alkhalafsheep/network_models/cities_response.dart';
import 'package:alkhalafsheep/utilities/constants.dart';
import 'package:alkhalafsheep/utilities/mystrings.dart';
import 'package:flutter/material.dart';

class CitiesDropDown extends StatefulWidget {
  final String? city;
  final updateCounty;
  final List<SingleCity>? cities;

  CitiesDropDown({this.city, this.updateCounty, this.cities});

  @override
  _CitiesDropDownState createState() => _CitiesDropDownState();
}

class _CitiesDropDownState extends State<CitiesDropDown> {
  var key = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SingleCity>?>(
      key: key,
      future: networkCities(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.length > 0) {
            return Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.orange, width: 0.6)),
              child: CountryDropDown(
                iconData: Icons.flag,
                list: snapshot.data,
                value: widget.city,
                hint: YemString.city,
                validateFunc: (text) {
                  return text != null && text.length > 0
                      ? null
                      : YemString.select_valid_city;
                },
                updateFunc: (text) {
                  widget.updateCounty(text);
                },
              ),
            );
          } else {
            return GestureDetector(
              onTap: () {
                key = new GlobalKey();
                setState(() {});
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(YemString.noInternetConnection),
                    Text(YemString.retry),
                  ],
                ),
              ),
            );
          }
        } else if (snapshot.hasError) {
          return GestureDetector(
            onTap: () {
              setState(() {});
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(YemString.noInternetConnection,
                      style: TextStyle(color: Colors.white)),
                  Text(YemString.retry, style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          );
        } else {
          return CircularLoadingWidget();
        }
      },
    );
  }
}

class CountryDropDown extends StatelessWidget {
  final Function? updateFunc;
  final Function? validateFunc;
  final String? value;
  final String? hint;
  final List<SingleCity>? list;
  final IconData? iconData;

  CountryDropDown({
    this.updateFunc,
    this.value,
    this.hint,
    this.validateFunc,
    this.list,
    this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuItem<String>> _dropDownMenuItems = list!.map((item) {
      return DropdownMenuItem<String>(
        value: '${item.id}',
        child: Container(
            width: 120,
            child: Text(
              '${item.city}',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14, color: Colors.black),
            )),
      );
    }).toList();

//    String validate(text) {
//      if(value !=null)
//      return value.length > 0 ? null : error;
//      else return null;
//    }

    return Material(
      elevation: 2.0,
      color: Colors.white,
      borderRadius: BorderRadius.all(
        Radius.circular(4),
      ),
      child: DropdownButtonFormField<String>(
        isDense: true,
        focusColor: kPrimaryColor,
        decoration: InputDecoration(
            border: InputBorder.none,
            errorStyle: TextStyle(fontSize: 10, color: Colors.black),
            hintStyle: TextStyle(fontSize: 14, color: Colors.black),
            labelStyle: TextStyle(fontSize: 14, color: Colors.black),
            hintText: hint,
            prefixIcon: Icon(
              iconData,
              color: kPrimaryColor,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
        items: _dropDownMenuItems,
        value: value,
        onChanged: updateFunc as void Function(String?)?,
        onSaved: updateFunc as void Function(String?)?,
        validator: validateFunc as String? Function(String?)?,
      ),
    );
  }
}
