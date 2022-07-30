import 'package:flutter/material.dart';

class MenuItemDetails {
  final String title;
  final IconData icon;

  const MenuItemDetails(this.title, this.icon);
}

class MenuItems {
  static const home = MenuItemDetails('Home', Icons.home);
  static const settings = MenuItemDetails('Settings', Icons.settings);


  static const menuItemList = <MenuItemDetails>[
    home,
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
    return SafeArea(
        child: Column(
          children: [
            Spacer(),
            ...MenuItems.menuItemList.map(buildMenuItem).toList(),
            Spacer(
              flex: 2,
            )
          ],
        ));
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
