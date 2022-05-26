import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import '../../Models/LocalStorage/db_helper_sharedPrefrences.dart';
import '../../Models/image_manager.dart';
import '../Widget/UserText.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size(95.w, 55.sp),
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 15.sp,
              vertical: 8.sp
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(30.sp)
            ),
            child: CustomerText(
              data:  "Profile",
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Column(
          children: [
            SizedBox(height: 10.sp,),
            SvgPicture.asset(
              ImageManager.profile,
              width: 40.w,
              height: 40.w,
              color: Colors.green,
            ),
            getRow("Name" , CacheHelper.getString("Name")),
            getRow("Email" , CacheHelper.getString("Email")),
            getRow("Id" , CacheHelper.getString("ID")),
            getRow("Gender" , CacheHelper.getString("Gender") == "0"? "Male" : "Female"),
          ],
        ),
      ),
    );
  }
  getRow(String title  , String subtitle){
    return ListTile(
      title: CustomerText(
        data:  title,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      subtitle:
      CustomerText(
        data:  subtitle,
        color: Colors.grey.shade700,
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
