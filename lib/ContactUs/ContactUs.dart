import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';

class ContactUs extends StatelessWidget {

  var scaffoldKey = GlobalKey<ScaffoldState>();

  final ZoomDrawerController drawerController;
  ContactUs({required this.drawerController});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          drawerController.toggle?.call();
        },icon: Icon(Icons.menu_outlined)),
        title: Text('Contact Us'),
      ),
    );
  }
}
