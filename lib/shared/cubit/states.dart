abstract class FoxStates{}

class FoxInitialState extends FoxStates{}
class FoxChangeLanguageState extends FoxStates{}

class FoxGetUserDataLoadingState extends FoxStates{}
class FoxGetUserDataSuccessState extends FoxStates{}
class FoxGetUserDataErrorState extends FoxStates{}

class FoxSignOutState extends FoxStates{}

class FoxNewOrderLoadingState extends FoxStates{}
class FoxNewOrderSuccessState extends FoxStates{}
class FoxNewOrderErrorState extends FoxStates{}

class FoxGetUserPackagesLoadingState extends FoxStates{}
class FoxGetUserPackagesSuccessState extends FoxStates{}
class FoxGetUserPackagesErrorState extends FoxStates{}