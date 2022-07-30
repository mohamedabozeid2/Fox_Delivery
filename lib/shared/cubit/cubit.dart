import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fox_delivery/models/UserMdeol.dart';
import 'package:fox_delivery/modules/LoginScreen/LoginScreen.dart';
import 'package:fox_delivery/shared/components/components.dart';
import 'package:fox_delivery/shared/constants/constants.dart';
import 'package:fox_delivery/shared/cubit/states.dart';
import 'package:fox_delivery/shared/network/local/CacheHelper.dart';

class FoxCubit extends Cubit<FoxStates>{
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



}