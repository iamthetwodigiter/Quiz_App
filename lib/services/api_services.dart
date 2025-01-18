import 'package:dio/dio.dart';
import 'package:quiz_app/models/quiz_model.dart';

class APIServices {
  static const String _baseUrl = 'https://api.jsonserve.com/Uw5CrX';
  static final Dio dio = Dio();
  static Future<Quiz?> fetchQuizData() async {
    try {
      final response = await dio.get(_baseUrl);
      return Quiz.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Error: $e');
    }
  }
}
