import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fox_delivery/modules/HomeScreen/HomeScreen.dart';
import 'package:fox_delivery/modules/LoginScreen/cubit/LoginCubit.dart';
import 'package:fox_delivery/modules/LoginScreen/cubit/LoginStates.dart';
import 'package:fox_delivery/shared/constants/constants.dart';
import 'package:fox_delivery/shared/network/local/CacheHelper.dart';
import 'package:get/get.dart';

import '../../shared/components/components.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => FoxLoginCubit(),
      child: BlocConsumer<FoxLoginCubit, FoxLoginStates>(
        listener: (context, state) {
          if(state is FoxLoginErrorState){
            Get.snackbar('Fox Delivery', 'Email or password is not correct', backgroundColor: Colors.red[400]);
          }else if(state is FoxLoginSuccessState){
            Get.snackbar('Fox Delivery', 'Login done successfully', backgroundColor: Colors.green);
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value){
              uId = CacheHelper.getData(key: 'uId');
              navigateAndFinish(context: context, widget: HomeScreen());
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              title: Text('login'.tr),
            ),
            body: Padding(
              padding: const EdgeInsets.all(18.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      const Image(image: AssetImage('assets/images/logo.png')),
                      SizedBox(
                        height: Get.height * 0.07,
                      ),
                      textFormField(
                          type: TextInputType.emailAddress,
                          controller: emailController,
                          label: "email".tr,
                          validation: 'email_validator'.tr,
                          prefixIcon: Icons.email_outlined,
                          context: context),
                      SizedBox(height: Get.height * 0.03),
                      textFormField(
                          type: TextInputType.visiblePassword,
                          controller: passwordController,
                          validation: "password_validator".tr,
                          label: "password".tr,
                          prefixIcon: Icons.lock,
                          fun: () {
                            FoxLoginCubit.get(context).changeVisibility();
                          },
                          isPassword: FoxLoginCubit.get(context).isPassword,
                          suffixIcon: FoxLoginCubit.get(context).icon,
                          context: context),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      defaultTextButton(text: 'forgot_password'.tr, fun: () {}),
                      SizedBox(height: Get.height * 0.1),
                      ConditionalBuilder(
                        condition: state is! FoxLoginLoadingState,
                        builder: (BuildContext context) => buttonBuilder(
                          fun: () {
                            if (formKey.currentState!.validate()) {
                              FoxLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  context: context);
                            }
                          },
                          text: "Login",
                          height: 50,
                          isUpper: true,
                          textColor: Colors.white,
                          width: double.infinity,
                        ),
                        fallback: (BuildContext context) =>
                            Center(child: const CircularProgressIndicator()),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
