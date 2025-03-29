// ignore_for_file: prefer_if_null_operators
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/repository/repository.dart';

class LocalStorageController extends GetxController {
  final Repository repository;
  LocalStorageController({required this.repository});

  SharedPreferences? localStorage;

  @override
  void onInit() async {
    super.onInit();
    localStorage = await SharedPreferences.getInstance();
  }

  // save local value functions ------------------------------------------
  saveStringToLocal(String key, String value) async {
    await localStorage!.setString(key, value);
  }

  saveIntToLocal(String key, int value) {
    localStorage!.setInt(key, value);
  }

  saveBooleanToLocal(String key, bool value) {
    localStorage!.setBool(key, value);
  }

  saveDoubleToLocal(String key, double value) {
    localStorage!.setDouble(key, value);
  }

  saveListToLocal(String key, List<String> value) async {
    localStorage!.setStringList(key, value);
  }

  saveUserId(String key, String value) {
    localStorage!.setString(key, value);
  }
// ----------------------------------------------------------------------

  // get local value functions ------------------------------------------
  String getStringFromLocal(String key) {
    String value = localStorage!.getString(key) == null
        ? ''
        : localStorage!.getString(key)!;

    return value;
  }

  int getIntFromLocal(String key) {
    int value =
        localStorage!.getInt(key) == null ? 0 : localStorage!.getInt(key)!;
    return value;
  }

  bool getBooleanFromLocal(String key) {
    bool value = localStorage!.getBool(key) == null
        ? false
        : localStorage!.getBool(key)!;
    return value;
  }

  double getDoubleFromLocal(String key) {
    double value = localStorage!.getDouble(key)!;
    return value;
  }

  getListFromLocal(String key) {
    return localStorage!.getStringList(key);
  }

  getUserId() {
    return "";
  }
  // ----------------------------------------------------------------------

  // remove from local storage function
  removeFromLocal(String key) async {
    await localStorage!.remove(key);
  }

  deleteAllValues() {
    localStorage!.clear();
  }
}
