import 'package:shared_preferences/shared_preferences.dart';
class CacheHelper{
  static late SharedPreferences sharedPreferences ;
  static init()async{
    sharedPreferences = await SharedPreferences.getInstance();
  }
  static setBool(key , value){
    sharedPreferences.setBool(key, value);
  }
  static getBool(key){
    return sharedPreferences.getBool(key) ?? false;
  }
  static setString (key , value){
    sharedPreferences.setString(key, value);
  }
  static getString (key){
    return sharedPreferences.getString(key) ?? "";
  }
}