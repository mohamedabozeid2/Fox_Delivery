import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fox_delivery/modules/ForgotPassword/ForgotPassword.dart';
import 'package:fox_delivery/modules/HomeScreen/HomeScreen.dart';
import 'package:fox_delivery/modules/LoginScreen/cubit/LoginCubit.dart';
import 'package:fox_delivery/modules/LoginScreen/cubit/LoginStates.dart';
import 'package:fox_delivery/modules/RegisterScreen/RegisterScreen.dart';
import 'package:fox_delivery/shared/constants/constants.dart';
import 'package:fox_delivery/shared/network/local/CacheHelper.dart';
import 'package:fox_delivery/styles/Themes.dart';
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
          if (state is FoxLoginErrorState) {
            Get.snackbar('Fox Delivery', 'Email or password is not correct',
                backgroundColor: Colors.red[400], colorText: Colors.white);
          } else if (state is FoxLoginSuccessState) {
            Get.snackbar('Fox Delivery', 'Login done successfully',
                colorText: secondDefaultColor, backgroundColor: Colors.white);
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              uId = CacheHelper.getData(key: 'uId');
              navigateAndFinish(context: context, widget: HomeScreen());
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            backgroundColor: secondDefaultColor,
            body: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Image(
                              image:
                                  AssetImage('assets/images/logo.png')),
                          SizedBox(height: 30.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Login',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "Please sign in to continue",
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .copyWith(
                                            fontSize: 14,
                                            color: Colors.white),
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                          textFormField(
                              type: TextInputType.emailAddress,
                              controller: emailController,
                              label: "email".tr,
                              style: TextStyle(color: Colors.white),
                              validation: 'email_validator'.tr,
                              prefixIcon: Icons.email_outlined,
                              context: context),
                          SizedBox(height: 15),
                          textFormField(
                              type: TextInputType.visiblePassword,
                              controller: passwordController,
                              style: TextStyle(color: Colors.white),
                              validation: "password_validator".tr,
                              label: "password".tr,
                              prefixIcon: Icons.lock,
                              fun: () {
                                FoxLoginCubit.get(context)
                                    .changeVisibility();
                              },
                              isPassword:
                                  FoxLoginCubit.get(context).isPassword,
                              suffixIcon: FoxLoginCubit.get(context).icon,
                              context: context),
                          defaultTextButton(
                              textColor: Colors.white,
                              text: 'forgot_password'.tr,
                              fun: () {
                                navigateTo(context, ForgotPassword());
                              }),
                          ConditionalBuilder(
                            condition: state is! FoxLoginLoadingState,
                            builder: (BuildContext context) =>
                                buttonBuilder(
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
                              borderRadius: 40.0,
                              isUpper: false,
                              textColor: Colors.white,
                              width: double.infinity,
                            ),
                            fallback: (BuildContext context) => Center(
                                child: const CircularProgressIndicator()),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account? ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                          color: Colors.white, fontSize: 14),
                                ),
                                TextButton(
                                    onPressed: () {
                                      navigateTo(context, RegisterScreen());
                                    },
                                    child: Text('Sign Up', style: Theme.of(context).textTheme.caption!.copyWith(
                                      color: buttonColor, fontSize: 14
                                    ),))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
