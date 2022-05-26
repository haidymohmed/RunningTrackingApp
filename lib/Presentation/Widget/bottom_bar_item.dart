import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../Domain/HomeController/controller.dart';
import '../../Domain/HomeController/states.dart';

getBottomNavigationBar(var data , int selected , context){
  return BottomNavigationBarItem(
      icon: BlocConsumer<HomeCubit, HomeStates>(
      listener: (context ,state){},
        builder: (context ,state ){
          return SvgPicture.asset(
            data,
            width: 20,
            height: 20,
            color: HomeCubit.get(context).currentIndex != selected ? Colors.grey : Colors.green,
          );
        },
      ),
      label: ""
  );
}