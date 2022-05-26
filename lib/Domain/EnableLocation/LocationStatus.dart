class LocationStatus {}
class LoadingLocation extends LocationStatus{}
class LocationEnabled extends LocationStatus{

}
class LocationFailed extends LocationStatus{
  String error ;
  LocationFailed({required this.error});
}