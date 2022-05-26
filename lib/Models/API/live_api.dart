import 'package:cloud_firestore/cloud_firestore.dart';

import '../LiveData.dart';
import '../LocalStorage/db_helper_sharedPrefrences.dart';

class LiveApi{
  FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;

  getLive(){
    return firebaseFireStore.collection("location").doc(CacheHelper.getString("ID")).snapshots().map((event){
      return LiveData(
        latitude_1 : event.data()!["latitude_1"] ,
        latitude_2 : event.data()!["latitude_2"] ,
        longitude_1 : event.data()!["longitude_1"] ,
        longitude_2 : event.data()!["longitude_2"] ,
        distance : event.data()!["distance"] ,
        cal : event.data()!["cal"],
        source : event.data()!["source"],
        destination : event.data()!["destination"],
      );
    });
  }
  stopLive()async{
    await firebaseFireStore.collection('location').doc(CacheHelper.getString("ID")).get().then((value){
      LiveData liveData = LiveData(
        latitude_1: value.data()!["latitude_1"],
        latitude_2: value.data()!["latitude_2"],
        longitude_1: value.data()!["longitude_1"],
        longitude_2: value.data()!["longitude_2"],
        distance: value.data()!["distance"],
        cal: value.data()!["cal"],
        source: value.data()!["source"],
        destination: value.data()!["destination"],
      );
      firebaseFireStore.collection('Users').doc(CacheHelper.getString("ID")).collection('location')
          .doc().set(liveData.toJson(), SetOptions(merge: true)).then((value){
        firebaseFireStore.collection('location').doc(CacheHelper.getString("ID")).delete();
      });
    });
  }
}