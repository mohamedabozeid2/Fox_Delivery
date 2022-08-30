import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fox_delivery/modules/ReportScreen/ReportSuccess.dart';
import 'package:fox_delivery/shared/components/components.dart';
import 'package:fox_delivery/shared/constants/constants.dart';
import 'package:fox_delivery/shared/cubit/cubit.dart';
import 'package:fox_delivery/shared/cubit/states.dart';
import 'package:fox_delivery/styles/Themes.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReportScreen extends StatelessWidget {
  var problemController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(userModel!.firstName);
    return BlocConsumer<FoxCubit, FoxStates>(
      listener: (context, state) {
        if(state is FoxReportProblemSuccessState){
          navigateAndFinish(context: context, widget: ReportSuccessScreen());
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text(
                          'what_is_your_problem'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.white),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        textFormFieldWithHint(
                            context: context,
                            controller: problemController,
                            label: 'problem'.tr,
                            type: TextInputType.text,
                            borderRadius: 5.0,
                            borderColor: Colors.transparent),
                        SizedBox(
                          height: 20.0,
                        ),
                        state is FoxReportProblemLoadingState
                            ? Center(
                            child: CircularProgressIndicator(
                              color: buttonColor,
                            ))
                            : defaultButton(
                            text: 'report'.tr,
                            borderRadius: 5.0,
                            fun: () {
                              FoxCubit.get(context).reportProblem(
                                  clientUid: userModel!.uId!,
                                  phoneNumber: userModel!.phone!,
                                  clientLastName: userModel!.lastName!,
                                  clientFirstName: userModel!.firstName!,
                                  problem: problemController.text,
                                  dateTime: DateTime.now().toString(),
                                  dateTimeDisplay: DateFormat.yMMMd()
                                      .add_jm()
                                      .format(now)
                                      .toString());
                            },
                            TextColor: Colors.white,
                            backgroundColor: buttonColor),
                        SizedBox(
                          height: 20.0,
                        ),
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
