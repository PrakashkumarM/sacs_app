import 'package:flutter/material.dart';

class CustomStepper extends StatelessWidget {
  final List<String> titles;
  final int currentStep;

  const CustomStepper(
      {required this.titles, required this.currentStep, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            // Stepper with circles and lines
            SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < titles.length - 1; i++)
                    Row(
                      children: [
                        circleStepper(i),
                        const SizedBox(width: 5),
                        lineStepper(),
                        const SizedBox(width: 5),
                      ],
                    ),
                  circleStepper(titles.length - 1),
                ],
              ),
            ),
            // Titles below stepper
            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < titles.length - 1; i++) stepperTitle(i),
                  stepperTitle(titles.length - 1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget stepperTitle(int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: SizedBox(
        width: 50, // Adjust width as needed
        child: Text(
          'STEP ${index + 1}',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black.withOpacity(.3),
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget lineStepper() {
    return Container(
      width: 60, // Adjust width if needed
      height: 3, // Reduced thickness
      color: Colors.grey, // Static grey color
    );
  }

  Widget circleStepper(int index) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color:
              index > currentStep ? Colors.black.withOpacity(.1) : Colors.black,
          width: 2,
          style: BorderStyle.solid,
        ),
      ),
      child: Center(
        child: Text(
          '${index + 1}',
          style: TextStyle(
            fontSize: 16,
            color: index > currentStep
                ? Colors.black.withOpacity(.3)
                : Colors.black,
          ),
        ),
      ),
    );
  }
}
