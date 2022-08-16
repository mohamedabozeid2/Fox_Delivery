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
    // FoxCubit.get(context).getUserPackages();
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
                      bottom: 20.0, ),
                  child: state is FoxGetUserPackagesLoadingState
                      ? Center(child: CircularProgressIndicator())
                      : Column(
                          children: [
                            userPackages.length != 0
                                ? Expanded(
                                    child: ListView.separated(
                                        physics: BouncingScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return packageItemBuilder(
                                              model: userPackages[index], index: index);
                                        },
                                        separatorBuilder: (context, index) {
                                          return SizedBox(height: 10,);
                                        },
                                        itemCount: userPackages.length),
                                  )
                                : Expanded(
                                  child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.work_off,
                                            color: Colors.white,
                                            size: 50.0,
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            'No Packages Yet',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
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

  Widget packageItemBuilder({required PackageModel model, required int index}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
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
                    Text(model.dateTimeDisplay!,
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontSize: 14))
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
              Column(
                children: [
                  defaultButton(
                      text: 'Details',
                      fun: () {
                        navigateTo(context, PackageDetailsScreen(packageIndex: index, package: userPackages[index],));
                      },
                      width: 100,
                      backgroundColor: thirdDefaultColor,
                      TextColor: Colors.white)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
