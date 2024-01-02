import 'package:shared_preferences/shared_preferences.dart';

class YemenyPrefs {
  /************    Skip     ****************/
  setSkipAuth(bool skipAuth) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('skipAuth', skipAuth);
  }
  Future<bool?> getSkipAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('skipAuth');
  }

  /************    FirstTimeVisit     ****************/
  setFirstTimeVisit(bool firstTimeVisit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('firstTimeVisit', firstTimeVisit);
  }
  Future<bool?> getFirstTimeVisit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('firstTimeVisit');
  }

  /************    CountryId     ****************/
  setCountryId(int countryId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('countryId', countryId);
  }
  Future<int?> getCountryId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('countryId');
  }

  /************    Country Name     ****************/
  setCountryName(String countryName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('countryName', countryName);
  }
  Future<String?> getCountryName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('countryName');
  }

  /************    CityId     ****************/
  setCityId(int cityId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('cityId', cityId);
  }
  Future<int?> getCityId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('cityId');
  }

  /************    City Name     ****************/
  setCityName(String cityName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('cityName', cityName);
  }
  Future<String?> getCityName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('cityName');
  }


  /************   User Id     ****************/
  setUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
  }
  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }
  /************   User Phone     ****************/
  setPhone(String phone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('phone', phone);
  }
  Future<String?> getPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('phone');
  }

  /************   User Name     ****************/
  setUserName(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', userName);
  }
  Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userName');
  }

  /************   User Lang     ****************/
  setLang(String lang) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('lang', lang);
  }
  Future<String?> getLang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('lang') == null ? 'ar' : prefs.getString('lang');
  }

  setEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
  }

  Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  /************   User Token     ****************/
  setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('remeber_token', token);
  }
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('remeber_token');
  }

  /************   User Photo     ****************/
  setPhoto(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('photoUrl', token);
  }
  Future<String?> getPhoto() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('photoUrl') == null
        ? ''
        : prefs.getString('photoUrl');
  }

  /************   User type 0 -> admin     ****************/
  setIsTypeAdmin(bool type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('type', type);
  }
  Future<bool?> getIsTypeAdmin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('type') == null
        ? false
        : prefs.getBool('type');
  }

  setFcmToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('fcmToken', token);
  }

  Future<String?> getFcmToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('fcmToken');
  }

  void logout() {
    setUserId('');
    setFirstTimeVisit(true);
    setEmail('');
    setSkipAuth(false);
    setToken('');
    setFcmToken('');
    setPhoto('');
    setPhone('');
    setUserName('');
  }
}
