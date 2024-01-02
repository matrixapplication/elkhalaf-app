import 'package:flutter/foundation.dart';

class ProfileModel with ChangeNotifier {
  String? _name;
  String? _email;
  String? _phone;
  String? _id;
  String? _image;
  bool? _isAdmin;
  String? _tokenId;
  int? _cityId;
  String? _cityName;
  int? _countryId;
  String? _countryName;
  String? _fcmToken;


  bool? get isAdmin => _isAdmin;

  set isAdmin(bool? value) {
    _isAdmin = value;
    notifyListeners();

  }

  String? get fcmToken => _fcmToken;


  set fcmToken(String? value) {
    _fcmToken = value;
    notifyListeners();
  }

  String? get tokenId => _tokenId;

  set tokenId(String? value) {
    _tokenId = value;
    notifyListeners();
  }

  String? get image => _image;

  set image (String? value) {
    _image = value;
    notifyListeners();
  }

  String? get id => _id;

  set id(String? value) {
    _id = value;
    notifyListeners();
  }

  String? get email => _email;

  set email(String? value) {
    _email = value;
    notifyListeners();
  }
  String? get phone => _phone;

  set phone(String? value) {
    _phone = value;
    notifyListeners();
  }



  String? get name => _name;

  set name(String? value) {
    _name = value;
    notifyListeners();
  }

  String? get countryName => _countryName;

  set countryName(String? value) {
    _countryName = value;
    notifyListeners();
  }

  int? get countryId => _countryId;

  set countryId(int? value) {
    _countryId = value;
    notifyListeners();
  }

  String? get cityName => _cityName;

  set cityName(String? value) {
    _cityName = value;
    notifyListeners();
  }

  int? get cityId => _cityId;

  set cityId(int? value) {
    _cityId = value;
    notifyListeners();
  }


   clear(){
      _name =  null;
      _email =  null;
      _phone =  null;
      _id =  null;
      _image =  null;
      _tokenId =  null;
      _cityId =  null;
      _cityName =  null;
      _countryId =  null;
      _countryName =  null;
      _fcmToken =  null;
      notifyListeners();

   }
}
