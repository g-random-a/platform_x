import 'package:flutter_svg/svg.dart';
import 'package:platform_x/application/theme_bloc/bloc/theme_bloc.dart';
import 'package:platform_x/application/theme_bloc/state/theme_state.dart';

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
  final _ageController = TextEditingController(); // Controller for Age input
  final _usernameController = TextEditingController();
  String? _selectedGender;
  bool hidePsd = true;
  bool hidePsd1 = true;
  bool agreed = false;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;
      String fullName = _fullNameController.text;
      String gender = _selectedGender!;
      int age = int.parse(_ageController.text);
      String username = _usernameController.text;

      BlocProvider.of<RegisterationBloc>(context).add(StartRegistionEvent(
          username: username, email: email, password: password,
          firstName: fullName.split(" ")[0], lastName: fullName.split(" ")[1],
          gender: gender, age: age
          ));
    }
  }

  @override
  void deactivate() {
    _emailController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    _confirmPasswordController.dispose();
    _ageController.dispose();
    _usernameController.dispose();
    BlocProvider.of<RegisterationBloc>(context).add(InitialRegistionEvent());
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, theme) {
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
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .015,
                      ),
                      
                      theme is LightThemeState
                          ? SvgPicture.asset(
                              AssetFiles.platformX_black,
                              width: MediaQuery.of(context).size.width *
                                  .8,
                              height:
                                  MediaQuery.of(context).size.height *
                                      .15,
                            )
                          :
                        SvgPicture.asset(
                        AssetFiles.platformX,
                        width: MediaQuery.of(context).size.width *
                            .8,
                        height:
                            MediaQuery.of(context).size.height *
                                .15,
                      ),SizedBox(
                        height: MediaQuery.of(context).size.height * .055,
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
                            contentPadding: const EdgeInsets.only(left: 20),
                            filled: false,
                            hintText: 'Full name',
                            hintStyle: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w300),
                            prefixIcon: Icon(Icons.person),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: kPrimaryColor)),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: kPrimaryColor),
                              // Color of the border when focused
                            ),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: kPrimaryColor)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1.5,
                                  color: kPrimaryColor),
                            ),
                          ),
                          validator: ((value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your full name";
                            }
                            if (value.split(" ").length < 2) {
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
                      Container(
                        alignment: Alignment.center,
                        // height: 56,
                        // width: 361,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 20),
                            filled: false,
                            hintText: 'Username',
                            hintStyle: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w300),
                            prefixIcon: Icon(Icons.supervised_user_circle_sharp),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: kPrimaryColor)),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: kPrimaryColor),
                              // Color of the border when focused
                            ),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: kPrimaryColor)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1.5,
                                  color: kPrimaryColor),
                            ),
                          ),
                          validator: ((value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your username";
                            }
                            return null;
                          }),
                          controller: _usernameController,
                        ),
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      // )))
                      Row(
                        children: [
                          // Gender Dropdown
                          Expanded(
                            flex: 2,
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                filled: false,
                                contentPadding: const EdgeInsets.only(left: 20),
                                hintStyle: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w300),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: kPrimaryColor)),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: kPrimaryColor),
                              // Color of the border when focused
                            ),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: kPrimaryColor)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1.5,
                                  color: kPrimaryColor),
                            ),
                                hintText: 'Gender',
                                prefixIcon: const Icon(Icons.person),
                              ),
                              items: const [
                                DropdownMenuItem(
                                  value: 'Male',
                                  child: Text('Male'),
                                ),
                                DropdownMenuItem(
                                  value: 'Female',
                                  child: Text('Female'),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _selectedGender = value;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select your gender';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Age input
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                filled: false,
                                contentPadding: EdgeInsets.symmetric(horizontal: 16),
                                hintStyle: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w300),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: kPrimaryColor)),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: kPrimaryColor),
                              // Color of the border when focused
                            ),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: kPrimaryColor)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1.5,
                                  color: kPrimaryColor),
                            ),
                                hintText: 'Age',
                                prefixIcon: Icon(Icons.calendar_today),
                              ),
                              keyboardType: TextInputType.number,
                              controller: _ageController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your age';
                                }
                                try{
                                  int.parse(value);
                                }catch(e){
                                  return 'Please enter a valid age';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      Container(
                        alignment: Alignment.center,
                        // height: 56,
                        // width: 361,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 20),
                            filled: false,
                            prefixIcon: Icon(Icons.email_outlined),
                            hintText: 'Email',
                            hintStyle: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w300),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: kPrimaryColor)),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: kPrimaryColor),
                              // Color of the border when focused
                            ),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: kPrimaryColor)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1.5,
                                  color: kPrimaryColor),
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
                            contentPadding: const EdgeInsets.only(left: 20),
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
                                    color: kPrimaryColor)),
                            focusedErrorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: kPrimaryColor),
                              // Color of the border when focused
                            ),
                            errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: kPrimaryColor)),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1.5,
                                  color: kPrimaryColor),
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
                            contentPadding: const EdgeInsets.only(left: 20),
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
                                      color: kPrimaryColor)),
                              focusedErrorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: kPrimaryColor),
                                // Color of the border when focused
                              ),
                              errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: kPrimaryColor)),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.5,
                                    color: kPrimaryColor),
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
                            backgroundColor: kPrimaryColor,
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
    );
  }
}
