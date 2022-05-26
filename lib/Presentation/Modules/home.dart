import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Domain/EnableLocation/LocationCubit.dart';
import '../../Domain/HomeController/controller.dart';
import '../../Domain/HomeController/states.dart';
import '../../Models/LocalStorage/db_helper_sharedPrefrences.dart';
import '../Widget/bottom_bar.dart';

class Home extends StatefulWidget {
  static String id = "Home";
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    CacheHelper.setBool("isSigned", true);
  }
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const BottomBar(),
        body: BlocConsumer<HomeCubit, HomeStates>(
            listener: (context ,state){},
            builder: (context, state) {
              return HomeCubit.get(context)
                  .bottomScreens[HomeCubit.get(context).currentIndex];
            }
        )
    );
  }
}
