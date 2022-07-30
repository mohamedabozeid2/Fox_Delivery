import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:fox_delivery/modules/HomeScreen/MainScreen.dart';
import 'package:fox_delivery/modules/HomeScreen/MenuScreen.dart';
import 'package:fox_delivery/modules/SettingsScreen/SettingsScreen.dart';
import 'package:fox_delivery/shared/cubit/cubit.dart';
import 'package:fox_delivery/shared/cubit/states.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final drawerController = ZoomDrawerController();
  MenuItemDetails currentItem = MenuItems.home;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => FoxCubit(),
      child: BlocConsumer<FoxCubit, FoxStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ZoomDrawer(
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
              menuBackgroundColor: Color(0xff274472) /*0xff5860db*/
          );
        },
      ),
    );
  }
  Widget getScreen() {
    if(currentItem == MenuItems.home){
      return MainScreen(drawerController: drawerController);
    }else{
      return SettingScreen(drawerController: drawerController);
    }
  }

}
