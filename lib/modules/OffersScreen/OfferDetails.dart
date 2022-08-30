import 'package:flutter/material.dart';
import 'package:fox_delivery/shared/constants/constants.dart';
import 'package:fox_delivery/styles/Themes.dart';
import 'package:get/get.dart';

class OfferDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(offers.last.label!),
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          offers.last.body!,
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: thirdDefaultColor,
                                  ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          height: Get.height * 0.9,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fitWidth,
                                  image: NetworkImage(
                                      '${offers.last.offerImage}'))),
                        ),
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
  }
}
