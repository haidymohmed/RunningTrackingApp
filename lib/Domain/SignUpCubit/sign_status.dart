class SignUpStatus {}
class SignUpLoading extends SignUpStatus{}
class SignUpSuccess extends SignUpStatus{}
class SignUpFailed extends SignUpStatus{
  String error ;
  SignUpFailed(this.error);
}