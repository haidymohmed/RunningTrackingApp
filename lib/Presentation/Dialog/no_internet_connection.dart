import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../Widget/UserText.dart';

// ignore: must_be_immutable
class ShowCustomerDialog extends StatelessWidget {
  bool dismiss ;
  late String title , subtitle;
  static BuildContext ?  context ;
  ShowCustomerDialog({Key? key , required this.dismiss , required this.title , required this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => dismiss,
      child: AlertDialog(
        title: CustomerText(
          data: title,
          color: Colors.black,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.bold,
          fontSize: 12.sp,
        ),
        content: CustomerText(
          data: subtitle,
          textAlign: TextAlign.center,
            color: Colors.grey,
            fontSize: 9.sp,
            fontWeight: FontWeight.normal
        ),
      ),
    );
  }
}
