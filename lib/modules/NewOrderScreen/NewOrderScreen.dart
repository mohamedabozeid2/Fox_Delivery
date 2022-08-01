import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fox_delivery/shared/components/components.dart';
import 'package:fox_delivery/shared/constants/constants.dart';
import 'package:fox_delivery/shared/cubit/cubit.dart';
import 'package:fox_delivery/shared/cubit/states.dart';
import 'package:fox_delivery/styles/Themes.dart';
import 'package:get/get.dart';

class NewOrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var toLocation = TextEditingController();
    var fromLocation = TextEditingController();
    var packageName = TextEditingController();
    var packageDescription = TextEditingController();

    print(userModel!.name);

    return BlocConsumer<FoxCubit, FoxStates>(
      listener: (context, state) {
        if (state is FoxNewOrderSuccessState) {
          Navigator.pop(context);
          Get.snackbar('Fox Delivery', 'Your order submitted succesffully',
              colorText: Colors.white, backgroundColor: Colors.green[400]);
        } else if (state is FoxNewOrderErrorState) {
          Get.snackbar('Fox Delivery', 'Failed');
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: CustomScrollView(
            physics: ScrollPhysics(),
            slivers: [
              SliverAppBar(),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Image(image: AssetImage('assets/images/new_order.png')),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: textFormFieldWithHint(
                                  context: context,
                                  controller: packageName,
                                  label: 'Package Name',
                                  style: TextStyle(color: secondDefaultColor),
                                  type: TextInputType.text,
                                  borderColor: Colors.white,
                                  borderRadius: 15.0),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: textFormFieldWithHint(
                                  context: context,
                                  controller: packageDescription,
                                  label: 'Package Description',
                                  style: TextStyle(color: secondDefaultColor),
                                  type: TextInputType.text,
                                  borderColor: Colors.white,
                                  borderRadius: 15.0),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: textFormFieldWithHint(
                                  context: context,
                                  controller: fromLocation,
                                  label: 'From',
                                  style: TextStyle(color: secondDefaultColor),
                                  type: TextInputType.text,
                                  borderColor: Colors.white,
                                  borderRadius: 15.0),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: textFormFieldWithHint(
                                  context: context,
                                  controller: toLocation,
                                  label: 'To',
                                  style: TextStyle(color: secondDefaultColor),
                                  type: TextInputType.text,
                                  borderColor: Colors.white,
                                  borderRadius: 15.0),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultButton(
                          text: 'Order',
                          fun: () {
                            FoxCubit.get(context).newOrder(
                                packageName: packageName.text,
                                description: packageDescription.text,
                                fromLocation: fromLocation.text,
                                toLocation: toLocation.text);
                          },
                          borderRadius: 15.0,
                          TextColor: Colors.white,
                          backgroundColor: buttonColor,
                          width: Get.width * 0.3)
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
