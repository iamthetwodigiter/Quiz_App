import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app/models/quiz_model.dart';
import 'package:quiz_app/providers/user_data_provider.dart';
import 'package:quiz_app/utils/gradient_decorations.dart';
import 'package:quiz_app/utils/rich_text.dart';
import 'package:quiz_app/widgets/question_card.dart';

class QuestionPage extends ConsumerStatefulWidget {
  final List<Question> questions;
  final String testId;
  final double correctAnswerMarks;
  final double negativeMarks;

  const QuestionPage({
    super.key,
    required this.questions,
    required this.testId,
    required this.correctAnswerMarks,
    required this.negativeMarks,
  });

  @override
  ConsumerState<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends ConsumerState<QuestionPage> {
  int currentIndex = 0;
  int? selectedOptionIndex;
  bool showCorrectAnswer = false;

  @override
  void initState() {
    super.initState();
    loadSavedData();
  }

  void loadSavedData() {
    final testDetails =
        ref.read(userDataProvider.notifier).getTestDetails(widget.testId);
    if (testDetails.isNotEmpty &&
        testDetails.containsKey(widget.questions[currentIndex].id)) {
      final savedData = testDetails[widget.questions[currentIndex].id];
      setState(() {
        selectedOptionIndex =
            ['A', 'B', 'C', 'D'].indexOf(savedData['selectedOption']);
        showCorrectAnswer = true;
      });
    }
  }

  void updateQuestion(bool isNext) {
    setState(() {
      if (isNext) {
        currentIndex = (currentIndex + 1) % widget.questions.length;
      } else {
        currentIndex = (currentIndex - 1 + widget.questions.length) %
            widget.questions.length;
      }
      selectedOptionIndex = null;
      showCorrectAnswer = false;
    });

    loadSavedData();
  }

  void displayDetailedSolution(BuildContext context, String soln) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                height: 500,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Solution",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          soln,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: IconButton(
                  icon: Icon(Icons.close, color: Colors.black),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showSolutionHint(String soln) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                width: double.infinity,
                height: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Need Hint?",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Display the solution for 5 🪙 now',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 25),
                    Row(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            fixedSize: Size(50, 30),
                            padding: EdgeInsets.all(5),
                            elevation: 10,
                          ),
                          onPressed: () {
                            int coins = ref.read(userDataProvider).coins;
                            Navigator.of(context).pop();
                            if (coins - 5 < 0) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Not enough 🪙.\tTry again after you collect more coins...',
                                  ),
                                ),
                              );
                            } else {
                              ref
                                  .read(userDataProvider.notifier)
                                  .updateCoins(coins - 5);
                              displayDetailedSolution(context, soln);
                            }
                          },
                          child: Text(
                            'Yes',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            fixedSize: Size(50, 30),
                            padding: EdgeInsets.all(5),
                            elevation: 10,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'No',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: IconButton(
                  icon: Icon(Icons.close, color: Colors.black),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showSummary() {
    final userData = ref.read(userDataProvider);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            width: double.infinity,
            height: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Quiz Summary",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15),
                styledRichText(
                    keyText: 'Attempted',
                    valueText: '${userData.attempted} questions'),
                styledRichText(
                    keyText: 'Skipped',
                    valueText: '${userData.skipped} questions'),
                styledRichText(
                    keyText: 'Marks', valueText: '${userData.marks}'),
                styledRichText(keyText: '🪙', valueText: '${userData.coins}'),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    fixedSize: Size(50, 30),
                    padding: EdgeInsets.all(5),
                    elevation: 10,
                  ),
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  child: Text(
                    'Close',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(userDataProvider);
    final userNotifier = ref.read(userDataProvider.notifier);
    final size = MediaQuery.sizeOf(context);

    final testId = widget.testId;

    final testDetails = userNotifier.getTestDetails(testId);
    final questionProgress =
        testDetails[widget.questions[currentIndex].id.toString()];

    final previousSelectedOption = questionProgress?['selectedOption'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: Text('Question ${currentIndex + 1}/${widget.questions.length}'),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 22),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                Text(
                  'Marks: ${userData.marks}',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                Text(
                  '🪙: ${userData.coins}',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ],
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          decoration: linearGradient,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: size.height / 1.25,
                width: size.width - 50,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    QuestionCard(
                      question: widget.questions[currentIndex],
                      selectedOptionIndex: previousSelectedOption != null
                          ? ['A', 'B', 'C', 'D'].indexOf(previousSelectedOption)
                          : null,
                      showCorrectAnswer: showCorrectAnswer,
                      onOptionSelected: (index) {
                        if (selectedOptionIndex != null) return;
                        setState(() {
                          selectedOptionIndex = index;
                          showCorrectAnswer = true;

                          final option =
                              widget.questions[currentIndex].options[index];
                          final isCorrect = option.isCorrect;
                          final selectedOption = ['A', 'B', 'C', 'D'][index];

                          if (isCorrect) {
                            userNotifier.updateCorrectAnswer(
                                userData.correctAnswer + 1);
                            userNotifier.updateMarks(userData.marks +
                                widget.correctAnswerMarks.floor());
                            userNotifier.updateCoins(userData.coins + 2);
                          } else {
                            userNotifier.updateMarks(
                                userData.marks - widget.negativeMarks.floor());
                          }
                          userNotifier.updateAttempted(userData.attempted + 1);
                          userNotifier.saveQuestionProgress(
                            testId: testId,
                            questionId: widget.questions[currentIndex].id,
                            selectedOption: selectedOption,
                            isCorrect: isCorrect,
                          );
                          if (currentIndex == widget.questions.length - 1) {
                            showSummary();
                          }
                        });
                      },
                      height: size.height / 1.25,
                    ),
                    SizedBox(
                      height: 75,
                      child: Column(
                        children: [
                          Text(
                            'Correct Answers: ${userData.correctAnswer}',
                            style: TextStyle(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: currentIndex > 0
                                    ? () {
                                        updateQuestion(false);
                                      }
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurple,
                                  fixedSize: Size(100, 30),
                                  padding: EdgeInsets.all(5),
                                  elevation: 10,
                                ),
                                child: const Text(
                                  'Previous',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: (selectedOptionIndex != null ||
                                        questionProgress != null)
                                    ? () {
                                        displayDetailedSolution(
                                          context,
                                          widget.questions[currentIndex]
                                              .detailedSolution,
                                        );
                                      }
                                    : () {
                                        showSolutionHint(widget
                                            .questions[currentIndex]
                                            .detailedSolution);
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurple,
                                  fixedSize: Size(100, 30),
                                  padding: EdgeInsets.all(5),
                                  elevation: 10,
                                ),
                                child: const Text(
                                  'Deatiled\nSolution',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 11),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: currentIndex <
                                        widget.questions.length - 1
                                    ? () {
                                        final questionId = widget
                                            .questions[currentIndex].id
                                            .toString();
                                        final questionProgress = userNotifier
                                            .getTestDetails(testId)[questionId];

                                        if (selectedOptionIndex == null &&
                                            questionProgress == null) {
                                          userNotifier.updateSkipped(
                                              userData.skipped + 1);
                                        }
                                        updateQuestion(true);
                                      }
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurple,
                                  fixedSize: Size(100, 30),
                                  padding: EdgeInsets.all(5),
                                  elevation: 10,
                                ),
                                child: const Text(
                                  'Next',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
