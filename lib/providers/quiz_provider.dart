import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/models/quiz_model.dart';
import 'package:quiz_app/services/api_services.dart';

class QuizCacheNotifier extends StateNotifier<AsyncValue<Quiz?>> {
  QuizCacheNotifier() : super(const AsyncValue.loading());

  Future<void> loadQuizData() async {
    try {
      final quiz = await APIServices.fetchQuizData();
      state = AsyncValue.data(quiz);
    } catch (e) {
      state = AsyncValue.error('Failed to load quiz: $e', StackTrace.current);
    }
  }
}

final quizProvider =
    StateNotifierProvider<QuizCacheNotifier, AsyncValue<Quiz?>>((ref) {
  return QuizCacheNotifier();
});
