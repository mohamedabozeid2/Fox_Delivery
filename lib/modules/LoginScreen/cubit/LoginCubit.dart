import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fox_delivery/modules/LoginScreen/cubit/LoginStates.dart';
import 'package:fox_delivery/shared/constants/constants.dart';
import 'package:fox_delivery/shared/cubit/cubit.dart';
import 'package:fox_delivery/shared/network/local/CacheHelper.dart';

class FoxLoginCubit extends Cubit<FoxLoginStates>{
    FoxLoginCubit() :super(FoxLoginStates());

    static FoxLoginCubit get(context) =>BlocProvider.of(context);

    bool isPassword = true;
    IconData icon = Icons.visibility;

    void changeVisibility() {
      isPassword = !isPassword;
      if (isPassword) {
        icon = Icons.visibility;
      } else {
        icon = Icons.visibility_off;
      }
      emit(FoxLoginChangeVisibility());
    }

    void userLogin({
      required String email,
      required String password,
      required BuildContext context,
    }) {
      emit(FoxLoginLoadingState());
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email.trim(), password: password)
          .then((value) {
        if(!FirebaseAuth.instance.currentUser!.emailVerified){
          FirebaseAuth.instance.currentUser!.sendEmailVerification();
        }
        CacheHelper.saveData(key: 'uId', value: value.user!.uid);
        uId = CacheHelper.getData(key: 'uId');
        FoxCubit.get(context).getUserData(userID: uId);
        emit(FoxLoginSuccessState(value.user!.uid));
      }).catchError((error) {
        print("Error from Login===> ${error.toString()}");
        emit(FoxLoginErrorState(error.toString()));
      });
    }
}