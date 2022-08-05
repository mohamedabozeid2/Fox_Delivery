import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fox_delivery/shared/constants/constants.dart';
import 'package:fox_delivery/shared/cubit/cubit.dart';
import 'package:fox_delivery/shared/cubit/states.dart';
import 'package:fox_delivery/styles/Themes.dart';

class PackageTrackPage extends StatefulWidget {
  final int id;

  PackageTrackPage({required this.id});

  @override
  State<PackageTrackPage> createState() => _PackageTrackPageState();
}

class _PackageTrackPageState extends State<PackageTrackPage> {
  @override
  void initState() {
    FoxCubit.get(context)
        .getUserPackages(id: widget.id, fromTrackingScreen: true);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoxCubit, FoxStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(),
              SliverFillRemaining(
                hasScrollBody: false,
                child: state is FoxGetUserPackagesLoadingState
                    ? Center(
                        child: CircularProgressIndicator(
                        color: thirdDefaultColor,
                      ))
                    : Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
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
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        packageStatus,
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  )
                                : Expanded(
                                    child: Center(
                                        child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.broken_image,
                                        color: thirdDefaultColor,
                                        size: 55,
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Text(
                                        'Package Not Found',
                                        style:
                                            TextStyle(color: thirdDefaultColor),
                                      ),
                                    ],
                                  ))),
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
}
