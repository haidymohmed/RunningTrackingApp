import 'package:geolocator/geolocator.dart';
class LiveData{
  late double latitude_1 , latitude_2 , longitude_1 , longitude_2;
  late double distance , cal ;
  late String source , destination ;
  LiveData({
    required this.latitude_1,
    required this.latitude_2,
    required this.longitude_1,
    required this.longitude_2,
    required this.distance,
    required this.cal,
    required this.source,
    required this.destination,
  });
  toJson(){
    return {
      "latitude_1" : latitude_1,
      "latitude_2" : latitude_2,
      "longitude_1" : longitude_1,
      "longitude_2" : longitude_2,
      "distance" : distance,
      "cal" : cal,
      "source" : source,
      "destination" : destination,
    };
  }
  LiveData.fromJson(data){
    latitude_1 = data["latitude_1"] ;
    latitude_2= data["latitude_2"] ;
    longitude_1= data["longitude_1"] ;
    longitude_2= data["longitude_2"] ;
    distance= data["distance"] ;
    cal= data["cal"] ;
    source= data["source"] ;
    destination= data["destination"] ;
  }
  calculateDistance()async{
    double distanceInMeters = Geolocator.bearingBetween(
      latitude_1,
      longitude_1,
      latitude_2,
      longitude_2,
    );
    print(distanceInMeters);
    distance =  distanceInMeters / 1000;
  }
}