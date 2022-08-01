import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fox_delivery/models/PackageModel.dart';
import 'package:fox_delivery/modules/UserPackagesDisplayScreen/PackageDetailsScreen.dart';
import 'package:fox_delivery/shared/components/components.dart';
import 'package:fox_delivery/shared/constants/constants.dart';
import 'package:fox_delivery/shared/cubit/cubit.dart';
import 'package:fox_delivery/shared/cubit/states.dart';
import 'package:fox_delivery/styles/Themes.dart';

class UserPackagesDisplayScreen extends StatefulWidget {
  @override
  State<UserPackagesDisplayScreen> createState() =>
      _UserPackagesDisplayScreenState();
}

class _UserPackagesDisplayScreenState extends State<UserPackagesDisplayScreen> {
  @override
  void initState() {
    FoxCubit.get(context).getUserPackages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoxCubit, FoxStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          // backgroundColor: thirdDefaultColor,
          body: CustomScrollView(
            physics: NeverScrollableScrollPhysics(),
            slivers: [
              SliverAppBar(),
              SliverFillRemaining(
                hasScrollBody: true,
                child: Padding(
                  padding: const EdgeInsets.only(
                      bottom: 20.0, right: 20.0, left: 20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return packageItemBuilder(userPackages[index]);
                            },
                            separatorBuilder: (context, index) {
                              return myDivider(color: Colors.white);
                            },
                            itemCount: userPackages.length),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget packageItemBuilder(PackageModel model) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    model.packageName!,
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    model.description!,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  )
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
            Column(
              children: [
                defaultButton(
                    text: 'Details',
                    fun: () {
                      navigateTo(context, PackageDetailsScreen(model: model));
                    },
                    width: 100,
                    backgroundColor: thirdDefaultColor,
                    TextColor: Colors.white)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
