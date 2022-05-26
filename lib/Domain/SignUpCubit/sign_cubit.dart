import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_final/Domain/SignUpCubit/sign_status.dart';
import '../../Models/API/AuthAPI.dart';
import '../../Models/User.dart';

class SignUpCubit extends Cubit<SignUpStatus>{
  SignUpCubit() : super(SignUpLoading());
  AuthAPI auth = AuthAPI();
  static SignUpCubit get(context) => BlocProvider.of(context);

  createAccount(UserData userData){
    auth.createAccount(userData).then((value){
      userData.id = auth.getCurrentUserId();
        auth.saveUserData(userData).then((value){
          bool done  = auth.getUserData(userData.id.toString());
          emit(SignUpSuccess());
        }).catchError((onError){
          emit(SignUpFailed("1 : " + onError.toString()));
        });
    }).catchError((onError){
      emit(SignUpFailed("3 : " + onError.toString()));
    });
  }
}