class FoxLoginStates{}

class FoxLoginInitialState extends FoxLoginStates{}

class FoxLoginChangeVisibility extends FoxLoginStates{}

class FoxLoginSuccessState extends FoxLoginStates{
  final String uId;

  FoxLoginSuccessState(this.uId);
}
class FoxLoginErrorState extends FoxLoginStates{
  final String error;

  FoxLoginErrorState(this.error);
}
class FoxLoginLoadingState extends FoxLoginStates{}