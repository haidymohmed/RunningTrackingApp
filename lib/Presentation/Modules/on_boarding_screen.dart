import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:task_final/Presentation/Modules/sign_up.dart';
import '../../Models/LocalStorage/db_helper_sharedPrefrences.dart';
import '../../Models/image_manager.dart' show ImageManager;
import '../Widget/UserText.dart';
import '../Widget/button.dart';
import 'log_in.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    CacheHelper.setBool("firstTime", false);
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
              color: Colors.grey.shade200,
              image:  const DecorationImage(
                  image: AssetImage(
                      ImageManager.splashImage
                  ),
                  fit: BoxFit.cover,
                  opacity: 0.9
              )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(),
              const Spacer(),
              SvgPicture.asset(
                ImageManager.runningIcon,
                color: Colors.green,
                width: 100.sp,
                height: 100.sp,
                fit: BoxFit.contain,
              ),
              const Spacer(),
              const Spacer(),
              const Spacer(),
              const Spacer(),
              const Spacer(),
              UserButton(
                title: "Let's go ",
                width: 0.9,
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const SignUp()));
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomerText(
                      data: "ALREADY HAVE AN ACCOUNT ?  ",
                      fontWeight: FontWeight.bold,
                    ),
                    CustomerText(
                      data: "LOGIN",
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const LogIn()));
                      },
                    ),
                  ],
                ),
              ),
              const Spacer(),
            ],
          )
      ),
    );
  }
}
