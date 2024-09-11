import 'package:flutter/material.dart';

Widget termsAndConditionsText(context) => SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Terms and Conditions for Coffee Leaf Disease Detection Mobile Application',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              '1. Lorem Ipsum Dolor:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const Text(
              '   a. Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n'
              '   b. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\n'
              '   c. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
            ),
            const SizedBox(height: 16),
            const Text(
              '2. Free to Use:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const Text(
              '   a. Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n'
              '   b. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\n'
              '   c. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
            ),
            const SizedBox(height: 16),
            const Text(
              '3. Lorem Ipsum Dolor:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const Text(
              '   a. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\n'
              '   b. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\n'
              '   c. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
            ),
            const SizedBox(height: 16),
            const Text(
              '4. Lorem Ipsum Dolor:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const Text(
              '   a. Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n'
              '   b. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\n'
              '   c. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
            ),

            // Repeat the same pattern for the remaining points
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'),
                ),
              ],
            ),
            // Add any additional text or widgets as needed for the rest of the terms and conditions
          ],
        ),
      ),
    );

TermsAndConditions(context) => showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: termsAndConditionsText(context)
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               // RichText(
//               //   text: TextSpan(
//               //     text: 'Hello ',
//               //     children: const <TextSpan>[
//               //       TextSpan(
//               //           text: 'bold',
//               //           style: TextStyle(fontWeight: FontWeight.bold)),
//               //       TextSpan(text: ' world!'),
//               //     ],
//               //   ),
//               // ),
//               Text(
//                   """Restart your router (optional but recommended to ensure the settings take effect).
// Start your Django server.
// In a web browser on a different device or network, enter your public IP address followed by the port number in the URL. For example, http://<your-public-ip>:8000/.
// If the Django backend is accessible, you should see your application's response in the browser."""),
//               const SizedBox(height: 15),
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: const Text('Close'),
//               ),
//             ],
//           ),

            ),
      ),
    );
