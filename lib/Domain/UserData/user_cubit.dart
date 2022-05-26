
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_final/Domain/UserData/user_status.dart';
import '../../Models/User.dart';

class UserCubit extends Cubit<UserStatus>{
  UserCubit() : super(UserLoading());
  static UserCubit get(context) => BlocProvider.of(context);
  UserData userData = UserData(email: '', password: '', fullName: '', gender: 0, id: '');
  setData(UserData userData ){
    this.userData = userData;
  }
}