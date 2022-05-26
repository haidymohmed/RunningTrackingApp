
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import '../LiveData.dart';
import '../LocalStorage/db_helper_sharedPrefrences.dart';

class LocationApi{
  FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;
  setLocation(LiveData liveData) async{
    return await firebaseFireStore.collection('location').doc(CacheHelper.getString("ID")).set(liveData.toJson(), SetOptions(merge: true));
  }
  setShortLocation(LiveData liveData)async{
    await Location().getLocation().then((value) {
      GeoCode().reverseGeocoding(
        longitude: value.longitude!,
        latitude: value.latitude!,
      ).then((value) {
        liveData.destination =  value.streetNumber!.toString() +" st " + value.streetAddress! + value.countryName! + ", " + value.city! ;
      }).catchError((onError){
        print(onError.toString());
      });
    });
    return await firebaseFireStore.collection("location").doc(CacheHelper.getString("ID")).update({
      "longitude_2" : liveData.longitude_2 ,
      "latitude_2" : liveData.latitude_2 ,
      "distance" : liveData.distance ,
      "destination" : liveData.destination
    });
  }
}