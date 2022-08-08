import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:fox_delivery/modules/NewOrderScreen/NewOrderScreen.dart';
import 'package:fox_delivery/modules/PackageTrackPage/PackageTrackPage.dart';
import 'package:fox_delivery/modules/Services/Notifications.dart';
import 'package:fox_delivery/modules/UserPackagesDisplayScreen/UserPackagesDisplayScreen.dart';
import 'package:fox_delivery/shared/components/components.dart';
import 'package:fox_delivery/shared/constants/constants.dart';
import 'package:fox_delivery/shared/cubit/cubit.dart';
import 'package:fox_delivery/shared/cubit/states.dart';
import 'package:fox_delivery/shared/network/EndPoint.dart';
import 'package:fox_delivery/shared/network/remote/Dio_Helper.dart';
import 'package:fox_delivery/styles/Themes.dart';

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
    FoxCubit.get(context).getUserData(userID: uId);
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
                                          bottom: 0.0,
                                          top: 20.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Tracking Your Package',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(color: Colors.white),
                                          ),
                                          SizedBox(
                                            height: 15.0,
                                          ),
                                          Text(
                                            "Please enter your package ID",
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
                                                    label: 'Enter package ID',
                                                    type: TextInputType.number,
                                                    style: TextStyle(
                                                      color: thirdDefaultColor,
                                                    ),
                                                    validation:
                                                        'Please enter your package id',
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
                                                                  'please enter your package id',
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
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20.0,
                                                bottom: 5.0,
                                                right: 20.0,
                                                left: 20.0),
                                            child: Container(
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              child: Image(
                                                image: AssetImage(
                                                    'assets/images/Online_Shopping3.png'),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
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
                                            'What are you looking for?',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Row(
                                          children: [
                                            buildContentItem(
                                                icon: Icons.dashboard_rounded,
                                                text: "My Packages",
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
                                                text: "New Order",
                                                context: context,
                                                fun: () {
                                                  navigateTo(context,
                                                      NewOrderScreen());
                                                }),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          buildContentItem(
                                              context: context,
                                              fun: () {
                                                FoxCubit.get(context)
                                                    .sendNotification(
                                                        receiverToken:
                                                            'eqH7R0XvQWqrSqZVtpnT_E:APA91bELR9MFusDUIDSnELCFoFJ5LmxHHECzblsA-QyevcCA_2JU822bCgN0JTtZzzIHrWS4EyDvvZbEN3b8ulME8PECtg54gbJAz-7oPdaD2sZbDzTN6XcM2nc2nhmzSkVm9I5xpJRp',
                                                      title: 'Title message',
                                                  body: 'Body Message'
                                                );
                                                // service.showNotification(id: 0, title: 'Notification title', body: 'body', payload: 'payload');
                                                // Notifications.showNotification(
                                                //   title: 'Fox Delivery',
                                                //   payload: 'foxDelivery',
                                                //   body: 'Fox Says Hey',
                                                //
                                                // );
                                              },
                                              icon: Icons.add_circle_outlined,
                                              text: 'Hey')
                                        ],
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
