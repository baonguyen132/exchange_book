import 'package:exchange_book/model/transaction_modal.dart';
import 'package:exchange_book/model/user_modal.dart';
import 'package:exchange_book/screens/dashboard/page/client/cubit/question/question_cubit.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/question/grade_selection_screen.dart';
import 'package:exchange_book/screens/dashboard/page/client/widget/question/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Question extends StatefulWidget {
  final UserModel userModel ;
  const Question({super.key, required this.userModel});

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  QuestionCubit questionCubit = QuestionCubit() ;



  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.red.shade600,
                size: 28,
              ),
              const SizedBox(width: 12),
              const Text('Lỗi'),
            ],
          ),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Đóng'),
            ),
          ],
        );
      },
    );
  }


Color getAnswerColor(String option , bool showAnswer , String? selectedAnswer , String correctAnswer) {
    if (!showAnswer) {
      return selectedAnswer == option ? Colors.blue.shade100 : Colors.white;
    }

    if (option == correctAnswer) {
      return Colors.green.shade100;
    } else if (option == selectedAnswer && selectedAnswer != correctAnswer) {
      return Colors.red.shade100;
    } else {
      return Colors.grey.shade100;
    }
}

  Color getAnswerBorderColor(String option , bool showAnswer , String? selectedAnswer , String correctAnswer) {
    if (!showAnswer) {
      return selectedAnswer == option
          ? Colors.blue.shade600
          : Colors.grey.shade300;
    }


    if (option == correctAnswer) {
      return Colors.green.shade600;
    } else if (option == selectedAnswer && selectedAnswer != correctAnswer) {
      return Colors.red.shade600;
    } else {
      return Colors.grey.shade300;
    }
  }

  IconData getAnswerIcon(String option, bool showAnswer , String? selectedAnswer , String correctAnswer) {
    if (!showAnswer) return Icons.radio_button_unchecked;

    if (option == correctAnswer) {
      return Icons.check_circle;
    } else if (option == selectedAnswer && selectedAnswer != correctAnswer) {
      return Icons.cancel;
    } else {
      return Icons.radio_button_unchecked;
    }
  }

  @override
  Widget build(BuildContext context) {


    return BlocBuilder<QuestionCubit , QuestionState>(
      bloc: questionCubit,
      builder: (context, state) {
        return state.when(
            gradeSelection: (isLoadingQuestions) => GradeSelectionScreen(
              isLoadingQuestions: isLoadingQuestions,
              handleStartQuiz: (grade) {
                questionCubit.startQuiz(grade: grade, handleFail: () {
                  _showErrorDialog("Lỗi xử lý dữ liệu");
                },);
              }
            ),
            quiz: (selectedGrade, questionsByGrade, currentQuestionIndex, selectedAnswer, showAnswer, score) {

              return Scaffold(
                backgroundColor: Colors.grey.shade50,
                appBar: AppBar(
                  title: Text(
                    'Quiz - Lớp $selectedGrade',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.blue.shade600,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: questionCubit.backToGradeSelection,
                  ),
                  actions: [
                    Container(
                      margin: const EdgeInsets.only(right: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${currentQuestionIndex + 1}/${questionsByGrade.length}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                body: questionsByGrade.isEmpty
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Progress Bar
                      Container(
                        margin: const EdgeInsets.only(bottom: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Câu ${currentQuestionIndex + 1}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue.shade600,
                                  ),
                                ),
                                Text(
                                  'Điểm: $score/${questionsByGrade.length}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            LinearProgressIndicator(
                              value: (currentQuestionIndex + 1) / questionsByGrade.length,
                              backgroundColor: Colors.grey.shade300,
                              valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.blue.shade600),
                              minHeight: 6,
                            ),
                          ],
                        ),
                      ),

                      // Question Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              spreadRadius: 0,
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Text(
                          questionsByGrade[currentQuestionIndex]['content'] ?? 'Đang tải câu hỏi...',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            height: 1.4,
                            color: Colors.black87,
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Answer Options
                      Expanded(
                        child: ListView(
                          children: ['A', 'B', 'C', 'D'].map((option) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              child: GestureDetector(
                                onTap: () => questionCubit.selectAnswer(option),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: getAnswerColor(option, showAnswer, selectedAnswer, questionsByGrade[currentQuestionIndex]['correct']),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: getAnswerBorderColor(option, showAnswer, selectedAnswer, questionsByGrade[currentQuestionIndex]['correct']),
                                      width: 2,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 32,
                                        height: 32,
                                        decoration: BoxDecoration(
                                          color: getAnswerBorderColor(option, showAnswer, selectedAnswer, questionsByGrade[currentQuestionIndex]['correct']),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          getAnswerIcon(option, showAnswer, selectedAnswer, questionsByGrade[currentQuestionIndex]['correct']),
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        '$option.',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: getAnswerBorderColor(option, showAnswer, selectedAnswer, questionsByGrade[currentQuestionIndex]['correct']),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          questionsByGrade[currentQuestionIndex][option] ?? '',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                      // Action Buttons
                      if (!showAnswer) ...[
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: selectedAnswer != null ? questionCubit.checkAnswer : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.shade600,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              disabledBackgroundColor: Colors.grey.shade300,
                            ),
                            child: const Text(
                              'Kiểm tra đáp án',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ] else ...[
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () => questionCubit.nextQuestion(currentQuestionIndex + 1),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green.shade600,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              currentQuestionIndex <questionsByGrade.length - 1
                                  ? 'Câu tiếp theo'
                                  : 'Hoàn thành',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],

                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              );

            },
            result: (selectedGrade, score, questionsByGrade) {
              return  ResultScreen(
                score: score,
                noQuestionsByGrade: questionsByGrade.length,
                selectedGrade: selectedGrade!,
                backToGradeSelection: questionCubit.backToGradeSelection,
                resetQuiz: () => questionCubit.resetQuiz(),
                receivePoint: () {
                  TransactionModel.addPoint(idUser: widget.userModel.id.toString(), countCorrect: score, successful: (data) {
                    Navigator.pop(context , data["point"][0]) ;
                  }, fail: () {

                  },);
                },
              );
            },
        );
      },
    );
  }


}