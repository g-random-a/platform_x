// import 'package:arabica_armour_mobile/infrastructure/auth/auth.dart';
import 'auth_repo_imports.dart';

class AuthRepo {
  AuthDataProvider authDataProvider;
  AuthRepo({required this.authDataProvider});
  Future<String> login(String username, String password) async {
    try {
      String token = await authDataProvider.login(username, password);
      return token;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> testLogin() async {
    try {
      String token = await authDataProvider.testLogin();
      return token;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> register(
      String fullname, String username, String password) async {
    try {
      bool token =
          await authDataProvider.register(fullname, username, password);
      return token;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> changePassword(String password) async {
    try {
      bool token = await authDataProvider.changePassword(newPassword: password);
      if (!token) {
        throw Exception();
      }
      return token;
    } catch (e) {
      rethrow;
    }
  }
}
