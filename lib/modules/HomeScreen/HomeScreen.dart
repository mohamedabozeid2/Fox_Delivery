import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:fox_delivery/modules/AboutUs/AboutUs.dart';
import 'package:fox_delivery/modules/ContactUs/ContactUs.dart';
import 'package:fox_delivery/modules/HomeScreen/MainScreen.dart';
import 'package:fox_delivery/modules/HomeScreen/MenuScreen.dart';
import 'package:fox_delivery/modules/SettingsScreen/SettingsScreen.dart';
import 'package:fox_delivery/shared/constants/constants.dart';
import 'package:fox_delivery/shared/cubit/cubit.dart';
import 'package:fox_delivery/shared/cubit/states.dart';
import 'package:fox_delivery/shared/network/local/CacheHelper.dart';
import 'package:fox_delivery/styles/Themes.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final drawerController = ZoomDrawerController();
  MenuItemDetails currentItem = MenuItems.home;
  @override
  // void initState() {
  //   FoxCubit.get(context).getUserData(userID: uId);
  //
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => FoxCubit()..checkConnection()..getUserData(userID: uId)/*..getUserData(userID: userModel!.uId!)*/,
      child: BlocConsumer<FoxCubit, FoxStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ZoomDrawer(
            menuScreenWidth: double.infinity,
              mainScreenTapClose: true,
              isRtl: selectedLanguage == 'ar' ? true : false,
              moveMenuScreen: true,
              style: DrawerStyle.defaultStyle,
              menuScreen: Builder(
                builder: (context) =>
                    MenuScreen(
                        currentItem: currentItem, onSelectedItem: (item) {
                      setState(() {
                        currentItem = item;
                        ZoomDrawer.of(context)!.close();
                      });
                    }),
              ),
              mainScreen: getScreen(),
              controller: drawerController,
              borderRadius: 24.0,
              showShadow: true,
              angle: 0.0,
              drawerShadowsBackgroundColor: Colors.grey,
              slideWidth: MediaQuery
                  .of(context)
                  .size
                  .width * 0.55,
              openCurve: Curves.fastOutSlowIn,
              menuBackgroundColor: defaultColor.withOpacity(0.4)/*Color(0xff274472)*/ /*0xff5860db*/
          );
        },
      ),
    );
  }
  Widget getScreen() {
    if(currentItem == MenuItems.home){
      return MainScreen(drawerController: drawerController);
    }else if(currentItem == MenuItems.settings){
      return SettingScreen(drawerController: drawerController);
    }else if(currentItem == MenuItems.aboutUs){
      return AboutUs(drawerController: drawerController);
    }else{
      return ContactUs(drawerController: drawerController);
    }
  }

}
