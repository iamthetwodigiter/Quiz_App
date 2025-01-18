class UserDataState {
  final int correctAnswer;
  final int skipped;
  final int marks;
  final int attempted;
  final int coins;
  final Map<String, dynamic> testDetails;

  UserDataState({
    this.correctAnswer = 0,
    this.skipped = 0,
    this.marks = 0,
    this.attempted = 0,
    this.coins = 0,
    this.testDetails = const {},
  });

  UserDataState copyWith({
    int? correctAnswer,
    int? skipped,
    int? marks,
    int? attempted,
    int? coins,
    Map<String, dynamic>? testDetails,
  }) {
    return UserDataState(
      correctAnswer: correctAnswer ?? this.correctAnswer,
      skipped: skipped ?? this.skipped,
      marks: marks ?? this.marks,
      attempted: attempted ?? this.attempted,
      coins: coins ?? this.coins,
      testDetails: testDetails ?? this.testDetails,
    );
  }
}