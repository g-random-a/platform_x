import 'signup_screen_imports.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool hidePsd = true;
  bool hidePsd1 = true;
  bool agreed = false;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, perform form submission logic here
      String email = _emailController.text;
      String password = _passwordController.text;
      String fullName = _fullNameController.text;

      BlocProvider.of<RegisterationBloc>(context).add(StartRegistionEvent(
          fullname: fullName, username: email, password: password));
      print('full name: $fullName');
      print('Email: $email');
      print('Password: $password');
    }
  }

  @override
  void deactivate() {
    _emailController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    _confirmPasswordController.dispose();
    BlocProvider.of<RegisterationBloc>(context).add(InitialRegistionEvent());
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterationBloc, RegisterStates>(
        listener: (context, st) {
      if (st is RegisterSuccessState) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: ((context) => const LoginScreen())));
      }
    }, builder: (context, registerationState) {
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
                    height: MediaQuery.of(context).size.height * .015,
                  ),
                  Image.asset(
                    AssetFiles.AILogo,
                    height: MediaQuery.of(context).size.height / 6,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .015,
                  ),
                  Image.asset(AssetFiles.CoffeenetLogo2,
                      height: MediaQuery.of(context).size.height / 7),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .015,
                  ),
                  const Text(
                    "SIGN UP",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 34.0,
                      fontWeight: FontWeight.w700,
                      height: 1.5, // line height: 57px / font size: 38px
                      letterSpacing: 0.0,
                      color: Color.fromRGBO(71, 128, 108, 1),
                      // no letter spacing
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  registerationState is RegisterFailedState
                      ? const Center(
                          child: Text("Error please try again.",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 20)))
                      : Container(),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.center,
                    // height: 56,
                    // width: 361,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        filled: false,
                        hintText: 'Full name',
                        hintStyle: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.0,
                            fontWeight: FontWeight.w300),
                        prefixIcon: Icon(Icons.person),
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
                          return "Please enter your full name";
                        }
                        return null;
                      }),
                      controller: _fullNameController,
                    ),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  // )))
                  Container(
                    alignment: Alignment.center,
                    // height: 56,
                    // width: 361,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        filled: false,
                        hintText: 'Email',
                        hintStyle: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16.0,
                            fontWeight: FontWeight.w300),
                        prefixIcon: Icon(Icons.email_outlined),
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
                      validator: ((email) {
                        return Validators().isEmailValid(email);
                      }),
                      controller: _emailController,
                    ),
                  ),

                  const SizedBox(
                    height: 22,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    // height: 56,
                    // width: 361,
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: false,
                        hintText: "Password",
                        // Placeholder text
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
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                hidePsd1 = !hidePsd1;
                              });
                            },
                            icon: Icon(
                              hidePsd1
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            )),
                        //  contentPadding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 40.0),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your password";
                        }
                        if (value.length < 8) {
                          return 'Password must be at least 8 characters long';
                        }
                        return null;
                      },
                      controller: _passwordController,
                      obscureText: hidePsd1,
                    ),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  Container(
                    alignment: Alignment.center,
                    // height: 56,
                    // width: 361,
                    child: TextFormField(
                      decoration: InputDecoration(
                          filled: false,
                          hintText: 'Confirm password',
                          hintStyle: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16.0,
                              fontWeight: FontWeight.w300),
                          prefixIcon: const Icon(
                            Icons.lock_outline_rounded,
                          ),
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
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hidePsd = !hidePsd;
                                });
                              },
                              icon: Icon(
                                hidePsd
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ))),
                      validator: ((value) {
                        if (value != _passwordController.text) {
                          return "Password doesn't match!";
                        }
                        return null;
                      }),
                      controller: _confirmPasswordController,
                      obscureText: hidePsd,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Checkbox(
                        value: agreed,
                        onChanged: (value) {
                          setState(() {
                            agreed = !agreed;
                          });
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            setState(() {
                              agreed = !agreed;
                            });
                          },
                          child: const Text(
                            "I Agree to",
                            style: TextStyle(color: kPrimaryColor),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => Dialog(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    RichText(
                                      text: const TextSpan(
                                        text: 'Hello ',
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: 'bold',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          TextSpan(text: ' world!'),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Close'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          child: const Text(
                            " terms and conditions",
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ]),

                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 56,
                    width: 361,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(239, 188, 8, 1),
                      ),
                      onPressed: agreed
                          ? registerationState is RegisterLoadingState
                              ? null
                              : _submitForm
                          : null,
                      child: registerationState is RegisterLoadingState
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
                    margin: const EdgeInsets.symmetric(horizontal: 48),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          "Already have an account?",
                        ),
                        InkWell(
                            onTap: registerationState is RegisterLoadingState
                                ? null
                                : () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const LoginScreen()),
                                    );
                                  },
                            child: const Text(" Sign in",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(71, 128, 108, 1)))),
                      ],
                    ),
                  ),
                  // Container(child: TextField())
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
