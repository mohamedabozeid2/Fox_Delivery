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

class SettingScreen extends StatelessWidget {
  final ZoomDrawerController drawerController;

  SettingScreen({required this.drawerController});

  @override
  Widget build(BuildContext context) {
    MyLocaleController localeController = Get.find();
    return BlocProvider(
      create: (BuildContext context) => FoxCubit(),
      child: BlocConsumer<FoxCubit, FoxStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(

            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(
                    Icons.menu_outlined
                ),
                onPressed: (){
                  drawerController.toggle?.call();
                },
              ),
              centerTitle: true,
              title: Text('settings'.tr),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: SizedBox(
                          width: Get.width * 0.4,
                          child: DropdownButtonFormField<String>(
                            borderRadius: BorderRadius.circular(10),
                              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                color: Colors.white

                              ),
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: BorderSide(
                                          width: 2, color: defaultColor)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: BorderSide(
                                          width: 2, color: defaultColor))),
                              dropdownColor: dropDownMenuColor,
                              value: selectedLanguage,
                              items: FoxCubit.get(context)
                                  .languagesList
                                  .map(buildMenuItem)
                                  .toList(),
                              onChanged: (value) {
                                localeController.changeLanguage(
                                    language: value!);
                              }),
                        ),
                      ),
                      Text(
                        'language'.tr,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Colors.white
                        ),
                      )
                    ],
                  ),
                  myDivider(color: defaultColor, paddingVertical: 15),
                  defaultButton(
                    TextColor: Colors.white,
                    text: "Sign Out",
                      fun: (){
                    FoxCubit.get(context).signOut(context);
                  },
                  backgroundColor: buttonColor,
                    width: 100,
                    height: 50,
                  )
                ],
              ),
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
