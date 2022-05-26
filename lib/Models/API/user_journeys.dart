import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_final/Models/LiveData.dart';
import '../LocalStorage/db_helper_sharedPrefrences.dart';


class UserJourneysAPI{
  FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;
  getJourneys(){
    return firebaseFireStore.collection('Users').doc(CacheHelper.getString("ID")).collection('location').snapshots().map((event) {
      List<LiveData> list = [];
      for (var element in event.docs) {
        list.add(
            LiveData.fromJson(element.data())
        );
      }
      return list;
    });
  }
}