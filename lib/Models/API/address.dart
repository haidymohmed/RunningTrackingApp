import 'dart:convert';
import 'package:http/http.dart' as https;

class AddressAPI {
  set(lat , lng)async{
    var response = await https.get(Uri.parse("https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=AIzaSyDZ29dnr2Ts2TSH8jHvIbGzFLajHd7ETwo"));
    var body = jsonDecode(response.body);
    AddressData addressData =AddressData(
        streetNumber: "",
        route: "",
        neighborhood: "",
    );
    print(response.runtimeType.toString());
    print(body["results"].runtimeType.toString());
    try{
      if(body["results"]["status"] == "ok"){
        addressData = AddressData(
            streetNumber: body["results"][0]["address_components"][0]["short_name"],
            route: body["results"][0]["address_components"][1]["short_name"],
            neighborhood: body["results"][0]["address_components"][2]["short_name"]
        );
        print("API : DONE");
      }else{
      }
    }catch(e){
      print("API : ${e.toString()}");
      print("API : Faild");
      print(e.toString());
    }
    return addressData ;
  }
}
class AddressData {
  late String streetNumber ,route , neighborhood;
  AddressData({required this.streetNumber , required this.route ,required this.neighborhood});
}