import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fox_delivery/models/BoadingModel.dart';
import 'package:fox_delivery/modules/FirstScreen/FirstScreen.dart';
import 'package:fox_delivery/shared/components/components.dart';
import 'package:fox_delivery/shared/network/local/CacheHelper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../styles/Themes.dart';

class BoardingScreen extends StatefulWidget {
  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  PageController boardingController = PageController();

  bool isLast = false;

  List<BoardingModel> boardingList = [
    BoardingModel(
        image: 'assets/images/Boarding1.png',
        title: 'Boarding Title 1',
        body: "Boarding Title 1"),
    BoardingModel(
        image: 'assets/images/Boarding2.png',
        title: 'Boarding Title 2',
        body: "Boarding Title 2"),
    BoardingModel(
        image: 'assets/images/Boarding3.png',
        title: 'Boarding Title 3',
        body: "Boarding Title 3"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
              textColor: thirdDefaultColor,
              text: 'Skip',
              weight: FontWeight.bold,
              fontSize: 18.0,
              fun: () {
                navigateAndFinish(context: context, widget: FirstScreen());
                CacheHelper.saveData(key: 'onBoarding', value: true);
              })
        ],
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
                child: PageView.builder(
                  onPageChanged: (value) {
                    if (value == boardingList.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  controller: boardingController,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return buildBoardingItem(boardingList[index]);
                  },
                  itemCount: boardingList.length,
                )),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardingController,
                    count: boardingList.length,
                    effect: ExpandingDotsEffect(
                      activeDotColor: thirdDefaultColor,
                      dotWidth: 15,
                    )),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast == true) {
                      navigateAndFinish(
                          context: context, widget: FirstScreen());
                      CacheHelper.saveData(key: 'onBoarding', value: true);
                    } else {
                      boardingController.nextPage(
                          duration: const Duration(milliseconds: 950),
                          curve: Curves.fastOutSlowIn);
                    }
                  },
                  backgroundColor: thirdDefaultColor,
                  child: const Icon(Icons.arrow_forward_ios),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(image: AssetImage(model.image)),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            model.title,
            textAlign: TextAlign.center,
            style: TextStyle(color: secondDefaultColor),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            model.body,
            textAlign: TextAlign.center,
            style: TextStyle(color: secondDefaultColor),
          ),
        ],
      ),
    );
  }
}
