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
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.indigo.shade600, Colors.blue.shade500],
                      ),
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  centerTitle: true,
                  leading: IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_back_rounded, size: 20),
                    ),
                    onPressed: questionCubit.backToGradeSelection,
                  ),
                  actions: [
                    Container(
                      margin: const EdgeInsets.only(right: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.stars_rounded, color: Colors.amberAccent, size: 18),
                          const SizedBox(width: 6),
                          Text(
                            'Điểm: $score',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                body: questionsByGrade.isEmpty
                    ? const Center(
                  child: CircularProgressIndicator(),
                )
                    : Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            spreadRadius: 0,
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Câu ${currentQuestionIndex + 1} / ${questionsByGrade.length}',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.indigo.shade50,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '${(((currentQuestionIndex + 1) / questionsByGrade.length) * 100).toStringAsFixed(0)}%',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.indigo.shade600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: (currentQuestionIndex + 1) / questionsByGrade.length,
                              backgroundColor: Colors.grey.shade100,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo.shade500),
                              minHeight: 8,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          children: [
                            // Question Card
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(color: Colors.blue.shade50, width: 2),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.shade900.withOpacity(0.04),
                                    spreadRadius: 0,
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Text(
                                questionsByGrade[currentQuestionIndex]['content'] ?? 'Đang tải câu hỏi...',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  height: 1.5,
                                  color: Colors.indigo.shade900,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),

                            const SizedBox(height: 32),

                            // Answer Options
                            ListView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: ['A', 'B', 'C', 'D'].map((option) {
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 16),
                                  child: GestureDetector(
                                    onTap: () => questionCubit.selectAnswer(option),
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 300),
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(18),
                                      decoration: BoxDecoration(
                                        color: getAnswerColor(option, showAnswer, selectedAnswer, questionsByGrade[currentQuestionIndex]['correct']),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: getAnswerBorderColor(option, showAnswer, selectedAnswer, questionsByGrade[currentQuestionIndex]['correct']),
                                          width: 2,
                                        ),
                                        boxShadow: selectedAnswer == option && !showAnswer ? [
                                          BoxShadow(
                                            color: Colors.blue.withOpacity(0.15),
                                            blurRadius: 15,
                                            offset: const Offset(0, 5),
                                          )
                                        ] : [],
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 36,
                                            height: 36,
                                            decoration: BoxDecoration(
                                              color: getAnswerBorderColor(option, showAnswer, selectedAnswer, questionsByGrade[currentQuestionIndex]['correct']).withOpacity(0.1),
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: getAnswerBorderColor(option, showAnswer, selectedAnswer, questionsByGrade[currentQuestionIndex]['correct']),
                                              )
                                            ),
                                            child: Icon(
                                              getAnswerIcon(option, showAnswer, selectedAnswer, questionsByGrade[currentQuestionIndex]['correct']),
                                              color: getAnswerBorderColor(option, showAnswer, selectedAnswer, questionsByGrade[currentQuestionIndex]['correct']),
                                              size: 20,
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: Text(
                                              questionsByGrade[currentQuestionIndex][option] ?? '',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: selectedAnswer == option ? FontWeight.bold : FontWeight.w600,
                                                color: Colors.grey.shade800,
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
                          ],
                        ),
                      ),
                    ),

                    // Bottom Action Bar
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 20,
                            offset: const Offset(0, -5),
                          ),
                        ],
                      ),
                      child: SafeArea(
                        top: false,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: double.infinity,
                          height: 56,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: selectedAnswer != null && !showAnswer
                              ? LinearGradient(colors: [Colors.blue.shade500, Colors.indigo.shade600])
                              : (showAnswer ? LinearGradient(colors: [Colors.green.shade500, Colors.teal.shade600]) : null),
                            color: selectedAnswer == null ? Colors.grey.shade200 : null,
                            boxShadow: selectedAnswer != null ? [
                              BoxShadow(
                                color: (showAnswer ? Colors.green : Colors.blue).withOpacity(0.3),
                                blurRadius: 15,
                                offset: const Offset(0, 5),
                              ),
                            ] : [],
                          ),
                          child: ElevatedButton(
                            onPressed: selectedAnswer != null
                                ? (!showAnswer ? questionCubit.checkAnswer : () => questionCubit.nextQuestion(currentQuestionIndex + 1))
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              disabledForegroundColor: Colors.grey.shade500,
                            ),
                            child: Text(
                              !showAnswer ? 'Kiểm tra đáp án' : (currentQuestionIndex < questionsByGrade.length - 1 ? 'Câu tiếp theo' : 'Hoàn thành'),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
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