import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fox_delivery/modules/ReportScreen/ReportSuccess.dart';
import 'package:fox_delivery/shared/components/components.dart';
import 'package:fox_delivery/shared/constants/constants.dart';
import 'package:fox_delivery/shared/cubit/cubit.dart';
import 'package:fox_delivery/shared/cubit/states.dart';
import 'package:fox_delivery/styles/Themes.dart';

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
                          'What is your problem?',
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
                            label: 'Problem',
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
                                text: 'Report',
                                borderRadius: 5.0,
                                fun: () {
                                  FoxCubit.get(context).reportProblem(
                                      clientUid: userModel!.uId!,
                                      phoneNumber: userModel!.phone!,
                                      clientLastName: userModel!.lastName!,
                                      clientFirstName: userModel!.firstName!,
                                      problem: problemController.text);
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
