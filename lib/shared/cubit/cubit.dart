import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fox_delivery/models/PackageModel.dart';
import 'package:fox_delivery/models/UserMdeol.dart';
import 'package:fox_delivery/modules/LoginScreen/LoginScreen.dart';
import 'package:fox_delivery/shared/components/components.dart';
import 'package:fox_delivery/shared/constants/constants.dart';
import 'package:fox_delivery/shared/cubit/states.dart';
import 'package:fox_delivery/shared/network/local/CacheHelper.dart';

class FoxCubit extends Cubit<FoxStates> {
  FoxCubit() : super(FoxInitialState());

  static FoxCubit get(context) => BlocProvider.of(context);

  List<String> languagesList = ['en', 'ar'];

  void getUserData({
    required String userID,
    bool isMainUser = true,
  }) {
    emit(FoxGetUserDataLoadingState());
    FirebaseFirestore.instance
        .collection("users")
        .doc(userID)
        .get()
        .then((value) {
      userModel = FoxUserModel.fromJson(value.data()!);
      emit(FoxGetUserDataSuccessState());
    }).catchError((error) {
      print("Error ===> ${error.toString()}");
      emit(FoxGetUserDataErrorState());
    });
  }

  void signOut(context) {
    CacheHelper.removeData(key: 'uId');
    uId = CacheHelper.getData(key: 'uId');
    navigateAndFinish(context: context, widget: LoginScreen());
    emit(FoxSignOutState());
  }

  void newOrder({
    required String packageName,
    required String description,
    required String fromLocation,
    required String toLocation,
  }) {
    emit(FoxNewOrderLoadingState());
    PackageModel model = PackageModel(
        toLocation: toLocation,
        fromLocation: fromLocation,
        clientUid: userModel!.uId,
        clientName: userModel!.name,
        packageName: packageName,
        packageId: packageIDCounter,
        description: description,
        status: 'New',
    );
    FirebaseFirestore.instance
        .collection('packages')
        .add(model.toMap())
        .then((value) {
      packageIDCounter++;
      emit(FoxNewOrderSuccessState());
    }).catchError((error) {
      print("Error in add new order ===> ${error.toString()}");
      emit(FoxNewOrderErrorState());
    });
  }

  void getUserPackages() {
    emit(FoxGetUserPackagesLoadingState());
    userPackages = [];
    FirebaseFirestore.instance.collection('packages').get().then((value) {
      value.docs.forEach((element) {
        if(element.get('clientUid') == uId){
          userPackages.add(PackageModel.fromJson(element.data()));
        }
        print('now');
      });
      print(userPackages.length);
      emit(FoxGetUserPackagesSuccessState());
    }).catchError((error){
      print('Error in get user packages===> ${error.toString()}');
      emit(FoxGetUserPackagesErrorState());
    });
  }
}
