import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:fox_delivery/locale/localeController.dart';
import 'package:fox_delivery/shared/components/components.dart';
import 'package:fox_delivery/shared/constants/constants.dart';
import 'package:fox_delivery/shared/cubit/cubit.dart';
import 'package:fox_delivery/shared/cubit/states.dart';
import 'package:fox_delivery/styles/Themes.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SettingScreen extends StatelessWidget {
  final ZoomDrawerController drawerController;

  var phoneController = TextEditingController();
  var locationController = TextEditingController();

  SettingScreen({required this.drawerController});

  @override
  Widget build(BuildContext context) {
    MyLocaleController localeController = Get.find();
    return BlocProvider(
      create: (BuildContext context) => FoxCubit(),
      child: BlocConsumer<FoxCubit, FoxStates>(
        listener: (context, state) {
          if(state is FoxGetUserDataSuccessState){
            phoneController.text = '';
            locationController.text = '';
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: Text('settings'.tr),
                  centerTitle: true,
                  leading: IconButton(
                    icon: const Icon(Icons.menu_outlined),
                    onPressed: () {
                      drawerController.toggle?.call();
                    },
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ToggleSwitch(
                              textDirectionRTL: selectedLanguage != 'en' ? true : false,

                              customWidths: [90.0, 90.0],
                              cornerRadius: 20.0,
                              activeBgColors: [[thirdDefaultColor],[thirdDefaultColor]],
                              activeFgColor: Colors.white,
                              inactiveBgColor: Colors.white,
                              inactiveFgColor: Colors.black,
                              totalSwitches: 2,
                              labels: [selectedLanguage == 'en' ? 'English' : 'العربية', selectedLanguage == 'en' ? 'العربية' : 'English'],
                              // icons: [null, FontAwesomeIcons.times],
                              onToggle: (index) {

                                localeController.changeLanguage(language: index == 1 ? 'en' : 'ar');
                                // print('switched to: $index');
                              },
                            ),
                            // Container(
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(15.0),
                            //   ),
                            //   child: SizedBox(
                            //     width: Get.width * 0.4,
                            //     child: DropdownButtonFormField<String>(
                            //         borderRadius: BorderRadius.circular(5),
                            //         style: Theme.of(context)
                            //             .textTheme
                            //             .bodyText2!
                            //             .copyWith(color: Colors.white),
                            //         decoration: InputDecoration(
                            //             enabledBorder: OutlineInputBorder(
                            //                 borderRadius:
                            //                     BorderRadius.circular(12.0),
                            //                 borderSide: BorderSide(
                            //                     width: 2, color: defaultColor)),
                            //             focusedBorder: OutlineInputBorder(
                            //                 borderRadius:
                            //                     BorderRadius.circular(12.0),
                            //                 borderSide: BorderSide(
                            //                     width: 2,
                            //                     color: defaultColor))),
                            //         dropdownColor: dropDownMenuColor,
                            //         value: selectedLanguage,
                            //         items: FoxCubit.get(context)
                            //             .languagesList
                            //             .map(buildMenuItem)
                            //             .toList(),
                            //         onChanged: (value) {
                            //           localeController.changeLanguage(
                            //               language: value!);
                            //         }),
                            //   ),
                            // ),
                            Text(
                              'language'.tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: Colors.white),
                            )
                          ],
                        ),
                        myDivider(color: defaultColor, paddingVertical: 15),
                        textFormFieldWithHint(
                            context: context,
                            controller: phoneController,
                            label: userModel!.phone!,
                            prefixIcon: Icon(Icons.phone),
                            type: TextInputType.phone,
                            borderColor: Colors.white),
                        SizedBox(
                          height: 10.0,
                        ),
                        textFormFieldWithHint(
                            context: context,
                            controller: locationController,
                            label: userModel!.location!,
                            prefixIcon: Icon(Icons.location_on),
                            type: TextInputType.text,
                            borderColor: Colors.white),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: defaultButton(
                                    text: 'Update Phone',
                                    fun: () {
                                      if (userModel!.phone ==
                                          phoneController.text.trim()) {
                                        showToast(
                                            msg:
                                                'You entered the old Phone number',
                                            color: Colors.red,
                                            textColor: Colors.white);
                                      } else if (phoneController.text.trim() ==
                                          '') {
                                        showToast(
                                            msg: 'Please enter a valid phone',
                                            color: Colors.red,
                                            textColor: Colors.white);
                                      } else {
                                        FoxCubit.get(context).updateUserPhone(
                                          phone: phoneController.text.trim(),
                                        );
                                        showToast(
                                            msg:
                                                'Your number has been updated successfully',
                                            color: buttonColor,
                                            textColor: Colors.white);
                                      }
                                    },
                                    backgroundColor: buttonColor,
                                    TextColor: Colors.white,
                                    borderRadius: 5.0)),
                            SizedBox(
                              width: 5.0,
                            ),
                            Expanded(
                                child: defaultButton(
                                    text: 'Update Location',
                                    fun: () {
                                      if (userModel!.location ==
                                          locationController.text.trim()) {
                                        showToast(
                                            msg: 'You entered the old location',
                                            textColor: Colors.white,
                                            color: Colors.red);
                                      } else if (locationController.text
                                              .trim() ==
                                          '') {
                                        showToast(
                                            msg:
                                                'Please enter a valid location',
                                            color: Colors.red,
                                            textColor: Colors.white);
                                      } else {
                                        FoxCubit.get(context)
                                            .updateUserLocation(
                                                location: locationController
                                                    .text
                                                    .trim());
                                        showToast(
                                            msg:
                                                'Your location has been updated successfully',
                                            color: buttonColor,
                                            textColor: Colors.white);
                                      }
                                    },
                                    backgroundColor: buttonColor,
                                    TextColor: Colors.white,
                                    borderRadius: 5.0)),
                          ],
                        )
                      ],
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

  DropdownMenuItem<String> buildMenuItem(String item) {
    return DropdownMenuItem(
      value: item,
      child: Text(item),
    );
  }
}
