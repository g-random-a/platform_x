import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

void showThankYouDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SvgPicture.asset(
            //   'assets/icons/thankyou.svg',
            //   height: 40,
            //   width: 40,
            // ),
            Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            SizedBox(width: 10),
            Text(
              'Thank You!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: const Text(
          'Thank you for sharing the app! We appreciate your support.',
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text(
              'OK',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
