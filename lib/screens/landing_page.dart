import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/providers/quiz_provider.dart';
import 'package:quiz_app/providers/user_data_provider.dart';
import 'package:quiz_app/screens/question_page.dart';
import 'package:quiz_app/utils/gradient_decorations.dart';
import 'package:quiz_app/utils/rich_text.dart';

class LandingPage extends ConsumerStatefulWidget {
  const LandingPage({super.key});

  @override
  ConsumerState<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends ConsumerState<LandingPage> {
  @override
  void initState() {
    super.initState();
    ref.read(quizProvider.notifier).loadQuizData();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final quiz = ref.watch(quizProvider);
    final userData = ref.watch(userDataProvider);
    return Scaffold(
      body: SafeArea(
        child: quiz.when(
          data: (quiz) {
            return Container(
              height: size.height,
              width: size.width,
              decoration: linearGradient,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.deepPurple, Colors.white],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [0.5, 0.99]),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black54,
                          offset: Offset(4, 4),
                          blurRadius: 10,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Quiz\nApp',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            offset: Offset(2.0, 2.0),
                            blurRadius: 5.0,
                            color: Colors.black45,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(flex: 2),
                  Container(
                    height: size.height * 0.2,
                    width: size.width * 0.7,
                    decoration: radialGradient,
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        styledRichText(
                            keyText: 'Topic', valueText: quiz?.topic ?? 'N/A'),
                        styledRichText(
                            keyText: 'Title', valueText: quiz?.title ?? 'N/A'),
                        styledRichText(
                            keyText: 'Ends At',
                            valueText: quiz?.endsAt ?? 'N/A'),
                        // styledRichText(
                        //     keyText: 'Duration',
                        //     valueText: '${quiz?.duration ?? 0} minutes'),
                        styledRichText(
                            keyText: 'Question Count',
                            valueText:
                                '${quiz?.questionsCount ?? 0} questions'),
                        styledRichText(
                            keyText: 'Correct Answer Marks',
                            valueText: '+${quiz?.correctAnswerMarks ?? 0}'),
                        styledRichText(
                            keyText: 'Negative Marking',
                            valueText: '-${quiz?.negativeMarks ?? 0}'),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 135,
                    width: size.width * 0.7,
                    decoration: radialGradient,
                    padding: EdgeInsets.all(5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'User Stats',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        styledRichText(
                            keyText: 'Attempted',
                            valueText: '${userData.attempted} questions'),
                        styledRichText(
                            keyText: 'Skipped',
                            valueText: '${userData.skipped} questions'),
                        styledRichText(
                            keyText: 'Total Score',
                            valueText: '${userData.marks}'),
                        styledRichText(
                            keyText: 'Coins',
                            valueText: userData.coins.toString())
                      ],
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      fixedSize: Size(200, 50),
                      padding: EdgeInsets.all(5),
                      elevation: 10,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return QuestionPage(
                              questions: quiz?.questions ?? [],
                              testId: quiz?.id.toString() ?? 'testID',
                              correctAnswerMarks: quiz?.correctAnswerMarks ?? 4,
                              negativeMarks: quiz?.negativeMarks ?? -1,
                            );
                          },
                        ),
                      );
                    },
                    child: Text(
                      'Start Quiz',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      fixedSize: Size(200, 50),
                      padding: EdgeInsets.all(5),
                      elevation: 10,
                    ),
                    onPressed: () {
                      ref.read(userDataProvider.notifier).resetData();
                    },
                    child: Text(
                      'Reset Stats',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            );
          },
          error: (error, stack) {
            return Center(
              child: Text('Error occured while fetching quiz data'),
            );
          },
          loading: () {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          },
        ),
      ),
    );
  }
}
