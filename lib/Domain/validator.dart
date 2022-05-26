
class Validator {
  static String? email(String text){
    if(text.isEmpty){
      return "Required !" ;
    }else if(!text.endsWith("@gmail.com")){
      return "Invalid Email !" ;
    }else{
      return null;
    }
  }
  static String? name(String text){
    if(text.isEmpty){
      return "Required !" ;
    }else{
      return null;
    }
  }
  static String? password(String text){
    String pattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#%^&*_=+-]).{8,12}";
    RegExp regExp = RegExp(pattern);
    if(text.isEmpty){
      return "Required !" ;
    }else if (!regExp.hasMatch(text)){
      return "Weak Password";
    }
    else{
      return null;
    }
  }
}