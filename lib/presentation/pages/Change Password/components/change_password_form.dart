import 'package:bcrypt/bcrypt.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/auth_bloc/bloc/change_password_bloc.dart';
import '../../../../application/auth_bloc/bloc/check_auth_bloc.dart';
import '../../../../application/auth_bloc/event/change_password_event.dart';
import '../../../../application/auth_bloc/state/check_auth_state.dart';
import 'imports.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({
    super.key,
  });

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _psdController = TextEditingController();
  final TextEditingController _oldPsdController = TextEditingController();
  final TextEditingController _confirmPsdController = TextEditingController();

  bool showPass = true;
  bool showConfirmPass = true;
  bool showOldPass = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckAuthBloc, CheckAuthStates>(
        builder: (context, state) {
      if (state is CheckAuthSuccessState) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _oldPsdController,
                textInputAction: TextInputAction.next,
                obscureText: showOldPass,
                cursorColor: kPrimaryColor,
                validator: (psd) {
                  return Validators().isPasswordValid(psd) == null
                      ? BCrypt.checkpw(psd!, state.password)
                          ? null
                          : "wrong old password, \nplease contact support team to reset."
                      : "old password is required.";
                },
                decoration: InputDecoration(
                  hintText: "enter old password",
                  prefixIcon: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Icon(Icons.lock),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(8),
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            showOldPass = !showOldPass;
                          });
                        },
                        icon: showOldPass
                            ? const Icon(Icons.visibility)
                            // ignore: dead_code
                            : const Icon(Icons.visibility_off)),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _psdController,
                textInputAction: TextInputAction.next,
                obscureText: showPass,
                cursorColor: kPrimaryColor,
                validator: (psd) {
                  return Validators().isPasswordValid(psd);
                },
                decoration: InputDecoration(
                  hintText: "enter your password",
                  prefixIcon: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Icon(Icons.lock),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(8),
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            showPass = !showPass;
                          });
                        },
                        icon: showPass
                            ? const Icon(Icons.visibility)
                            // ignore: dead_code
                            : const Icon(Icons.visibility_off)),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _confirmPsdController,
                textInputAction: TextInputAction.done,
                cursorColor: kPrimaryColor,
                validator: (psd) {
                  return Validators().isPasswordValid(psd) == null
                      ? psd! == _psdController.text
                          ? null
                          : "password does not mach"
                      : "confirm password is required";
                },
                obscureText: showConfirmPass,
                decoration: InputDecoration(
                  hintText: "confirm your password",
                  prefixIcon: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Icon(Icons.lock),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(8),
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            showConfirmPass = !showConfirmPass;
                          });
                        },
                        icon: showConfirmPass
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) {
                    //       return const WelcomeScreen();
                    //     },
                    //   ),
                    // );
                    // Navigator.of(context).pop();
                    BlocProvider.of<ChangePasswordBloc>(context).add(
                        ChangePasswordEvent(
                            password: _confirmPsdController.text));
                  }
                },
                child: Text(
                  "Done".toUpperCase(),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      } else {
        return Container(
            child: const Text("Unknown Error, If it persists please contact us."));
      }
    });
  }
}
