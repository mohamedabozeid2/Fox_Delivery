import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fox_delivery/models/PackageModel.dart';
import 'package:fox_delivery/models/UserMdeol.dart';
import 'package:fox_delivery/models/problemModel.dart';
import 'package:fox_delivery/modules/LoginScreen/LoginScreen.dart';
import 'package:fox_delivery/shared/components/components.dart';
import 'package:fox_delivery/shared/constants/constants.dart';
import 'package:fox_delivery/shared/cubit/states.dart';
import 'package:fox_delivery/shared/network/EndPoint.dart';
import 'package:fox_delivery/shared/network/local/CacheHelper.dart';
import 'package:fox_delivery/shared/network/remote/Dio_Helper.dart';

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
      print("FROM GET USER DATA ${value.id}");
      updateDeviceToken();
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

  void newOrder(
      {required String packageName,
      required String description,
      required String fromLocation,
      required String toLocation,
      required String dateTime,
      required String dateTimeDisplay}) {
    emit(FoxNewOrderLoadingState());
    PackageModel model = PackageModel(
      toLocation: toLocation,
      fromLocation: fromLocation,
      clientUid: userModel!.uId,
      clientFirstName: userModel!.firstName,
      clientLastName: userModel!.lastName,
      dateTime: dateTime,
      dateTimeDisplay: dateTimeDisplay,
      packageName: packageName,
      packageId: packageIDCounter,
      description: description,
      status: 'New',
    );
    FirebaseFirestore.instance
        .collection('packages')
        .add(model.toMap())
        .then((value) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(userModel!.uId)
          .update({
        'firstName': userModel!.firstName,
        'lastName': userModel!.lastName,
        'email': userModel!.email,
        'phone': userModel!.phone,
        'uId': userModel!.uId,
        'location': userModel!.location,
        'deviceToken': userModel!.deviceToken,
        'isEmailVerified': userModel!.isEmailVerified,
        'completedPackages': userModel!.completedPackages,
        'notCompletedPackages': userModel!.notCompletedPackages! + 1,
        'packageNumber': userModel!.packageNumber! + 1,
      }).then((value) {
        packageIDCounter++;
        getUserPackages();
        emit(FoxNewOrderSuccessState());
      }).catchError((error) {});
    }).catchError((error) {
      print("Error in add new order ===> ${error.toString()}");
      emit(FoxNewOrderErrorState());
    });
  }

  void getUserPackages(
      {bool fromTracking =
          false} /*{bool fromTrackingScreen = false, int? id}*/) {
    userPackages = [];
    packagesID = [];
    if (fromTracking == false) {
      emit(FoxGetUserPackagesLoadingState());
    }
    FirebaseFirestore.instance
        .collection('packages')
        .orderBy('dateTime', descending: false)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        if (element.get('clientUid') == uId) {
          userPackages.add(PackageModel.fromJson(element.data()));
        }
        packagesID.add(element.id);
      });
      // if (fromTrackingScreen == true) {
      //
      //   getSpecificPackage(id: id!);
      // }
      if (fromTracking == false) {
        emit(FoxGetUserPackagesSuccessState());
      }
    }).catchError((error) {
      print('Error in get user packages===> ${error.toString()}');
      emit(FoxGetUserPackagesErrorState());
    });
  }

  void getSpecificPackage({required int id}) {
    emit(FoxGetSpecificPackageLoadingState());
    for (int i = 0; i < userPackages.length; i++) {
      if (userPackages[i].packageId == id) {
        if (userPackages[i].clientUid == userModel!.uId) {
          specificPackage = userPackages[i];
          isOwner = true;
          if (userPackages[i].status == 'New') {
            sliderValue = 2;
            packageStatus = 'New';
          } else if (userPackages[i].status == 'inProgress') {
            sliderValue = 3;
            packageStatus = 'In Progress';
          } else if (userPackages[i].status == 'Completed') {
            sliderValue = 4;
            packageStatus = 'Completed';
          } else {
            sliderValue = 1;
            packageStatus = 'Canceled';
          }
          break;
        } else {
          isOwner = false;
          break;
        }
      }
      sliderValue = 0;
    }
    emit(FoxGetSpecificPackageSuccessState());
  }

  void updateUserPhone({
    required String phone,
  }) {
    FirebaseFirestore.instance.collection('users').doc(userModel!.uId).update({
      'firstName': userModel!.firstName,
      'lastName': userModel!.lastName,
      'email': userModel!.email,
      'phone': phone,
      'uId': userModel!.uId,
      'location': userModel!.location,
      'deviceToken': userModel!.deviceToken,
      'isEmailVerified': userModel!.isEmailVerified,
      'completedPackages': userModel!.completedPackages,
      'notCompletedPackages': userModel!.notCompletedPackages,
      'packageNumber': userModel!.packageNumber,
    }).then((value) {
      getUserData(userID: userModel!.uId!);
    }).catchError((error) {
      print("Error in update user info ${error.toString()}");
      emit(FoxUpdateUserInfoErrorState());
    });
  }

  void updateUserLocation({
    required String location,
  }) {
    FirebaseFirestore.instance.collection('users').doc(userModel!.uId).update({
      'firstName': userModel!.firstName,
      'lastName': userModel!.lastName,
      'email': userModel!.email,
      'phone': userModel!.phone,
      'uId': userModel!.uId,
      'location': location,
      'deviceToken': userModel!.deviceToken,
      'isEmailVerified': userModel!.isEmailVerified,
      'completedPackages': userModel!.completedPackages,
      'notCompletedPackages': userModel!.notCompletedPackages,
      'packageNumber': userModel!.packageNumber,
    }).then((value) {
      getUserData(userID: userModel!.uId!);
    }).catchError((error) {
      print("Error in update user info ${error.toString()}");
      emit(FoxUpdateUserInfoErrorState());
    });
  }

  // void deleteOrder({required String id}) {
  //   FirebaseFirestore.instance
  //       .collection('packages')
  //       .doc(id)
  //       .delete()
  //       .then((value) {
  //     getUserPackages(fromTrackingScreen: true, id: int.parse(id));
  //   });
  // }

  void cancelOrder({
    required bool fromTracking,
    required BuildContext context,
    required int idNumber,
    required String id,
    required String clientFirstName,
    required String clientLastName,
    required String clientUid,
    required String dateTime,
    required String dateTimeDisplay,
    required String description,
    required String fromLocation,
    required String toLocation,
    required int packageId,
    required String packageName,
  }) {
    FirebaseFirestore.instance.collection('packages').doc(id).update({
      'clientFirstName': clientFirstName,
      'clientLastName': clientLastName,
      'clientUid': clientUid,
      'dateTime': dateTime,
      'dateTimeDisplay': dateTimeDisplay,
      'description': description,
      'fromLocation': fromLocation,
      'toLocation': toLocation,
      'packageId': packageId,
      'packageName': packageName,
      'status': 'Canceled',
    }).then((value) {
      Navigator.pop(context);
      getUserPackages(/*id: idNumber, fromTrackingScreen: true*/);

      // if(fromTracking == false){
      //   getUserPackages(/*id: idNumber, fromTrackingScreen: true*/);
      // }else{
      //   getSpecificPackage(id: idNumber);
      // }
      showToast(msg: 'The order has been canceled');
    }).catchError((error) {
      print("Error while canceling order ====> ${error.toString()}");
      emit(FoxCancelOrderErrorState());
    });
  }

  void getPackagesNumber() {
    emit(FoxGetPackageNumbersLoadingState());
    FirebaseFirestore.instance.collection('packages').get().then((value) {
      packageIDCounter = value.docs.length + 1;
      emit(FoxGetPackageNumbersSuccessState());
    });
  }

  bool isOwner = false;

  void checkPackageOwner({required int id}) {
    for (int i = 0; i < userPackages.length; i++) {
      if (userPackages[i].clientUid == userModel!.uId) {
        isOwner = true;
      } else {
        isOwner = false;
      }
    }
  }

  void sendNotification({
    required String receiverToken,
    required String title,
    required String body,
  }) {
    DioHelper.postData(token: serverKey, url: SEND_NOTIFICATION, data: {
      "to": receiverToken,
      "notification": {"title": title, "body": body, "sound": "default"},
      "android": {
        "priority": "HIGH",
        "notification": {
          "notification_priority": "PRIORITY_MAX",
          "sound": "default",
          "default_sound": true,
          "default_vibrate_timings": true,
          "default_light_settings": true,
        }
      },
      "date": {
        "type": "order",
        "id": "1",
        "click_action": "FLUTTER_NOTIFICATION_CLICK"
      }
    }).then((value) {}).catchError((error) {
      showToast(msg: 'Notification');
      print(error.toString());
    });
  }

  void updateDeviceToken() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId!)
        .update({
          'email': userModel!.email,
          'firstName': userModel!.firstName,
          'lastName': userModel!.lastName,
          'isEmailVerified': userModel!.isEmailVerified,
          'completedPackages': userModel!.completedPackages,
          'notCompletedPackages': userModel!.notCompletedPackages,
          'packageNumber': userModel!.packageNumber,
          'phone': userModel!.phone,
          'uId': userModel!.uId,
          'deviceToken': deviceToken,
        })
        .then((value) {})
        .catchError((error) {
          print(error.toString());
        });
  }

  void reportProblem({
    required String clientUid,
    required String clientLastName,
    required String clientFirstName,
    required String phoneNumber,
    required String problem,
  }) {
    emit(FoxReportProblemLoadingState());
    ProblemModel model = ProblemModel(
        clientUid: clientUid,
        clientLastName: clientLastName,
        phoneNumber: phoneNumber,
        clientFirstName: clientFirstName,
        problem: problem);
    FirebaseFirestore.instance
        .collection('problem')
        .add(model.toMap())
        .then((value) {
      emit(FoxReportProblemSuccessState());
    }).catchError((error) {
      print("Error from report problem ${error.toString()}");
      emit(FoxReportProblemErrorState());
    });
  }
}
