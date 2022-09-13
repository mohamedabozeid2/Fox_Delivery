import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:fox_delivery/modules/NewOrderScreen/NewOrderScreen.dart';
import 'package:fox_delivery/modules/OffersScreen/OffersScreen.dart';
import 'package:fox_delivery/modules/PackageTrackPage/PackageTrackPage.dart';
import 'package:fox_delivery/modules/ReportScreen/ReportScreen.dart';
import 'package:fox_delivery/modules/Services/Notifications.dart';
import 'package:fox_delivery/modules/UserPackagesDisplayScreen/UserPackagesDisplayScreen.dart';
import 'package:fox_delivery/shared/components/components.dart';
import 'package:fox_delivery/shared/constants/constants.dart';
import 'package:fox_delivery/shared/cubit/cubit.dart';
import 'package:fox_delivery/shared/cubit/states.dart';
import 'package:fox_delivery/shared/network/local/CacheHelper.dart';
import 'package:fox_delivery/styles/Themes.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class MainScreen extends StatefulWidget {
  final ZoomDrawerController drawerController;

  MainScreen({required this.drawerController});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController packageTrackingController = TextEditingController();
  late final LocalNotificationService service;

  @override
  void initState() {
    service = LocalNotificationService();
    service.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoxCubit, FoxStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: CustomScrollView(
            physics: ScrollPhysics(),
            slivers: [
              SliverAppBar(
                backgroundColor: thirdDefaultColor,
                systemOverlayStyle:
                SystemUiOverlayStyle(statusBarColor: thirdDefaultColor),
                leading: IconButton(
                  onPressed: () {
                    widget.drawerController.toggle?.call();
                  },
                  icon: Icon(Icons.menu_outlined),
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: state is FoxGetUserDataLoadingState ||
                    state is FoxGetUserPackagesLoadingState
                    ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ))
                    : Center(
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: thirdDefaultColor,
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(40.0),
                                      bottomLeft: Radius.circular(40.0))),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0,
                                    right: 20.0,
                                    bottom: 10.0,
                                    top: 20.0),
                                child: Column(
                                  children: [
                                    Text(
                                      'tracking_your_package'.tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Text(
                                      "please_enter_your_package_id".tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                          color: Colors.grey[300],
                                          fontSize: 15),
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: textFormFieldWithHint(
                                              context: context,
                                              borderRadius: 5.0,
                                              borderColor: Colors.white,
                                              controller:
                                              packageTrackingController,
                                              label: 'enter_package_id'.tr,
                                              type: TextInputType.number,
                                              style: TextStyle(
                                                color: thirdDefaultColor,
                                              ),
                                              validation:
                                              'please_enter_your_package_id'.tr,
                                              prefixIcon: CircleAvatar(
                                                  backgroundColor:
                                                  thirdDefaultColor,
                                                  child: Icon(
                                                    Icons.fire_truck,
                                                    size: 18,
                                                    color: Colors.white,
                                                  )),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          CircleAvatar(
                                            radius: 25,
                                            backgroundColor: Colors.white,
                                            child: IconButton(
                                                onPressed: () {
                                                  if (packageTrackingController
                                                      .text.isNotEmpty) {
                                                    navigateTo(
                                                        context,
                                                        PackageTrackPage(
                                                            id: int.parse(
                                                                packageTrackingController
                                                                    .text)));
                                                  } else {
                                                    showToast(
                                                        msg:
                                                        'please_enter_your_package_id'.tr,
                                                        color:
                                                        thirdDefaultColor,
                                                        textColor:
                                                        Colors.white);
                                                  }
                                                },
                                                icon: Icon(
                                                  Icons.arrow_forward,
                                                  color:
                                                  thirdDefaultColor,
                                                )),
                                          )
                                          // defaultButton(
                                          //     text: 'Track',
                                          //     fun: () {},
                                          //     width: 70,
                                          //     borderRadius: 5,
                                          //     backgroundColor: secondDefaultColor,
                                          //     TextColor: Colors.white)
                                        ],
                                      ),
                                    ),
                                    LottieBuilder.asset('assets/anims/delivery.json', height: Get.height*0.4,width: Get.width*0.95,),
                                    // Padding(
                                    //   padding: const EdgeInsets.only(
                                    //       top: 20.0,
                                    //       bottom: 5.0,
                                    //       right: 20.0,
                                    //       left: 20.0),
                                    //   child: Container(
                                    //     clipBehavior:
                                    //     Clip.antiAliasWithSaveLayer,
                                    //     decoration: BoxDecoration(
                                    //       borderRadius:
                                    //       BorderRadius.circular(20.0),
                                    //     ),
                                    //     child: Image(
                                    //       image: AssetImage(
                                    //           'assets/images/Online_Shopping3.png'),
                                    //       fit: BoxFit.fill,
                                    //     ),
                                    //   ),
                                    // )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 35.0,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'what_are_you_looking_for'.tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(color: Colors.white),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 15.0),
                                  child: Row(
                                    children: [
                                      buildContentItem(
                                          icon: Icons.dashboard_rounded,
                                          text: "my_packages".tr,
                                          context: context,
                                          fun: () {
                                            navigateTo(context,
                                                UserPackagesDisplayScreen());
                                          }),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      buildContentItem(
                                          icon: Icons.add_circle_outlined,
                                          text: "new_order".tr,
                                          context: context,
                                          fun: () {
                                            navigateTo(context,
                                                NewOrderScreen());
                                          }),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 5),
                                  child: Row(
                                    children: [
                                      buildContentItem(
                                          context: context,
                                          fun: () {
                                            navigateTo(context, OffersScreen());
                                            // FoxCubit.get(context)
                                            //     .sendNotification(
                                            //     receiverToken:
                                            //     deviceToken!,
                                            //     title:
                                            //     'Title message',
                                            //     body: 'Body Message');

                                          },
                                          icon: Icons.local_offer,
                                          text: 'offers'.tr),
                                      SizedBox(
                                        width: 20.0,
                                      ),
                                      buildContentItem(
                                          context: context,
                                          fun: () {
                                            navigateTo(
                                                context, ReportScreen());
                                          },
                                          icon: Icons.bug_report,
                                          text: 'report_a_problem'.tr)
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                )
                              ],
                            )
                          ],
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

  Widget buildContentItem({
    required BuildContext context,
    required fun,
    required IconData icon,
    required String text,
  }) {
    return Expanded(
      child: InkWell(
        onTap: fun,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20.0)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  child: Icon(icon, color: thirdDefaultColor),
                  backgroundColor: Colors.amber,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  text,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: thirdDefaultColor, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
