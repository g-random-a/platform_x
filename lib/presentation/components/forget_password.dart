import 'package:flutter/material.dart';
import '../constants.dart';

class ForgetPasswordCheck extends StatelessWidget {
  final Function? press;
  const ForgetPasswordCheck({
    super.key,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        const Text(
          "Forget your password? ",
          style: TextStyle(color: kPrimaryColor),
        ),
        GestureDetector(
          onTap: press as void Function()?,
          child: const Text(
            "Reset now!",
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
