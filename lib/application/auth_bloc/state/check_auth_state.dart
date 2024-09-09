abstract class CheckAuthStates {}

class CheckAuthInitialState extends CheckAuthStates {}

class LoadingCheckAuthState extends CheckAuthStates {}

class CheckAuthSuccessState extends CheckAuthStates {
  String token;
  String name;
  String email;
  String password;

  CheckAuthSuccessState({
    required this.token,
    required this.name,
    required this.email,
    required this.password,
  });
}

class CheckAuthFailedState extends CheckAuthStates {}
