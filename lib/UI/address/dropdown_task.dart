/*
import 'package:flutter/material.dart';

class DropDownTask extends StatelessWidget {
  final Function updateLanguage;
  final String value;
  final String title;
  final IconData iconData;
  final List<Subject> subjectList;
  final List<Language> sourceLang;
  final List<Language> destLang;
  final List<OrderType> orderTypeList;

  DropDownTask(
      {@required this.updateLanguage,
      @required this.value,
      @required this.iconData,
      @required this.subjectList,
      @required this.sourceLang,
      @required this.destLang,
      @required this.orderTypeList,
      @required this.title});

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> _dropDownMenuItems;
    if (subjectList != null)
      _dropDownMenuItems = subjectList.map((singleSubject) {
        return DropdownMenuItem<String>(
          value: singleSubject.name,
          child: Text(singleSubject.name),
        );
      }).toList();
    if (sourceLang != null)
      _dropDownMenuItems = sourceLang.map((singleSubject) {
        return DropdownMenuItem<String>(
          value: singleSubject.lang,
          child: Text(singleSubject.lang),
        );
      }).toList();
    if (destLang != null)
      _dropDownMenuItems = destLang.map((singleSubject) {
        return DropdownMenuItem<String>(
          value: singleSubject.lang,
          child: Text(singleSubject.lang),
        );
      }).toList();
    if (orderTypeList != null)
      _dropDownMenuItems = orderTypeList.map((singleSubject) {
        return DropdownMenuItem<String>(
          value: '${singleSubject.name}',
          child: Text(singleSubject.name),
        );
      }).toList();

    String userTypeOnError = 'Invalid input';
    String validate(text) {
      return value.length > 0 ? null : userTypeOnError;
    }

    return DropdownButtonFormField<String>(
      autovalidate: false,
      isDense: true,
      decoration: InputDecoration(
        border: InputBorder.none,
        labelText: title,
        labelStyle: TextStyle(fontSize: 13),
        icon: Icon(iconData),
      ),
      items: _dropDownMenuItems,
      value: value,
      onChanged: updateLanguage,
      onSaved: updateLanguage,
      validator: (text) {
        return validate(text);
      },
    );
  }
}
*/
