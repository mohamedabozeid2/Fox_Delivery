class FoxRegisterStates {}

class FoxInitialRegisterState extends FoxRegisterStates{}

class FoxRegisterChangeVisibility extends FoxRegisterStates{}

class FoxRegisterLoadingState extends FoxRegisterStates{}
class FoxRegisterSuccessState extends FoxRegisterStates{}
class FoxRegisterErrorState extends FoxRegisterStates{
  final String error;

  FoxRegisterErrorState(this.error);
}
class FoxCreateUserSuccessState extends FoxRegisterStates{
  final String uId;

  FoxCreateUserSuccessState(this.uId);
}
class FoxCreateUserErrorState extends FoxRegisterStates{
  final String error;

  FoxCreateUserErrorState(this.error);
}

class FoxPhoneAuthenticationState extends FoxRegisterStates{}

