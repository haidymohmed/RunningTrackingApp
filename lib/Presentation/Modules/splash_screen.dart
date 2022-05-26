import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import '../../Models/LocalStorage/db_helper_sharedPrefrences.dart';
import '../../Models/image_manager.dart';
import 'home.dart';
import 'log_in.dart';
import 'on_boarding_screen.dart';
// ignore: must_be_immutable
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: AnimatedSplashScreen(
          splashTransition: SplashTransition.fadeTransition,
          duration: 500,
          nextScreen:  getNextScreen() ,
          splash: Container(
            alignment: Alignment.center,
            width: 100.sp,
            height: 100.sp,
            child: LayoutBuilder(
              builder: (context , constraints) => SizedBox(
                width: constraints.maxWidth /2 ,
                height: constraints.maxHeight /2 ,
                child: SvgPicture.asset(
                  ImageManager.runningIcon,
                  color: Colors.green,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          )
      ),
    );
  }

  static getNextScreen(){
    var first = CacheHelper.getBool("firstTime");
    var signed = CacheHelper.getBool("isSigned");
    if(first == false){
      return  OnBoardingScreen();
    }
    else{
      if(signed == false){
        return const LogIn();
      }
      else{
        return const Home();
      }
    }
  }
}


