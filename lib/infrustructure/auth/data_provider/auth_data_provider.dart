
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
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('name', name);
    await prefs.setString('email', email);
    await prefs.setString(
        'password', BCrypt.hashpw(password, BCrypt.gensalt()));
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
          await dio.post('$baseUrl/session/login/', data: <String, String>{
        'username': username,
        'password': password,
      });
      if (response.statusCode != 200) {
        throw (Exception('Failed to login'));
      }

      final responseHeader = response.headers;

      for (var element in responseHeader['set-cookie']!) {
        if (element.contains("session")) {
          for (var subElement in element.split(';')) {
            if (subElement.contains("session")) {
              var session = subElement.split("=")[1];
              var token = session;

              dio.options.headers['content-Type'] = 'application/json';
              // dio.options.headers['Authorization'] = 'Bearer $token';
              dio.options.headers["cookie"] = 'session=$token';

              Response getUser = await dio.get(
                '$baseUrl/account/',
              );
              if (getUser.statusCode != 200) {
                throw (Exception('Failed to login'));
              }
              var name = getUser.data["result"]['name'];

              await saveDataLocally(
                  token: token,
                  email: username,
                  password: password,
                  name: name);
              return token;
            } else {
              throw Exception("no access token");
            }
          }
        } else {
          throw Exception("No Access Token 2");
        }
      }
      // var token = response.data['access'];
      // dio.options.headers['content-Type'] = 'application/json';
      // dio.options.headers['Authorization'] = 'Bearer $token';
      // Response getUser = await dio.get(
      //   '$baseUrl/account/',
      // );
      // if (getUser.statusCode != 200) {
      //   throw (Exception('Failed to login'));
      // }
      // var name = getUser.data['name'];
      // await saveDataLocally(
      //     token: token, email: username, password: password, name: name);
      // return token;
      throw Exception("No Access Token 1");
    } catch (e) {
      print({"error": e});
      rethrow;
    }
  }

  Future<bool> register(
      String fullname, String username, String password) async {
    try {
      dio.options.headers = {};
      dio.options.headers['content-Type'] = 'application/json';
      final response = await dio.post('$baseUrl/account/add-new/',
          data: <String, String>{
            'fullname': fullname,
            'email': username,
            'password': password
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
