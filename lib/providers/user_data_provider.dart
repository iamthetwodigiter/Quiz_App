import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quiz_app/models/user_data_state.dart';

final userDataProvider = StateNotifierProvider<UserDataNotifier, UserDataState>(
  (ref) {
    final quizBox = Hive.box('quiz');
    return UserDataNotifier(quizBox);
  },
);

class UserDataNotifier extends StateNotifier<UserDataState> {
  final Box _quizBox;

  UserDataNotifier(this._quizBox)
      : super(UserDataState(
          correctAnswer: _quizBox.get('correctAnswer', defaultValue: 0),
          skipped: _quizBox.get('skipped', defaultValue: 0),
          marks: _quizBox.get('marks', defaultValue: 0),
          attempted: _quizBox.get('attempted', defaultValue: 0),
          coins: _quizBox.get('coins', defaultValue: 0),
        ));

  void updateSkipped(int value) {
    _quizBox.put('skipped', value);
    state = state.copyWith(skipped: value);
  }

  void updateCoins(int value) {
    _quizBox.put('coins', value);
    state = state.copyWith(coins: value);
  }

  void updateAttempted(int value) {
    _quizBox.put('attempted', value);
    state = state.copyWith(attempted: value);
  }

  void updateCorrectAnswer(int value) {
    _quizBox.put('correctAnswer', value);
    state = state.copyWith(correctAnswer: value);
  }

  void updateMarks(int value) {
    _quizBox.put('marks', value);
    state = state.copyWith(marks: value);
  }

  void saveTestDetails(String testId, Map<String, dynamic> attemptedQuestions) {
    if (_quizBox.containsKey(testId)) return;

    _quizBox.put(testId, attemptedQuestions);
    state = state.copyWith(
      testDetails: {...state.testDetails, testId: attemptedQuestions},
    );
  }

  void saveQuestionProgress({
    required String testId,
    required int questionId,
    required String selectedOption,
    required bool isCorrect,
  }) {
    Map<dynamic, dynamic> testDetails = Map<dynamic, dynamic>.from(
      _quizBox.get(testId, defaultValue: {}) as Map<dynamic, dynamic>,
    );

    testDetails[questionId.toString()] = {
      'selectedOption': selectedOption,
      'isCorrect': isCorrect,
    };

    _quizBox.put(testId, testDetails);

    state = state.copyWith(
      testDetails: {...state.testDetails, testId: testDetails},
    );
  }

  Map<dynamic, dynamic> getTestDetails(String testId) {
    return _quizBox.get(testId, defaultValue: {}) as Map<dynamic, dynamic>;
  }

  bool isTestTaken(String testId) {
    return _quizBox.containsKey(testId);
  }

  void resetData() {
    _quizBox.clear();
    state = UserDataState();
  }
}
