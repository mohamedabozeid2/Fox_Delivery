import 'package:flutter/material.dart';
import 'package:fox_delivery/models/PackageModel.dart';
import 'package:fox_delivery/styles/Themes.dart';

class PackageDetailsScreen extends StatelessWidget {
  final PackageModel model;

  PackageDetailsScreen({required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: thirdDefaultColor,
      body: CustomScrollView(
        physics: NeverScrollableScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: secondDefaultColor,
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      child: Image(
                          image: AssetImage('assets/images/package.png'),
                          ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(30.0), bottomLeft: Radius.circular(30.0)),
                    color: secondDefaultColor,
                  ),),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: thirdDefaultColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Package ID: ${model.packageId!}",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Package Name: ${model.packageName!}",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Package Description: ${model.description!}",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Package Destination: ${model.description!}',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Package From: ${model.fromLocation!}',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Client Name: ${model.clientName!}',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
