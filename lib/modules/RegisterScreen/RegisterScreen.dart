import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fox_delivery/modules/HomeScreen/HomeScreen.dart';
import 'package:fox_delivery/modules/RegisterScreen/cubit/RegisterCubit.dart';
import 'package:fox_delivery/modules/RegisterScreen/cubit/RegisterStates.dart';
import 'package:fox_delivery/shared/components/components.dart';
import 'package:fox_delivery/shared/constants/constants.dart';
import 'package:fox_delivery/shared/network/local/CacheHelper.dart';
import 'package:fox_delivery/styles/Themes.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var addressController = TextEditingController();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, FoxRegisterStates>(
        listener: (context, state) {
          if (state is FoxCreateUserSuccessState) {
            Get.snackbar('Fox Delivery',
                'Created Successfully \nPlease check your email',
                backgroundColor: buttonColor, colorText: Colors.white);
            CacheHelper.saveData(key: 'uId', value: state.uId);
            uId = CacheHelper.getData(key: 'uId');
            navigateAndFinish(context: context, widget: HomeScreen());
          } else if (state is FoxRegisterErrorState) {
            Get.snackbar('Fox Delivery', 'Failed Registration',
                backgroundColor: Colors.red[400], colorText: Colors.white);
            showToast(msg: state.error.toString());
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
                    padding: const EdgeInsets.all(25.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text('Create Account',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(color: Colors.white)),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          textFormField(
                            context: context,
                            controller: firstNameController,
                            label: "First Name",
                            type: TextInputType.name,
                            style: TextStyle(color: Colors.white),
                            prefixIcon: Icons.person,
                            validation: "Name Must Not Be Empty",
                            isPassword: false,
                            borderRadius: 5.0,
                          ),
                          SizedBox(
                            height: Get.height * 0.025,
                          ),
                          textFormField(
                            context: context,
                            controller: lastNameController,
                            label: "Last Name",
                            type: TextInputType.name,
                            style: TextStyle(color: Colors.white),
                            prefixIcon: Icons.person,
                            validation: "Name Must Not Be Empty",
                            isPassword: false,
                            borderRadius: 5.0,
                          ),
                          SizedBox(
                            height: Get.height * 0.025,
                          ),
                          textFormField(
                              style: TextStyle(color: Colors.white),
                              type: TextInputType.emailAddress,
                              controller: emailController,
                              label: "Email Address",
                              validation: "Please Enter Your Email Address",
                              prefixIcon: Icons.email_outlined,
                              context: context),
                          SizedBox(
                            height: Get.height * 0.025,
                          ),
                          textFormField(
                              style: TextStyle(color: Colors.white),
                              type: TextInputType.streetAddress,
                              controller: addressController,
                              label: "location".tr,
                              validation: "Please Enter Your Email Address",
                              prefixIcon: Icons.location_on,
                              context: context),
                          SizedBox(
                            height: Get.height * 0.025,
                          ),
                          textFormField(
                            style: TextStyle(color: Colors.white),
                            context: context,
                            controller: passwordController,
                            label: "Password",
                            type: TextInputType.visiblePassword,
                            prefixIcon: Icons.lock,
                            isPassword: RegisterCubit.get(context).isPassword,
                            suffixIcon: RegisterCubit.get(context).icon,
                            fun: () {
                              RegisterCubit.get(context).changeVisibility();
                            },
                            validation: "Password Must Not Be Empty",
                            borderRadius: 5.0,
                          ),
                          SizedBox(
                            height: Get.height * 0.025,
                          ),
                          textFormField(
                            style: TextStyle(color: Colors.white),
                            context: context,
                            controller: phoneController,
                            label: "Phone Number",
                            type: TextInputType.phone,
                            prefixIcon: Icons.phone,
                            validation: "Phone Must Not Be Empty",
                            isPassword: false,
                            borderRadius: 5.0,
                          ),
                          SizedBox(height: 50),
                          ConditionalBuilder(
                              condition: state is! FoxRegisterLoadingState,
                              builder: (context) => buttonBuilder(
                                  fun: () {
                                    if (formKey.currentState!.validate()) {
                                      if(passwordController.text.length < 8){
                                        showToast(msg: 'Password is very short',color: Colors.amber,textColor: Colors.white);
                                      }else{
                                        RegisterCubit.get(context).userRegister(
                                            firstName: firstNameController.text,
                                            lastName: lastNameController.text,
                                            email: emailController.text,
                                            phone: phoneController.text,
                                            password: passwordController.text,
                                            context: context);
                                      }

                                    }
                                  },
                                  text: "register".tr,
                                  width: double.infinity,
                                  textColor: Colors.white,
                                  height: 50),
                              fallback: (context) => const Center(
                                  child: CircularProgressIndicator())),
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
