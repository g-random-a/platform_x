import 'package:shared_preferences/shared_preferences.dart';

import 'feedback_data_provider_imports.dart';

class FeedbackDataProvider extends DataProvider {
  final Dio dio;

  FeedbackDataProvider({required this.dio});

  Future<bool> senFeedback(Feedback feedback) async {
    try {
      FormData formData = FormData.fromMap(feedback.toJson());
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      if (token == null) {
        throw Exception("notLogged In");
      }
      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers['cookie'] = 'session=$token';

      Response response = await dio.post("$baseUrl/feedback/", data: formData);

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception("Error while sending feedback.");
      }
    } catch (e) {
      rethrow;
    }
  }
}
