import 'package:gender_picker/source/enums.dart';

class UserData{
  late String fullName ;
  late String email ;
  late String password ;
  late int gender;
  late String? id ;
  UserData({ required this.fullName , required this.email , required this.id,required this.password ,required this.gender});
  toJson(){
    return {
      "Name" : fullName,
      "Email" : email,
      "Password" : password,
      "Gender" : gender,
      "Id" : id,
    };
  }
  UserData.fromJson(data){
    fullName = data["fullName"];
    email = data["email"];
    password = data["password"];
    gender = data["gender"];
    id = data["id"];
  }
}
