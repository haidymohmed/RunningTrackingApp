import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../Domain/LiveLocation/live_cubit.dart';
import '../../Domain/LiveLocation/live_status.dart';
import '../../Models/image_manager.dart';
import 'UserText.dart';
MapAabBar(context) {
    return PreferredSize(
      preferredSize: Size(100.w , 25.h ),
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    ImageManager.runningIcon,
                    color: Colors.black,
                    fit: BoxFit.contain,
                    width: 50.sp,
                    height: 50.sp,
                  ),
                ],
              ),
            ),
            BlocBuilder<LiveLocationCubit , LiveStatus>(
              builder: (context, state) {
                if(state is LiveSuccess){
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //Distance
                          CustomerText(
                            data: "Distance  ",
                            color: Colors.black,
                            fontSize: 18.sp,
                          ),
                          CustomerText(
                            data: state.liveData.distance.toStringAsFixed(2),
                            color: Colors.black,
                            fontSize: 18.sp,
                          ),
                          CustomerText(
                            data: " (km)",
                            color: Colors.black,
                            fontSize: 7.sp,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //Distance
                          CustomerText(
                            data: "Latitude 1  : " + state.liveData.latitude_1.toString(),
                            color: Colors.black,
                            fontSize: 8.sp,
                          ),
                          CustomerText(
                            data: "   Longitude 1 : " + state.liveData.longitude_1.toString(),
                            color: Colors.black,
                            fontSize: 8.sp,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //Distance
                          CustomerText(
                            data: "Latitude 2  : " + state.liveData.latitude_2.toString(),
                            color: Colors.black,
                            fontSize: 8.sp,
                          ),
                          CustomerText(
                            data: "   Longitude 2 : " + state.liveData.longitude_2.toString(),
                            color: Colors.black,
                            fontSize: 8.sp,
                          ),
                        ],
                      ),
                    ],
                  );
                }
                else{
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomerText(
                            data: "Distance : 0:00",
                            color: Colors.black,
                            fontSize: 18.sp,
                          ),
                          CustomerText(
                            data: " (m)",
                            color: Colors.black,
                            fontSize: 9.sp,
                          ),
                        ],
                      ),
                    ],
                  );
                }
              }
            )
          ],
        ),
      ),
    );
  }

