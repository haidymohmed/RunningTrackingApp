import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sizer/sizer.dart';
import 'package:task_final/Presentation/Dialog/toaste.dart';

import '../../Domain/EnableLocation/LocationCubit.dart';
import '../../Domain/LiveLocation/live_cubit.dart';
import '../../Domain/LiveLocation/live_status.dart';
import '../Widget/button.dart';
import '../Widget/map_app_bar.dart';
import '../../Models/LiveData.dart';

class MyMap extends StatefulWidget {
  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  late GoogleMapController _controller;
  bool _added = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: MapAabBar(context),
          body: Stack(
            children: [
              BlocBuilder<LiveLocationCubit , LiveStatus>(
                builder: (context, state) {
                  if(state is LiveSuccess){
                    if(_added){
                      mymap(state.liveData.latitude_2 , state.liveData.longitude_2);
                    }
                    return GoogleMap(
                      mapType: MapType.normal,
                      markers: {
                        Marker(
                            position: LatLng(state.liveData.latitude_2 , state.liveData.longitude_2),
                            markerId: MarkerId('id'),
                            icon: BitmapDescriptor.defaultMarkerWithHue(
                                BitmapDescriptor.hueMagenta
                            )
                        ),
                      },
                      initialCameraPosition: CameraPosition(
                          target: LatLng(state.liveData.latitude_2 , state.liveData.longitude_2),
                          zoom: 14.47),
                      onMapCreated: (GoogleMapController controller) async {
                        setState(() {
                          _controller = controller;
                          _added = true;
                        });
                      },
                    );
                  }
                  else if (state is LiveFailed){
                    print("=================");
                    print(state.latLng.latitude);
                    print(state.latLng.longitude);

                    if(_added){
                      mymap(state.latLng.latitude , state.latLng.longitude);
                    }
                    return GoogleMap(
                      mapType: MapType.normal,
                      markers: {
                        Marker(
                            position: LatLng(state.latLng.latitude, state.latLng.longitude),
                            markerId: MarkerId('id'),
                            icon: BitmapDescriptor.defaultMarkerWithHue(
                                BitmapDescriptor.hueMagenta
                            )
                        ),
                      },
                      initialCameraPosition: CameraPosition(
                          target: LatLng(state.latLng.latitude, state.latLng.longitude),
                          zoom: 14.47),
                      onMapCreated: (GoogleMapController controller) async {
                        setState(() {
                          _controller = controller;
                          _added = true;
                        });
                      },
                    );
                  }
                  else{
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              LiveLocationCubit.get(context).liveEnabled ?
              Positioned(
                bottom: 10.sp,
                child: Container(
                  width: 100.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async{
                          setState(() {
                            LiveLocationCubit.get(context).liveEnabled = false;
                          });
                          try{
                            LiveLocationCubit.get(context).stopLive();
                          }catch(e){
                            showToastError(msg: e.toString(), state: ToastedStates.ERROR);
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 60.sp, vertical: 8.sp),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(18.sp)),
                          child: Text(
                            "STOP LIVE",
                            style: GoogleFonts.tajawal(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ) :
              Positioned(
                bottom: 10.sp,
                child: Container(
                  width: 100.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          await LocationCubit.get(context).setCurrentLocation();
                          setState(() {
                            LiveLocationCubit.get(context).liveEnabled = true;
                          });
                          try{
                            LiveLocationCubit.get(context).startLive();
                          }catch(e) {
                            showToastError(msg: e.toString(), state: ToastedStates.ERROR);
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 60.sp, vertical: 8.sp),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(18.sp)),
                          child: Text(
                            "START LIVE",
                            style: GoogleFonts.tajawal(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }

  Future<void> mymap(lat , lng) async {
    await _controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
        target: LatLng(lat,lng),
        zoom: 14.47
        )
      )
    );
  }
}
