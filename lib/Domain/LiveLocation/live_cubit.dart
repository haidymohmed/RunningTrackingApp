import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../../Models/API/LocationApi.dart';
import '../../Models/API/live_api.dart';
import '../../Models/LiveData.dart';
import 'live_status.dart';

class LiveLocationCubit extends Cubit<LiveStatus>{
  final Location location = Location();
  StreamSubscription<LocationData>? _locationSubscription;
  LocationApi locationApi = LocationApi();
  LiveApi liveApi = LiveApi();
  bool liveEnabled = false;
  static LiveLocationCubit get(context) => BlocProvider.of(context);
  @override
  LiveLocationCubit() : super(LoadingLive()){
      location.changeSettings(interval: 300, accuracy: LocationAccuracy.high);
      location.enableBackgroundMode(enable: true).then((value){
        liveApi.getLive().listen((value){
          emit(LiveSuccess(value));
        }).onError((e) async {
          LocationData _locationResult = await location.getLocation();
          emit(LiveFailed(LatLng(_locationResult.latitude!, _locationResult.longitude!)));
        });
      });
  }
  Future<void> startLive() async {
    liveEnabled = true;
    _locationSubscription = location.onLocationChanged.handleError((onError) {
      _locationSubscription?.cancel();
      _locationSubscription = null;
    }).listen((LocationData locationData) async {
      LiveData liveData = LiveData(
          latitude_1: 0,
          longitude_1: 0,
          latitude_2: locationData.latitude !,
          longitude_2: locationData.longitude !,
          distance: 0,
          cal: 0,
          source: '',
          destination: ''
      );
      locationApi.setShortLocation(liveData);
    });
  }

  stopLive() async {
    liveEnabled = false;
    liveApi.stopLive();
    locationApi.setLocation(LiveData(
        latitude_1: 0,
        latitude_2: 0,
        longitude_1: 0,
        longitude_2: 0,
        distance: 0,
        cal: 0,
        source : "Source",
        destination: "Destination"
    ));
    _locationSubscription?.cancel();
    _locationSubscription = null;
  }
}