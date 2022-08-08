import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fox_delivery/modules/HomeScreen/MainScreen.dart';
import 'package:fox_delivery/shared/components/components.dart';
import 'package:fox_delivery/shared/constants/constants.dart';
import 'package:fox_delivery/shared/cubit/cubit.dart';
import 'package:fox_delivery/shared/cubit/states.dart';
import 'package:fox_delivery/styles/Themes.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

class NewOrderScreen extends StatefulWidget {
  @override
  State<NewOrderScreen> createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  @override
  void initState() {
    FoxCubit.get(context).getPackagesNumber();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var toLocation = TextEditingController();
    var fromLocation = TextEditingController();
    var packageName = TextEditingController();
    var packageDescription = TextEditingController();
    var formKey = GlobalKey<FormState>();


    return BlocConsumer<FoxCubit, FoxStates>(
      listener: (context, state) {
        if (state is FoxNewOrderSuccessState) {
          // navigateTo(context, UserPackagesDisplayScreen());
          navigateTo(context, MainScreen(drawerController: drawerController));
          Get.snackbar('Fox Delivery', 'Your order submitted successfully',
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
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Container(child: Image(image: AssetImage('assets/images/new_order.png'))),
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text('Your package ID is: $packageIDCounter', style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                color: Colors.white
                              ),),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: textFormFieldWithHint(
                                    context: context,
                                    controller: packageName,
                                    label: 'Package Name',
                                    style: TextStyle(color: Colors.grey),
                                    validation: 'Please enter a name for your package',
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
                                    validation: 'Please enter a description for your package',
                                    label: 'Package Description',
                                    style: TextStyle(color: Colors.grey),
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
                                    validation: 'Please enter the location of your package',
                                    label: 'From',
                                    style: TextStyle(color: Colors.grey),
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
                                    validation: 'Please enter the destination of your package',
                                    label: 'To',
                                    style: TextStyle(color: Colors.grey),
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
                        // defaultButton(
                        //     text: 'Order',
                        //     fun: () {
                        //       FoxCubit.get(context).newOrder(
                        //           packageName: packageName.text,
                        //           description: packageDescription.text,
                        //           fromLocation: fromLocation.text,
                        //           toLocation: toLocation.text);
                        //     },
                        //     borderRadius: 15.0,
                        //     TextColor: Colors.white,
                        //     backgroundColor: buttonColor,
                        //     width: Get.width * 0.3),
                        state is FoxNewOrderLoadingState ? Center(child: CircularProgressIndicator(color: thirdDefaultColor,)) : ConfirmationSlider(
                          onConfirmation: () {
                            if(formKey.currentState!.validate()){
                              FoxCubit.get(context).newOrder(
                                  packageName: packageName.text,
                                  description: packageDescription.text,
                                  fromLocation: fromLocation.text,
                                  toLocation: toLocation.text,
                                dateTime: DateTime.now().toString(),
                                dateTimeDisplay: DateFormat.yMMMd().add_jm().format(now).toString()
                              );
                            }

                          },
                          backgroundColor: thirdDefaultColor,
                          backgroundColorEnd: buttonColor,
                          foregroundColor: buttonColor,
                          textStyle: TextStyle(color: Colors.white,fontSize: 15
                          ),
                          height: 60,
                        ),

                      ],
                    ),
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
