import 'package:flutter/material.dart';
import 'package:fox_delivery/shared/components/components.dart';

class PhoneAuthenticationScreen extends StatelessWidget {

  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Verification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            textFormField(context: context, controller: otpController, label: 'Anything', type: TextInputType.phone)
          ],
        ),
      ),
    );
  }
}
