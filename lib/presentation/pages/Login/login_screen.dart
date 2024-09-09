import 'login_screen_imports.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool hidePsd = true;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, perform form submission logic here
      String email = _emailController.text;
      String password = _passwordController.text;
      BlocProvider.of<AuthBloc>(context).add(LoginEvent(email, password));
      print('Email: $email');
      print('Password: $password');
    }
  }

  @override
  void deactivate() {
    _emailController.dispose();
    _passwordController.dispose();
    BlocProvider.of<AuthBloc>(context).add(InitialEvent());
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthStates>(
      builder: (context, authState) {
      return Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.015,
                  ),
                  Image.asset(AssetFiles.AILogo,
                      height: MediaQuery.of(context).size.height / 6),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.015,
                  ),
                  Image.asset(AssetFiles.CoffeenetLogo2),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.015,
                  ),
                  const Text(
                    "SIGN IN",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 38.0,
                      fontWeight: FontWeight.w700,
                      height: 1.5, // line height: 57px / font size: 38px
                      letterSpacing: 0.0,
                      color: Color.fromRGBO(71, 128, 108, 1),
                      // no letter spacing
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  authState is LoginFailedState
                      ? const Center(
                          child: Text("Error please try again.",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 20)))
                      : Container(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Container(
                    alignment: Alignment.center,
                    // height: 54,
                    // width: 361,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        filled: false,
                        hintText: 'Email',
                        hintStyle: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.0,
                            fontWeight: FontWeight.w300),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(239, 188, 8, 1))),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(239, 188, 8, 0.6)),
                          // Color of the border when focused
                        ),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(239, 188, 8, 1))),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1.5,
                              color: Color.fromRGBO(239, 188, 8, 1)),
                        ),
                      ),
                      validator: ((value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your email";
                        }
                        final emailRegex = RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                        );

                        if (!emailRegex.hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      }),
                      controller: _emailController,
                    ),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    // height: 54,
                    // width: 361,
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: false,
                        hintText: "Password",
                        // Placeholder text
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                hidePsd = !hidePsd;
                              });
                            },
                            icon: Icon(
                              hidePsd ? Icons.visibility_off : Icons.visibility,
                            )),
                        hintStyle: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.0,
                            fontWeight: FontWeight.w300),
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(239, 188, 8, 1))),
                        focusedErrorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(239, 188, 8, 0.6)),
                          // Color of the border when focused
                        ),
                        errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(239, 188, 8, 1))),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1.5,
                              color: Color.fromRGBO(239, 188, 8, 1)),
                        ),

                        focusColor: const Color.fromRGBO(239, 188, 8, 1),
                        //  contentPadding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 40.0),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your password";
                        }
                        return null;
                      },
                      controller: _passwordController,
                      obscureText: hidePsd,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 56,
                    width: 361,
                    decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(239, 188, 8, 1),
                        disabledBackgroundColor: Colors.grey.shade300,
                      ),
                      onPressed:
                          authState is LoggingInState ? null : _submitForm,
                      child: authState is LoggingInState
                          ? const CircularProgressIndicator(color: kPrimaryColor)
                          : const Text('Submit',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w700,
                                height:
                                    1.5, // line height: 24px / font size: 16px
                                letterSpacing: 0.13,
                              )),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 45),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          "Don't have an account?",
                          style: TextStyle(),
                        ),
                        InkWell(
                            onTap: authState is LoggingInState
                                ? null
                                : () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const SignUpScreen()),
                                    );
                                  },
                            child: const Text(" Sign up",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(71, 128, 108, 1)))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }, listener: (BuildContext context, AuthStates state) {  },);
  }
}
