import 'package:flutter/material.dart';
import '../../Domain/HomeController/controller.dart';
import '../../Models/image_manager.dart';
import 'bottom_bar_item.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (value) {
        HomeCubit.get(context).changeBottom(value);
        HomeCubit.get(context).currentIndex = value;
      },
      showUnselectedLabels: false,
      showSelectedLabels: false,
      currentIndex: HomeCubit.get(context).currentIndex,
      type: BottomNavigationBarType.fixed,
      items: [
        getBottomNavigationBar(ImageManager.home , 0 , context),
        getBottomNavigationBar(ImageManager.mapIcon  , 1 , context),
        getBottomNavigationBar(ImageManager.profile, 2 , context),
      ],
    );
  }
}
