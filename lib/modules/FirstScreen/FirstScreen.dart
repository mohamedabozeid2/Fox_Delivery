import 'package:flutter/material.dart';
import 'package:fox_delivery/modules/LoginScreen/LoginScreen.dart';
import 'package:fox_delivery/modules/RegisterScreen/RegisterScreen.dart';
import 'package:fox_delivery/shared/components/components.dart';
import 'package:fox_delivery/styles/Themes.dart';
import 'package:get/get.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff5967A4),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(image: AssetImage('assets/images/logo.png')),
                SizedBox(height: Get.height * 0.03),
                Text(
                  'welcome'.tr,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.white),
                ),
                SizedBox(
                  height: Get.height * 0.08,
                ),
                defaultButton(
                  fun: () {
                    navigateTo(context, LoginScreen());
                  },
                  backgroundColor: Colors.white,
                  text: 'login'.tr,
                  borderRadius: 15,
                  width: Get.width * 0.85,
                  TextColor: defaultColor,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.04,
                ),
                defaultButton(
                  fun: () {
                    navigateTo(context, RegisterScreen());
                  },
                  backgroundColor: Colors.white,
                  text: 'register'.tr,
                  borderRadius: 15,
                  width: Get.width * 0.85,
                  TextColor: defaultColor,
                ),
                SizedBox(
                  height: Get.height * 0.08,
                ),
                defaultTextButton(
                    text: 'forgot_password'.tr,
                    fontSize: 20,
                    fun: () {
                      print("HEY");
                    },
                    textColor: Colors.white
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
