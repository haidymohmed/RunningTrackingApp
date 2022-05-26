import '../LocalStorage/db_helper_sharedPrefrences.dart';
import '../User.dart';

class UserLocalData{
  static setUser(UserData userData){
    CacheHelper.setString("Name", userData.fullName.toString());
    CacheHelper.setString("Password", userData.password.toString());
    CacheHelper.setString("Email", userData.email.toString());
    CacheHelper.setString("Gender", userData.gender.toString());
    CacheHelper.setString("ID", userData.id.toString());
  }
  static getUser(){
    UserData userData = UserData(
        email: CacheHelper.getString("Email"),
        password:  CacheHelper.getString("Password"),
        fullName: CacheHelper.getString("Name"),
        gender:CacheHelper.getString("Gender"),
        id: CacheHelper.getString("ID")
    );
    return userData;
  }
}