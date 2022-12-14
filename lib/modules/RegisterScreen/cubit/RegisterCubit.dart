import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fox_delivery/models/UserModel.dart';
import 'package:fox_delivery/modules/RegisterScreen/cubit/RegisterStates.dart';
import 'package:fox_delivery/shared/constants/constants.dart';
import 'package:fox_delivery/shared/cubit/cubit.dart';
import 'package:fox_delivery/shared/network/local/CacheHelper.dart';

class RegisterCubit extends Cubit<FoxRegisterStates> {
  RegisterCubit() : super(FoxInitialRegisterState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  IconData icon = Icons.visibility;

  void changeVisibility() {
    isPassword = !isPassword;
    if (isPassword) {
      icon = Icons.visibility;
    } else {
      icon = Icons.visibility_off;
    }
    emit(FoxRegisterChangeVisibility());
  }

  void userRegister({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String location,
    required String password,
    required BuildContext context,
  }) {
    emit(FoxRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email.trim(), password: password)
        .then((value) {
      print(value.user!.email);
      userCreate(
          firstName: firstName,
          lastName: lastName,
          email: email,
          phone: phone,
          location: location,
          uId: value.user!.uid,
          context: context);
    }).catchError((error) {
      print("Error: ${error.toString()}");
      emit(FoxRegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String firstName,
    required String lastName,
    required String email,
    required String location,
    required String phone,
    required String uId,
    required BuildContext context,
  }) {
    FoxUserModel model = FoxUserModel(
        email: email,
        firstName: firstName,
        lastName: lastName,
        location: location,
        deviceToken: deviceToken,
        phone: phone,
        uId: uId,
        isEmailVerified: false,
        completedPackages: 0,
        notCompletedPackages: 0,
        // dateTime: DateTime.now(),
        packageNumber: 0);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      FirebaseAuth.instance.currentUser!.sendEmailVerification();
      FoxCubit.get(context).getUserData(userID: uId);
      emit(FoxCreateUserSuccessState(uId));
    }).catchError((error) {
      print(error.toString());
      emit(FoxCreateUserErrorState(error.toString()));
    });
  }

  void verifyNumber({
    required String phoneNumber,
  }) {
    FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) {
            print("You are logged in successfully");
          });
        },
        verificationFailed: (FirebaseAuthException exception) {
          print("Exception: $exception.message");
        },
        codeSent: (String verificationID, int? resendToken) {
          verificationIDReceived = verificationID;
        },
        codeAutoRetrievalTimeout: (String verification) {});
  }
}
