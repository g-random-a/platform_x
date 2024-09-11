
import 'package:bcrypt/bcrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_data_provider_imports.dart';

class AuthDataProvider extends DataProvider {
  Dio dio;
  AuthDataProvider({required this.dio});

  saveDataLocally({
    required String token,
    required String name,
    required String email,
    required String password,
    String gender = "",
    int age = 0,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('name', name);
    await prefs.setString('email', email);
    await prefs.setString(
        'password', BCrypt.hashpw(password, BCrypt.gensalt()));
    await prefs.setString("gender", gender);
    await prefs.setInt("age", age);
  }

  Future<String> testLogin() async {
    try{
      saveDataLocally(token: "token", name: "name", email: "email", password: "password");
      return "token";
    }catch (e) {
      rethrow;
    }
  }

  Future<String> login(String username, String password) async {
    try {
      dio.options.headers = {};
      dio.options.headers['content-Type'] = 'application/json';
      final response =
          await dio.post('$baseUrl/auth/login/', data: <String, String>{
        'email': username,
        'password': password,
      });
      if (response.statusCode != 200) {
        throw (Exception('Failed to login'));
      }

      print("@response == ${response}");

      var token = response.data['token'];

      dio.options.headers['Authorization'] = 'Bearer $token';

      Response getUser = await dio.get(
        '$baseUrl/auth/get-profile',
      );

      if (getUser.statusCode != 200) {
        throw (Exception('Failed to login'));
      }

      await saveDataLocally(
          token: token,
          email: username,
          password: password,
          name: getUser.data['userInfo']['firstName'] +
              " " +
              getUser.data['userInfo']['lastName'],
          gender: getUser.data['relatedObject']['gender'],
          age: getUser.data['relatedObject']['age'],
          );
      return token;

    } catch (e) {
      print({"error": e});
      rethrow;
    }
  }

  Future<bool> register(
      String firstname, String lastname, String email, String username, String gender, int age, String password) async {
    try {
      dio.options.headers = {};
      dio.options.headers['content-Type'] = 'application/json';
      final response = await dio.post('$baseUrl/auth/signup/agent',
          data: <String, String>{
            "userName": username,
            "email": email, 
            "password": password,
            "firstName": firstname,
            "lastName": lastname,
            "userType": "Agent",
            "gender": gender,
            "age": age.toString()
          });
      if (response.statusCode != 200) {
        throw (Exception('Failed to register'));
      }
      return true;
    } catch (e) {
      print({"error": e});
      rethrow;
    }
  }

  Future<bool> changePassword({required String newPassword}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      if (token == null) {
        throw Exception("notLogged In");
      }

      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['Authorization'] = 'Bearer $token';
      Response response = await dio
          .post('$baseUrl/account/update-password/', data: <String, String>{
        'password': newPassword,
      });

      if (response.statusCode != 200) {
        throw (Exception('Failed to register'));
      }

      bool changed = await prefs.setString(
          'password', BCrypt.hashpw(newPassword, BCrypt.gensalt()));

      return changed;
    } catch (e) {
      rethrow;
    }
  }
}
