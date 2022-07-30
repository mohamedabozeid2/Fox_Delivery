import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';

class MainScreen extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  final ZoomDrawerController drawerController;

  MainScreen({
    required this.drawerController
  });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.menu
          ),
          onPressed: (){
            drawerController.toggle?.call();
          },
        ),
        title: Text("Home Screen"),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Home Screen')
          ],
        ),
      ),
    );
  }
}
