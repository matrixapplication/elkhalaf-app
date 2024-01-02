import 'package:flutter/foundation.dart';
import 'package:alkhalafsheep/network_models/main_response.dart';

class MainDataProvider with ChangeNotifier {
  MainData? _mainData;

  MainData? get mainData => _mainData;

  set mainData(MainData? value) {
    _mainData = value;
    notifyListeners();
  }
}