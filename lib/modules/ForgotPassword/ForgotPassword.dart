import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fox_delivery/modules/ForgotPassword/CheckEmailScreen.dart';
import 'package:fox_delivery/shared/components/components.dart';
import 'package:fox_delivery/styles/Themes.dart';
import 'package:get/get.dart';

class ForgotPassword extends StatelessWidget {
  var emailController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Reset Password',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.white),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Enter the email associated with your account and we'll send an email with instructions to reset your password",
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                    color: Colors.grey[400], fontSize: 15),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          textFormField(
                              context: context,
                              controller: emailController,
                              label: 'Email address',
                              validation: 'Please enter your email address',
                              prefixIcon: Icons.email_outlined,
                              style: TextStyle(color: Colors.white),
                              type: TextInputType.emailAddress),
                          SizedBox(
                            height: 20,
                          ),
                          defaultButton(
                              text: 'Reset Password',
                              fun: () {
                                if (formKey.currentState!.validate()) {
                                  navigateTo(context, CheckEmailScreen());
                                  FirebaseAuth.instance
                                      .sendPasswordResetEmail(
                                          email: emailController.text)
                                      .then((value) {
                                    Get.snackbar(
                                        'Fox Delivery', 'Check your email',
                                        backgroundColor: buttonColor);
                                    ;
                                  });
                                }
                              },
                              backgroundColor: buttonColor,
                              TextColor: Colors.white)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
