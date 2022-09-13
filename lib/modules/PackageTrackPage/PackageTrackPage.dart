import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fox_delivery/modules/UserPackagesDisplayScreen/PackageDisplayContent.dart';
import 'package:fox_delivery/shared/constants/constants.dart';
import 'package:fox_delivery/shared/cubit/cubit.dart';
import 'package:fox_delivery/shared/cubit/states.dart';
import 'package:fox_delivery/styles/Themes.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class PackageTrackPage extends StatefulWidget {
  final int id;

  PackageTrackPage({required this.id});

  @override
  State<PackageTrackPage> createState() => _PackageTrackPageState();
}

class _PackageTrackPageState extends State<PackageTrackPage> {
  @override
  void initState() {
    // FoxCubit.get(context)
    //     .getUserPackages(id: widget.id, fromTrackingScreen: true);
    FoxCubit.get(context).getSpecificPackage(id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoxCubit, FoxStates>(
      listener: (context, state) {
        if(state is FoxGetSpecificPackageSuccessState){
          FoxCubit.get(context).getUserPackages(fromTracking: true);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(),
              SliverFillRemaining(
                hasScrollBody: false,
                child: state is FoxGetSpecificPackageLoadingState
                    ? Center(
                        child: CircularProgressIndicator(
                        color: Colors.white,
                      ))
                    : Column(
                      children: [
                        sliderValue != 0
                            ? Column(
                                crossAxisAlignment: sliderValue == 1
                                    ? CrossAxisAlignment.start
                                    : sliderValue == 2
                                        ? CrossAxisAlignment.center
                                        : CrossAxisAlignment.end,
                                children: [
                                  Slider(
                                    value: sliderValue,
                                    onChanged: (_) {},
                                    inactiveColor: sliderValue == 1 ? Colors.red : Colors.white,
                                    activeColor: thirdDefaultColor,
                                    max: 4,
                                    min: 1,
                                    thumbColor: sliderValue == 1 ? Colors.red : buttonColor,
                                  ),
                                  // SizedBox(
                                  //   height: 15,
                                  // ),
                                  // Text(
                                  //   packageStatus,
                                  //   style: TextStyle(color: Colors.white),
                                  // ),
                                  // myDivider(color: Colors.white, paddingVertical: 15),
                                  PackageContent(fromTracking: true,packageIndex: widget.id-1, package: specificPackage!,)
                                ],
                              )
                            : Expanded(
                                child: Center(
                                    child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  LottieBuilder.asset('assets/anims/notFound.json'),
                                  // Icon(
                                  //   Icons.broken_image,
                                  //   color: thirdDefaultColor,
                                  //   size: 55,
                                  // ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    'package_not_found'.tr,
                                    style:
                                        TextStyle(color: Colors.white),
                                  ),
                                ],
                              ))),
                      ],
                    ),
              )
            ],
          ),
        );
      },
    );
  }
}
