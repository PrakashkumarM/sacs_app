import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sacs_app/app/core/values/colors.dart';

class StepperHeader extends StatelessWidget {
  final RxInt currentStep;
  final List<String> steps;
  final Function onStepReached;

  const StepperHeader({
    Key? key,
    required this.currentStep,
    required this.steps,
    required this.onStepReached,
  }) : super(key: key);

  List<EasyStep> _buildSteps() {
    return steps.asMap().entries.map((entry) {
      int index = entry.key;
      print('its entry data => ${entry}');

      String stepTitle = entry.value;

      return EasyStep(
          customStep: Text(
            (index + 1).toString(),
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: index == currentStep.value
                    ? CustomColors.selectionColor
                    : index < currentStep.value
                        ? CustomColors.white
                        : CustomColors.grey),
          ),
          customTitle: Align(
            alignment: Alignment.center,
            child: Text(
              stepTitle,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: index == currentStep.value
                    ? CustomColors.darkGrey
                    : CustomColors.grey,
              ),
            ),
          ));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Stack(
        alignment: Alignment.center,
        children: [
          Container(
            color: Colors.white,
            height: 100,
            width: double.infinity,
          ),
          Positioned(
            top: 13.0,
            right: 0.0,
            bottom: 0.0,
            left: 0.0,
            child: EasyStepper(
              disableScroll: true,
              titlesAreLargerThanSteps: true,
              stepRadius: 14,
              borderThickness: 2.5,
              alignment: Alignment.bottomCenter,
              internalPadding: 10,
              defaultStepBorderType: BorderType.normal,
              finishedStepBackgroundColor: CustomColors.selectionColor,
              activeStepBackgroundColor: CustomColors.white,
              unreachedStepBackgroundColor: CustomColors.white,
              activeStepBorderColor: CustomColors.selectionColor,
              unreachedStepBorderColor: CustomColors.grey,
              enableStepTapping: false,
              activeStep: currentStep.value,
              showLoadingAnimation: false,
              lineStyle: LineStyle(
                lineType: LineType.normal,
                lineLength: 100,
                defaultLineColor: CustomColors.grey,
                lineSpace: 15,
                lineThickness: 1.5,
              ),
              steps: _buildSteps(),
            ),
          ),
        ],
      );
    });
  }
}
