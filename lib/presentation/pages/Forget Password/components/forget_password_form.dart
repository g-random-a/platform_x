import 'imports.dart';

class ForgetPasswordForm extends StatefulWidget {
  const ForgetPasswordForm({
    super.key,
  });

  @override
  State<ForgetPasswordForm> createState() => _ForgetPasswordFormState();
}

class _ForgetPasswordFormState extends State<ForgetPasswordForm> {
  TextEditingController otp1Controller = TextEditingController();
  TextEditingController otp2Controller = TextEditingController();
  TextEditingController otp3Controller = TextEditingController();
  TextEditingController otp4Controller = TextEditingController();
  bool _otpNotValid = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            controller: _emailController,
            validator: (email) {
              return Validators().isEmailValid(email);
            },
            decoration: InputDecoration(
              suffix: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.mail),
              ),
              hintText: "Your email",
              prefixIcon: const Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.mail),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          const Text(
            "Enter verification code",
          ),
          const SizedBox(height: defaultPadding / 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Otp(
                otpController: otp1Controller,
                isFirst: true,
              ),
              Otp(
                otpController: otp2Controller,
              ),
              Otp(
                otpController: otp3Controller,
              ),
              Otp(
                otpController: otp4Controller,
              ),
            ],
          ),
          _otpNotValid
              ? const Text("Please enter OTP to proceed to the next step.",
                  style: TextStyle(color: Colors.red))
              : Container(),
          const SizedBox(height: defaultPadding),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryColor,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              String otp = otp1Controller.text +
                  otp2Controller.text +
                  otp3Controller.text +
                  otp4Controller.text;

              if (_formKey.currentState!.validate() && otp.length == 4) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const ResetPassword();
                    },
                  ),
                );
              }
              setState(() {
                _otpNotValid = otp.length < 4;
              });
            },
            child: Text(
              "Done".toUpperCase(),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(press: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const SignUpScreen();
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
