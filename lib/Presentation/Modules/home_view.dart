import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:task_final/Domain/UserJourneysCubit/journeys_cubit.dart';
import 'package:task_final/Domain/UserJourneysCubit/journeys_status.dart';
import 'package:task_final/Models/image_manager.dart';
import 'package:task_final/Presentation/Widget/UserText.dart';
class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<String> images = [ImageManager.image1 ,ImageManager.image2  ,ImageManager.image3];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
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
              data:  "Home",
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.sp,
                  vertical: 5.sp
                ),
                child: CustomerText(
                  data:  "Our Blog",
                  color: Colors.black,
                  textAlign: TextAlign.left,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 100.w,
                height: 30.h,
                child: ListView.builder(
                  itemCount: images.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context , index ){
                    return Container(
                      width: 80.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                        image: DecorationImage(
                            image: AssetImage(images[index]),
                          fit: BoxFit.cover,
                          opacity: 0.6
                        )
                      ),
                      margin: EdgeInsets.all(10.sp),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomerText(
                            data:  "HOW TO MAKE RACES MORE ENVIRONMENTALLY FRIENDLY",
                            color: Colors.white,
                            textAlign: TextAlign.center,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.sp,
                  vertical: 5.sp
                ),
                child: CustomerText(
                  data:  "My journeys",
                  color: Colors.black,
                  textAlign: TextAlign.left,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              BlocBuilder<JourneysCubit , DisplayJourneyStatus>(
                builder: (context, state) {
                  if(state is JourneysLoaded){
                    if(state.list.isNotEmpty){
                      return Column(
                        children: [
                          for(var index = 0; index < state.list.length ; index ++) Container(
                            width: 100.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.sp),
                              border: Border.all(color: Colors.grey.shade400)
                            ),
                            padding: EdgeInsets.all(6.sp),
                            margin: EdgeInsets.all(10.sp),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomerText(
                                  data:  "Distance " + state.list[index].distance.toString(),
                                  color: Colors.black,
                                  textAlign: TextAlign.left,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                CustomerText(
                                  data: "Source         :  ( " + state.list[index].latitude_1.toString() + "  ,  " + state.list[index].latitude_2.toString() + " )",
                                  color: Colors.black,
                                  textAlign: TextAlign.left,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                                CustomerText(
                                  data: "Destination :  ( " + state.list[index].latitude_2.toString() + "  ,  " + state.list[index].latitude_2.toString()+ " )",
                                  color: Colors.black,
                                  textAlign: TextAlign.left,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                    else{
                      return Container(
                        child: Center(
                            child: CustomerText(
                              data:  "You haven't taken any Journeys yet",
                              color: Colors.black,
                              textAlign: TextAlign.left,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                            )
                        ),
                      );
                    }
                  }
                  else{
                    return Container(
                      padding: EdgeInsets.all(10.sp),
                      child: Center(
                        child: CustomerText(
                          data:  "You haven't taken any Journeys yet",
                          color: Colors.black,
                          textAlign: TextAlign.left,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w300,
                        )
                      ),
                    );
                  }
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}
