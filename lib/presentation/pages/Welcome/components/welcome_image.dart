// ignore_for_file: prefer_const_constructors
import 'imports.dart';

class WelcomeImage extends StatelessWidget {
  const WelcomeImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            // Expanded(
            // flex: 8,
            // child: SvgPicture.asset(
            //   "assets/icons/chat.svg",
            // ),
            // child:
            Image.asset(
              AssetFiles.WellcomeImage,
              fit: BoxFit.fitHeight,
            )
          ],
        ),
      ],
    );
  }
}
