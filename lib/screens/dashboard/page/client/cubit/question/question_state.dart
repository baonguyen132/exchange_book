part of 'question_cubit.dart';

@freezed
class QuestionState with _$QuestionState{
  const factory QuestionState.gradeSelection({
    required bool isLoadingQuestions,
  }) = _GradeSelection;
  const factory QuestionState.quiz({
    required String? selectedGrade,
    required List<Map<String, dynamic>> questionsByGrade ,
    required int currentQuestionIndex ,
    required String? selectedAnswer,
    required bool showAnswer ,
    required int score,

  }) = _Quiz ;
  const factory QuestionState.result({
    required String? selectedGrade,
    required int score,
    required List<Map<String, dynamic>> questionsByGrade ,
  }) = _Result ;
}
