abstract class AuthEvents {}

class LoginEvent extends AuthEvents {
  String username;
  String password;
  LoginEvent(this.username, this.password);
}

class TestLoginEvent extends AuthEvents {
  TestLoginEvent();
}

class InitialEvent extends AuthEvents {
  InitialEvent();
}
