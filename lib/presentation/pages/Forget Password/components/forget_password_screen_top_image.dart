import 'imports.dart';

class ForgetPasswordScreenTopImage extends StatelessWidget {
  const ForgetPasswordScreenTopImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // SizedBox(height: defaultPadding * 2),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: SvgPicture.asset(AssetFiles.CoffeenetLogo,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3),
            ),
            const Spacer(),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Text(
            "Forget Password".toUpperCase(),
            style: GoogleFonts.rubik(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
        ),
        const Text(
          "please enter your email address \n to recieve verification code.",
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: defaultPadding * 2),
      ],
    );
  }
}
