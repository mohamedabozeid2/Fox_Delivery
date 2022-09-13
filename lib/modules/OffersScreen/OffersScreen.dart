import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fox_delivery/modules/OffersScreen/OfferDetails.dart';
import 'package:fox_delivery/shared/components/components.dart';
import 'package:fox_delivery/shared/constants/constants.dart';
import 'package:fox_delivery/shared/cubit/cubit.dart';
import 'package:fox_delivery/shared/cubit/states.dart';
import 'package:fox_delivery/styles/Themes.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class OffersScreen extends StatefulWidget {
  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  @override
  void initState() {
    // FoxCubit.get(context).getOffers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(offers.length);
    return BlocConsumer<FoxCubit, FoxStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Offers'),
          ),
          body: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: offers.isEmpty
                    ? Column(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.local_offer,
                                    size: 50, color: thirdDefaultColor),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                  'No offers now',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: thirdDefaultColor,
                                      ),
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: thirdDefaultColor,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Column(
                            children: [
                              LottieBuilder.asset('assets/anims/offer.json'),
                              // Padding(
                              //   padding: const EdgeInsets.all(20.0),
                              //   child: Image(
                              //       image: AssetImage(
                              //     'assets/images/offers.png',
                              //   )),
                              // ),
                              Text(
                                '${offers.last.offerPercentage}% OFF',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      color: Colors.white,
                                      fontSize: 35,
                                    ),
                              ),
                              SizedBox(
                                height: 15.0,
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(20.0),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color:
                                          secondDefaultColor.withOpacity(0.8),
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${offers.last.label}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                color: Colors.white,
                                                fontSize: 20.0),
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Text(
                                        '${offers.last.body}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption!
                                            .copyWith(
                                                color: Colors.grey,
                                                fontSize: 15.0),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Spacer(),
                                      Row(
                                        children: [
                                          Text(
                                            'Expire: ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                color: Colors.white,
                                                fontSize: 20.0),
                                          ),
                                          Text(
                                            '${offers.last.expire}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption!
                                                .copyWith(
                                                color: Colors.grey,
                                                fontSize: 15.0),
                                          ),
                                          Spacer(),
                                          defaultButton(
                                              text: 'Details',
                                              width: Get.width * 0.25,
                                              backgroundColor: buttonColor,
                                              TextColor: Colors.white,
                                              borderRadius: 5,
                                              fun: () {
                                                navigateTo(context, OfferDetails());
                                              }),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                              /*InkWell(
                                child: Container(
                                  height: Get.height * 0.9,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.fitWidth,
                                          image: NetworkImage(
                                              '${offers.last.offerImage}'))),
                                ),
                                onTap: (){
                                  navigateTo(context, OfferDetails());
                                },
                              ),*/
                            ],
                          ),
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
