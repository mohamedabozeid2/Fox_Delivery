import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fox_delivery/models/PackageModel.dart';
import 'package:fox_delivery/modules/UserPackagesDisplayScreen/PackageDisplayContent.dart';
import 'package:fox_delivery/shared/cubit/cubit.dart';
import 'package:fox_delivery/shared/cubit/states.dart';
import 'package:fox_delivery/styles/Themes.dart';

class PackageDetailsScreen extends StatelessWidget {
  final int packageIndex;
  final PackageModel package;

  PackageDetailsScreen({required this.packageIndex, required this.package});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoxCubit, FoxStates>(
      listener: (context, state) {
        if(state is FoxGetUserPackagesSuccessState){}
      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: thirdDefaultColor,
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: secondDefaultColor,
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: state is FoxGetUserPackagesLoadingState
                      ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                      : PackageContent(
                    fromTracking: false,
                    package: package,
                    packageIndex: packageIndex,
                  ),
                )
              ],
            ));
      },
    );
  }
}
