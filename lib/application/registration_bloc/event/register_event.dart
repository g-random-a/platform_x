abstract class RegisterEvents {}

class StartRegistionEvent extends RegisterEvents {
  String fullname;
  String username;
  String password;
  StartRegistionEvent(
      {required this.fullname, required this.username, required this.password});
}

class InitialRegistionEvent extends RegisterEvents {
  InitialRegistionEvent();
}