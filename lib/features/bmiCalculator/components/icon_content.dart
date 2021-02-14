import 'package:flutter/material.dart';
import 'package:crossfit_kabod_app/features/bmiCalculator/res/constants.dart';

class IconContent extends StatelessWidget {
  IconContent({@required this.text, @required this.icon});
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 80,
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          text,
          style: kLabelTextStyle,
        )
      ],
    );
  }
}
