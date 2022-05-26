import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Models/API/AuthAPI.dart';
import '../../Models/User.dart';
import 'login_status.dart';

class LogInCubit extends Cubit<LogInStatus>{
  LogInCubit() : super(LogInLoading());
  AuthAPI auth = AuthAPI();
  static LogInCubit get(context) => BlocProvider.of(context);
  logIn(UserData userData){
    auth.logInWithGoogle(userData).then((value){

      userData.id = auth.getCurrentUserId();
      print("Done 11");
      bool done  = auth.getUserData(userData.id.toString());

      print("Done 12");
      emit(LogInSuccess());
    }).catchError((onError){
      emit(LogInFailed(onError.toString()));
    });
  }
}