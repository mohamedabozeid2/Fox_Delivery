import 'package:flutter/material.dart';
import 'package:fox_delivery/modules/HomeScreen/HomeScreen.dart';
import 'package:fox_delivery/shared/components/components.dart';
import 'package:fox_delivery/styles/Themes.dart';

class ReportSuccessScreen extends StatelessWidget {
  const ReportSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle_outline,
                        color: thirdDefaultColor, size: 75),
                    SizedBox(
                      height: 15,
                    ),
                    Text('Thanks for your report',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: Colors.white)),
                    SizedBox(
                      height: 20.0,
                    ),
                    defaultButton(
                        text: 'Done',
                        borderRadius: 5.0,
                        backgroundColor: buttonColor,
                        TextColor: Colors.white,
                        fun: () {
                          navigateAndFinish(context: context, widget: HomeScreen());
                        })
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
