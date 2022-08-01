import 'package:flutter/material.dart';
import 'package:fox_delivery/modules/LoginScreen/LoginScreen.dart';
import 'package:fox_delivery/shared/components/components.dart';
import 'package:fox_delivery/styles/Themes.dart';

class CheckEmailScreen extends StatelessWidget {
  const CheckEmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Check Your Email', style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),),
            SizedBox(
              height: 20,
            ),
            Text(
              textAlign: TextAlign.center,
              'We have sent you an email to reset your password', style: Theme.of(context).textTheme.caption!.copyWith(
              color: Colors.white,
              fontSize: 17
            ),),
            SizedBox(
              height: 40,
            ),
            defaultButton(text: 'Done!', fun: (){
              navigateAndFinish(context: context, widget: LoginScreen());

            },
            backgroundColor: buttonColor,
              TextColor: Colors.white,

            )
          ],
        ),
      ),
    );
  }
}
