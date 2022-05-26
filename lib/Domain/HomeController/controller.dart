import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_final/Domain/HomeController/states.dart';
import '../../Presentation/Modules/Profile.dart';
import '../../Presentation/Modules/home_view.dart';
import '../../Presentation/Modules/myMap.dart';
class HomeCubit extends Cubit<HomeStates>{
  HomeCubit() : super(ChangeBottomNavStateLoading());
   static HomeCubit get(context)=> BlocProvider.of(context);
   int currentIndex = 0;
   List<Widget> bottomScreens = [
     const HomeView(),
     MyMap(),
     const Profile(),
   ];
   void changeBottom(int index){
     currentIndex = index;
     emit(ChangeBottomNavState());
   }
}