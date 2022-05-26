import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_final/Models/API/userDataLocalStorage.dart';
import '../User.dart';

class AuthAPI {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firebaseFireStore =FirebaseFirestore.instance;
  logInWithGoogle(UserData userData) async{
    return auth.signInWithEmailAndPassword(email: userData.email, password: userData.password);
  }
  createAccount(UserData userData)async{
    return await auth.createUserWithEmailAndPassword(email: userData.email, password: userData.password);
  }
  getCurrentUserId(){
    return auth.currentUser?.uid;
  }
  bool getUserData(String id){
    firebaseFireStore.collection("Users").doc(id.toString()).snapshots().listen((event) {
      UserData userData = UserData(
            fullName: event.data()!["Name"].toString(),
            id:  event.data()!["Id"].toString(),
            gender:  int.parse(event.data()!["Gender"].toString()),
            password:  event.data()!["Password"].toString(),
            email:  event.data()!["Email"].toString(),
          );
      UserLocalData.setUser(userData);
    }).onError((e){
      return false ;
    });
    return true ;
  }
  saveUserData(UserData userData) async{
    getCurrentUserId();
    return await firebaseFireStore.collection("Users").doc(userData.id).set(userData.toJson());
  }
}