
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../service/assistant_service.dart';

part 'question_state.dart';
part 'question_cubit.freezed.dart';

class QuestionCubit extends Cubit<QuestionState> {
  QuestionCubit() : super(const QuestionState.gradeSelection(isLoadingQuestions: false));

  void startQuiz({required String grade , required Function () handleFail}) {
    emit(const QuestionState.gradeSelection(isLoadingQuestions: true));
    
    createQuestion(
      grade,
          (data) {
        try {
          // Xử lý dữ liệu trả về dạng String
          String sanitizedData = data.trim();
          
          // Loại bỏ markdown block nếu có
          if (sanitizedData.startsWith("```json")) {
            sanitizedData = sanitizedData.replaceFirst("```json", "");
          }
          if (sanitizedData.endsWith("```")) {
            sanitizedData = sanitizedData.substring(0, sanitizedData.length - 3);
          }
          sanitizedData = sanitizedData.trim();

          List<Map<String, dynamic>> parsedQuestions;
          List<dynamic> jsonList;

          try {
            jsonList = jsonDecode(sanitizedData);
          } catch (e) {
            // Nếu parse thất bại, thử thay thế nháy đơn thành nháy kép (cần cẩn thận với apostrophe)
            // Đây là giải pháp tình thế nếu AI trả về sai format JSON
            print("Initial JSON parse failed, attempting to fix single quotes...");
            String fixedData = sanitizedData.replaceAll("'", '"');
            jsonList = jsonDecode(fixedData);
          }
          
          parsedQuestions = jsonList
              .map((item) => Map<String, dynamic>.from(item))
              .toList();

          // Kiểm tra xem có câu hỏi không
          if (parsedQuestions.isEmpty) {
            throw Exception("Không có câu hỏi nào được tạo");
          }

          // Kiểm tra format của từng câu hỏi
          for (var question in parsedQuestions) {
            if (!question.containsKey('content') ||
                !question.containsKey('A') ||
                !question.containsKey('B') ||
                !question.containsKey('C') ||
                !question.containsKey('D') ||
                !question.containsKey('correct')) {
              throw Exception("Format câu hỏi không đúng");
            }
          }
          
          emit(const QuestionState.gradeSelection(isLoadingQuestions: false)) ;
          emit(QuestionState.quiz(
              selectedGrade: grade,
              questionsByGrade: parsedQuestions, 
              currentQuestionIndex: 0, 
              selectedAnswer: null, 
              showAnswer: false, 
              score: 0
          ));


        } catch (e) {
          print("Error parsing data: $e");
          handleFail();
          emit(const QuestionState.gradeSelection(isLoadingQuestions: false));
        }
      },
          (error) {
        print("API Error: $error");
        handleFail();
        emit(const QuestionState.gradeSelection(isLoadingQuestions: false));
      },
    );
  }

  void backToGradeSelection() {
   emit(const QuestionState.gradeSelection(isLoadingQuestions: false));

  }
  void resetQuiz() {
    state.whenOrNull(
      result: (selectedGrade, score, questionsByGrade) {
        emit(QuestionState.quiz(
            selectedGrade: selectedGrade,
            questionsByGrade: questionsByGrade,
            currentQuestionIndex: 0,
            selectedAnswer: null,
            showAnswer: false,
            score: 0
        ));
      },
    );
  }

  void selectAnswer(String answer) {
    state.whenOrNull(
      quiz: (selectedGrade, questionsByGrade, currentQuestionIndex, selectedAnswer, showAnswer, score) {
        if (!showAnswer) {
          emit(QuestionState.quiz(selectedGrade: selectedGrade, questionsByGrade: questionsByGrade, currentQuestionIndex: currentQuestionIndex, selectedAnswer: answer, showAnswer: showAnswer, score: score));
        }
      },
    );

  }

  void checkAnswer() {
    state.whenOrNull(
      quiz: (selectedGrade, questionsByGrade, currentQuestionIndex, selectedAnswer, showAnswer, score) {
        if (selectedAnswer != null) {
          if (selectedAnswer == questionsByGrade[currentQuestionIndex]['correct']) {
            score++;
          }
          emit(QuestionState.quiz(selectedGrade: selectedGrade, questionsByGrade: questionsByGrade, currentQuestionIndex: currentQuestionIndex, selectedAnswer: selectedAnswer, showAnswer: true, score: score));
        }
      },
    );
  }

  void nextQuestion(int nextQuestion) {
    state.whenOrNull(
      quiz: (selectedGrade, questionsByGrade, currentQuestionIndex, selectedAnswer, showAnswer, score) {
        if (nextQuestion <= questionsByGrade.length - 1) {
          emit(QuestionState.quiz(selectedGrade: selectedGrade, questionsByGrade: questionsByGrade, currentQuestionIndex: nextQuestion, selectedAnswer: null, showAnswer: false, score: score));
        } else {
          emit(QuestionState.result(selectedGrade: selectedGrade, score: score, questionsByGrade: questionsByGrade));
        }
      },
    );

  }


}
