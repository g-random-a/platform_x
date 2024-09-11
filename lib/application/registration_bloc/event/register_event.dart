abstract class RegisterEvents {}

class StartRegistionEvent extends RegisterEvents {
  String firstName;
  String lastName;
  String email;
  String username;
  String password;
  String gender;
  int age;
  // "userType": "Agent",
  StartRegistionEvent(
      {required this.firstName, required this.lastName, required this.email, required this.username, required this.gender, required this.age, required this.password});
}

class InitialRegistionEvent extends RegisterEvents {
  InitialRegistionEvent();
}