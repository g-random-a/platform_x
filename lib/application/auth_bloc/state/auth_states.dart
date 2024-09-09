abstract class AuthStates {}

class LoggingInitialState extends AuthStates {}

class LoggingInState extends AuthStates {}

class LoggedInState extends AuthStates {}

class LoginFailedState extends AuthStates {}
