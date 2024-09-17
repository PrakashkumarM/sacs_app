import 'package:flutter/material.dart';
import 'package:sacs_app/app/core/values/colors.dart';

class StepperHeader extends StatelessWidget {
  final int currentStep;
  final List<String> steps;

  const StepperHeader(
      {Key? key, required this.currentStep, required this.steps})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Horizontal scrollable row for steps
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              // Step circles and connecting lines
              Row(
                children: List.generate(steps.length, (index) {
                  return Row(
                    children: [
                      _buildStepCircle(
                          index: index, isCurrent: currentStep == index + 1),
                      if (index != steps.length - 1)
                        _buildStepLine(isActive: currentStep > index + 1),
                    ],
                  );
                }),
              ),
              // Step labels below circles
              Row(
                children: List.generate(steps.length, (index) {
                  return SizedBox(
                    width: 120, // Width to match the circle or adjust as needed
                    child: Center(
                      child: Text(
                        steps[index],
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Widget to build the step circle
  Widget _buildStepCircle({required int index, required bool isCurrent}) {
    bool isCompleted = currentStep > index + 1;
    bool isUncompleted = currentStep < index + 1;

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isCompleted
            ? CustomColors.selectionColor // Completed step
            : isUncompleted
                ? CustomColors.grey // Uncompleted step
                : CustomColors.white, // Current step
        border: Border.all(
          color: isCurrent ? CustomColors.selectionColor : CustomColors.grey,
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          (index + 1).toString(),
          style: TextStyle(
            color:
                isCompleted ? CustomColors.white : CustomColors.selectionColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Widget to build the line between steps
  Widget _buildStepLine({required bool isActive}) {
    return Container(
      width: 100, // Adjust line width as necessary
      height: 2,
      color: isActive ? CustomColors.selectionColor : CustomColors.grey,
    );
  }
}
