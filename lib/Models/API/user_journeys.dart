
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_final/Models/LiveData.dart';
import 'package:task_final/Presentation/Modules/home.dart';

import '../LocalStorage/db_helper_sharedPrefrences.dart';

class UserJourneysAPI{
  FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;
  getJourneys(){
    List<LiveData> list = <LiveData>[];
    return firebaseFireStore.collection('Users').doc(CacheHelper.getString("ID")).collection('location').snapshots().map((event) {
      event.docs.forEach((element) {
        list.add(
            LiveData.fromJson(element.data())
        );
      });
      return list;
    });
  }
}