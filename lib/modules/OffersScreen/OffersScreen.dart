import 'package:flutter/material.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(),
          SliverFillRemaining(
            hasScrollBody: false,

          )
        ],
      ),
    );
  }
}
