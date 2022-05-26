import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../Models/LiveData.dart';

class LiveStatus {}
class LoadingLive extends LiveStatus {}
class LiveSuccess extends LiveStatus {
  LiveData liveData ;
  LiveSuccess(this.liveData);
}
class LiveFailed extends LiveStatus {
  LatLng latLng ;
  LiveFailed(this.latLng);
}
