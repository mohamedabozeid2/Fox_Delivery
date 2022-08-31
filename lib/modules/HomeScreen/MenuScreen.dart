import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fox_delivery/shared/components/components.dart';
import 'package:fox_delivery/shared/cubit/cubit.dart';
import 'package:fox_delivery/shared/cubit/states.dart';
import 'package:fox_delivery/styles/Themes.dart';

class MenuItemDetails {
  final String title;
  final IconData icon;

  const MenuItemDetails(this.title, this.icon);
}

class MenuItems {
  static const home = MenuItemDetails('Home', Icons.home);
  static const contactUs = MenuItemDetails('Contact us', Icons.headphones_rounded);
  static const aboutUs = MenuItemDetails('About us', Icons.supervised_user_circle_sharp);
  static const settings = MenuItemDetails('Settings', Icons.settings);



  static const menuItemList = <MenuItemDetails>[
    home,
    contactUs,
    aboutUs,
    settings,
  ];
}

class MenuScreen extends StatelessWidget {
  final MenuItemDetails currentItem;
  final ValueChanged<MenuItemDetails> onSelectedItem;

  MenuScreen({
    required this.currentItem,
    required this.onSelectedItem,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoxCubit, FoxStates>(
      listener: (context, state){},
      builder: (context, state){
        return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image(image: AssetImage(
                      'assets/images/logo.png'
                  )),
                ),
                SizedBox(
                  height: 15.0,
                ),
                ...MenuItems.menuItemList.map(buildMenuItem).toList(),
                SizedBox(
                  height: 15.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: defaultButton(
                    TextColor: Colors.white,
                    text: "Sign Out",
                    fun: (){
                      FoxCubit.get(context).signOut(context);
                    },
                    backgroundColor: buttonColor,
                    width: 100,
                    height: 50,
                  ),
                ),
                Spacer(
                  flex: 2,
                )
              ],
            ));
      },
    );
  }

  Widget buildMenuItem(MenuItemDetails item) {
    return ListTile(

      selectedTileColor: Colors.black26,
      selected: currentItem == item,
      minLeadingWidth: 20,
      leading: Icon(
        item.icon,
        color: Colors.white,
        size: 25,
      ),
      title: Text(
        item.title,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
      ),
      onTap: () => onSelectedItem(item),
    );
  }
}
