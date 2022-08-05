import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fox_delivery/shared/components/components.dart';
import 'package:fox_delivery/shared/constants/constants.dart';
import 'package:fox_delivery/shared/cubit/cubit.dart';
import 'package:fox_delivery/shared/cubit/states.dart';
import 'package:fox_delivery/styles/Themes.dart';
import 'package:get/get.dart';

class PackageDetailsScreen extends StatelessWidget {
  final int packageIndex;

  PackageDetailsScreen({required this.packageIndex});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoxCubit, FoxStates>(
      listener: (context, state) {},
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
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: state is FoxGetUserPackagesLoadingState ? Center(child: CircularProgressIndicator()) : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: Get.height * 0.30,
                        decoration: BoxDecoration(color: thirdDefaultColor),
                        child: Stack(
                          children: [
                            Container(
                              height: Get.height * 0.20,
                              color: secondDefaultColor,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 50,
                                          backgroundColor: secondDefaultColor,
                                          backgroundImage: AssetImage(
                                              'assets/images/package3.png'),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              userPackages[packageIndex]
                                                  .clientFirstName!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2!
                                                  .copyWith(
                                                      color:
                                                          secondDefaultColor),
                                            ),
                                            Text(
                                              userPackages[packageIndex]
                                                  .clientLastName!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2!
                                                  .copyWith(
                                                      color:
                                                          secondDefaultColor),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Package ID :',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2!
                                                  .copyWith(
                                                      color: secondDefaultColor,
                                                      fontSize: 16),
                                            ),
                                            Text(
                                              ' ${userPackages[packageIndex].packageId!}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2!
                                                  .copyWith(
                                                      color: secondDefaultColor,
                                                      fontSize: 16),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  height: Get.height * 0.25,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

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
                                    Table(
                                      textBaseline: TextBaseline.alphabetic,
                                      border: TableBorder.symmetric(
                                          inside:
                                              BorderSide(color: Colors.black)),
                                      children: [
                                        buildTableRow('Package ID: ',
                                            "${userPackages[packageIndex].packageId}"),
                                        buildTableRow('Client Name: ',
                                            "${userPackages[packageIndex].clientFirstName} ${userPackages[packageIndex].clientLastName}"),
                                        buildTableRow('Package Name: ',
                                            "${userPackages[packageIndex].packageName}"),
                                        buildTableRow('Package Description: ',
                                            "${userPackages[packageIndex].description}"),
                                        buildTableRow('Package From: ',
                                            "${userPackages[packageIndex].fromLocation}"),
                                        buildTableRow('Package To: ',
                                            "${userPackages[packageIndex].toLocation}"),
                                        buildTableRow('Order Time: ',
                                            "${userPackages[packageIndex].dateTimeDisplay}"),
                                        buildTableRow('Status ',
                                            "${userPackages[packageIndex].status}"),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: defaultButton(
                                              text: 'Ok!',
                                              fun: () {
                                                Navigator.pop(context);
                                              },
                                              borderRadius: 15,
                                              TextColor: Colors.white,
                                              backgroundColor: buttonColor),
                                        ),
                                        if (userPackages[packageIndex].status ==
                                            'New')
                                          SizedBox(
                                            width: 10,
                                          ),
                                        if (userPackages[packageIndex].status ==
                                            'New')
                                          Expanded(
                                            child: defaultButton(
                                                text: 'Cancel Order',
                                                fun: () {
                                                  FoxCubit.get(context).cancelOrder(
                                                      id: packagesID[
                                                          packageIndex],
                                                      clientFirstName:
                                                          userPackages[packageIndex]
                                                              .clientFirstName!,
                                                      clientLastName:
                                                          userPackages[packageIndex]
                                                              .clientLastName!,
                                                      clientUid: userPackages[packageIndex]
                                                          .clientUid!,
                                                      dateTime: userPackages[packageIndex]
                                                          .dateTime!,
                                                      dateTimeDisplay:
                                                          userPackages[packageIndex]
                                                              .dateTimeDisplay!,
                                                      description:
                                                          userPackages[packageIndex]
                                                              .description!,
                                                      fromLocation:
                                                          userPackages[packageIndex]
                                                              .fromLocation!,
                                                      toLocation:
                                                          userPackages[packageIndex]
                                                              .toLocation!,
                                                      packageId:
                                                          userPackages[packageIndex]
                                                              .packageId!,
                                                      packageName:
                                                          userPackages[packageIndex]
                                                              .packageName!);
                                                  print(userPackages.length);
                                                },
                                                backgroundColor: Colors.amber,
                                                TextColor: Colors.white),
                                          )
                                      ],
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
      },
    );
  }

  TableRow buildTableRow(String text1, String text2) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            text1,
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            text2,
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
      ],
    );
  }
}
