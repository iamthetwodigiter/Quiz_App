class Quiz {
  final int id;
  final String? name;
  final String title;
  final String description;
  final String? difficultyLevel;
  final String topic;
  final DateTime time;
  final bool isPublished;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int duration;
  final DateTime endTime;
  final double negativeMarks;
  final double correctAnswerMarks;
  final bool shuffle;
  final bool showAnswers;
  final bool lockSolutions;
  final bool isForm;
  final bool showMasteryOption;
  final String? readingMaterial;
  final String? quizType;
  final bool isCustom;
  final int? bannerId;
  final int? examId;
  final bool showUnanswered;
  final String endsAt;
  final int? lives;
  final String liveCount;
  final int coinCount;
  final int questionsCount;
  final String dailyDate;
  final int maxMistakeCount;
  final List<dynamic> readingMaterials;
  final List<Question> questions;

  Quiz({
    required this.id,
    this.name,
    required this.title,
    required this.description,
    this.difficultyLevel,
    required this.topic,
    required this.time,
    required this.isPublished,
    required this.createdAt,
    required this.updatedAt,
    required this.duration,
    required this.endTime,
    required this.negativeMarks,
    required this.correctAnswerMarks,
    required this.shuffle,
    required this.showAnswers,
    required this.lockSolutions,
    required this.isForm,
    required this.showMasteryOption,
    this.readingMaterial,
    this.quizType,
    required this.isCustom,
    this.bannerId,
    this.examId,
    required this.showUnanswered,
    required this.endsAt,
    this.lives,
    required this.liveCount,
    required this.coinCount,
    required this.questionsCount,
    required this.dailyDate,
    required this.maxMistakeCount,
    required this.readingMaterials,
    required this.questions,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'],
      name: json['name'],
      title: json['title'],
      description: json['description'],
      difficultyLevel: json['difficulty_level'],
      topic: json['topic'],
      time: DateTime.parse(json['time']),
      isPublished: json['is_published'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      duration: json['duration'],
      endTime: DateTime.parse(json['end_time']),
      negativeMarks: double.parse(json['negative_marks']),
      correctAnswerMarks: double.parse(json['correct_answer_marks']),
      shuffle: json['shuffle'],
      showAnswers: json['show_answers'],
      lockSolutions: json['lock_solutions'],
      isForm: json['is_form'],
      showMasteryOption: json['show_mastery_option'],
      readingMaterial: json['reading_material'],
      quizType: json['quiz_type'],
      isCustom: json['is_custom'],
      bannerId: json['banner_id'],
      examId: json['exam_id'],
      showUnanswered: json['show_unanswered'],
      endsAt: json['ends_at'],
      lives: json['lives'],
      liveCount: json['live_count'],
      coinCount: json['coin_count'],
      questionsCount: json['questions_count'],
      dailyDate: json['daily_date'],
      maxMistakeCount: json['max_mistake_count'],
      readingMaterials: json['reading_materials'],
      questions: (json['questions'] as List)
          .map((question) => Question.fromJson(question))
          .toList(),
    );
  }
}

class Question {
  final int id;
  final String description;
  final String? difficultyLevel;
  final String topic;
  final bool isPublished;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String detailedSolution;
  final String? type;
  final bool isMandatory;
  final bool showInFeed;
  final String? pyqLabel;
  final int topicId;
  final int readingMaterialId;
  final DateTime? fixedAt;
  final String? fixSummary;
  final String? createdBy;
  final String? updatedBy;
  final String? quizLevel;
  final String questionFrom;
  final String? language;
  final String? photoUrl;
  final String? photoSolutionUrl;
  final bool isSaved;
  final String? tag;
  final List<Option> options;

  Question({
    required this.id,
    required this.description,
    this.difficultyLevel,
    required this.topic,
    required this.isPublished,
    required this.createdAt,
    required this.updatedAt,
    required this.detailedSolution,
    this.type,
    required this.isMandatory,
    required this.showInFeed,
    this.pyqLabel,
    required this.topicId,
    required this.readingMaterialId,
    required this.fixedAt,
    required this.fixSummary,
    this.createdBy,
    this.updatedBy,
    this.quizLevel,
    required this.questionFrom,
    this.language,
    this.photoUrl,
    this.photoSolutionUrl,
    required this.isSaved,
    this.tag,
    required this.options,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      description: json['description'],
      difficultyLevel: json['difficulty_level'],
      topic: json['topic'],
      isPublished: json['is_published'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      detailedSolution: json['detailed_solution'],
      type: json['type'],
      isMandatory: json['is_mandatory'],
      showInFeed: json['show_in_feed'],
      pyqLabel: json['pyq_label'],
      topicId: json['topic_id'],
      readingMaterialId: json['reading_material_id'],
      fixedAt: json['fixed_at'] != null
          ? DateTime.parse(json['fixed_at'])
          : DateTime.now(),
      fixSummary: json['fix_summary'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      quizLevel: json['quiz_level'],
      questionFrom: json['question_from'],
      language: json['language'],
      photoUrl: json['photo_url'],
      photoSolutionUrl: json['photo_solution_url'],
      isSaved: json['is_saved'],
      tag: json['tag'],
      options: (json['options'] as List)
          .map((option) => Option.fromJson(option))
          .toList(),
    );
  }
}

class Option {
  final int id;
  final String description;
  final int questionId;
  final bool isCorrect;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool unanswered;
  final String? photoUrl;

  Option({
    required this.id,
    required this.description,
    required this.questionId,
    required this.isCorrect,
    required this.createdAt,
    required this.updatedAt,
    required this.unanswered,
    this.photoUrl,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: json['id'],
      description: json['description'],
      questionId: json['question_id'],
      isCorrect: json['is_correct'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      unanswered: json['unanswered'],
      photoUrl: json['photo_url'],
    );
  }
}
