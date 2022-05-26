class LogInStatus {}
class LogInLoading extends LogInStatus{}
class LogInSuccess extends LogInStatus{}
class LogInFailed extends LogInStatus{
  String error ;
  LogInFailed(this.error);
}