abstract class ChangePasswordEvents {}

class ChangePasswordEvent extends ChangePasswordEvents {
  String password;
  ChangePasswordEvent({required this.password});
}

class LoadChangePasswordEvent extends ChangePasswordEvents {
  LoadChangePasswordEvent();
}
