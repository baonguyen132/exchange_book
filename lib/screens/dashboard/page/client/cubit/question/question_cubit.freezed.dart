// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'question_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$QuestionState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool isLoadingQuestions) gradeSelection,
    required TResult Function(
            String? selectedGrade,
            List<Map<String, dynamic>> questionsByGrade,
            int currentQuestionIndex,
            String? selectedAnswer,
            bool showAnswer,
            int score)
        quiz,
    required TResult Function(String? selectedGrade, int score,
            List<Map<String, dynamic>> questionsByGrade)
        result,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool isLoadingQuestions)? gradeSelection,
    TResult? Function(
            String? selectedGrade,
            List<Map<String, dynamic>> questionsByGrade,
            int currentQuestionIndex,
            String? selectedAnswer,
            bool showAnswer,
            int score)?
        quiz,
    TResult? Function(String? selectedGrade, int score,
            List<Map<String, dynamic>> questionsByGrade)?
        result,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool isLoadingQuestions)? gradeSelection,
    TResult Function(
            String? selectedGrade,
            List<Map<String, dynamic>> questionsByGrade,
            int currentQuestionIndex,
            String? selectedAnswer,
            bool showAnswer,
            int score)?
        quiz,
    TResult Function(String? selectedGrade, int score,
            List<Map<String, dynamic>> questionsByGrade)?
        result,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GradeSelection value) gradeSelection,
    required TResult Function(_Quiz value) quiz,
    required TResult Function(_Result value) result,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GradeSelection value)? gradeSelection,
    TResult? Function(_Quiz value)? quiz,
    TResult? Function(_Result value)? result,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GradeSelection value)? gradeSelection,
    TResult Function(_Quiz value)? quiz,
    TResult Function(_Result value)? result,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuestionStateCopyWith<$Res> {
  factory $QuestionStateCopyWith(
          QuestionState value, $Res Function(QuestionState) then) =
      _$QuestionStateCopyWithImpl<$Res, QuestionState>;
}

/// @nodoc
class _$QuestionStateCopyWithImpl<$Res, $Val extends QuestionState>
    implements $QuestionStateCopyWith<$Res> {
  _$QuestionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuestionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$GradeSelectionImplCopyWith<$Res> {
  factory _$$GradeSelectionImplCopyWith(_$GradeSelectionImpl value,
          $Res Function(_$GradeSelectionImpl) then) =
      __$$GradeSelectionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool isLoadingQuestions});
}

/// @nodoc
class __$$GradeSelectionImplCopyWithImpl<$Res>
    extends _$QuestionStateCopyWithImpl<$Res, _$GradeSelectionImpl>
    implements _$$GradeSelectionImplCopyWith<$Res> {
  __$$GradeSelectionImplCopyWithImpl(
      _$GradeSelectionImpl _value, $Res Function(_$GradeSelectionImpl) _then)
      : super(_value, _then);

  /// Create a copy of QuestionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoadingQuestions = null,
  }) {
    return _then(_$GradeSelectionImpl(
      isLoadingQuestions: null == isLoadingQuestions
          ? _value.isLoadingQuestions
          : isLoadingQuestions // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$GradeSelectionImpl implements _GradeSelection {
  const _$GradeSelectionImpl({required this.isLoadingQuestions});

  @override
  final bool isLoadingQuestions;

  @override
  String toString() {
    return 'QuestionState.gradeSelection(isLoadingQuestions: $isLoadingQuestions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GradeSelectionImpl &&
            (identical(other.isLoadingQuestions, isLoadingQuestions) ||
                other.isLoadingQuestions == isLoadingQuestions));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoadingQuestions);

  /// Create a copy of QuestionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GradeSelectionImplCopyWith<_$GradeSelectionImpl> get copyWith =>
      __$$GradeSelectionImplCopyWithImpl<_$GradeSelectionImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool isLoadingQuestions) gradeSelection,
    required TResult Function(
            String? selectedGrade,
            List<Map<String, dynamic>> questionsByGrade,
            int currentQuestionIndex,
            String? selectedAnswer,
            bool showAnswer,
            int score)
        quiz,
    required TResult Function(String? selectedGrade, int score,
            List<Map<String, dynamic>> questionsByGrade)
        result,
  }) {
    return gradeSelection(isLoadingQuestions);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool isLoadingQuestions)? gradeSelection,
    TResult? Function(
            String? selectedGrade,
            List<Map<String, dynamic>> questionsByGrade,
            int currentQuestionIndex,
            String? selectedAnswer,
            bool showAnswer,
            int score)?
        quiz,
    TResult? Function(String? selectedGrade, int score,
            List<Map<String, dynamic>> questionsByGrade)?
        result,
  }) {
    return gradeSelection?.call(isLoadingQuestions);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool isLoadingQuestions)? gradeSelection,
    TResult Function(
            String? selectedGrade,
            List<Map<String, dynamic>> questionsByGrade,
            int currentQuestionIndex,
            String? selectedAnswer,
            bool showAnswer,
            int score)?
        quiz,
    TResult Function(String? selectedGrade, int score,
            List<Map<String, dynamic>> questionsByGrade)?
        result,
    required TResult orElse(),
  }) {
    if (gradeSelection != null) {
      return gradeSelection(isLoadingQuestions);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GradeSelection value) gradeSelection,
    required TResult Function(_Quiz value) quiz,
    required TResult Function(_Result value) result,
  }) {
    return gradeSelection(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GradeSelection value)? gradeSelection,
    TResult? Function(_Quiz value)? quiz,
    TResult? Function(_Result value)? result,
  }) {
    return gradeSelection?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GradeSelection value)? gradeSelection,
    TResult Function(_Quiz value)? quiz,
    TResult Function(_Result value)? result,
    required TResult orElse(),
  }) {
    if (gradeSelection != null) {
      return gradeSelection(this);
    }
    return orElse();
  }
}

abstract class _GradeSelection implements QuestionState {
  const factory _GradeSelection({required final bool isLoadingQuestions}) =
      _$GradeSelectionImpl;

  bool get isLoadingQuestions;

  /// Create a copy of QuestionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GradeSelectionImplCopyWith<_$GradeSelectionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$QuizImplCopyWith<$Res> {
  factory _$$QuizImplCopyWith(
          _$QuizImpl value, $Res Function(_$QuizImpl) then) =
      __$$QuizImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String? selectedGrade,
      List<Map<String, dynamic>> questionsByGrade,
      int currentQuestionIndex,
      String? selectedAnswer,
      bool showAnswer,
      int score});
}

/// @nodoc
class __$$QuizImplCopyWithImpl<$Res>
    extends _$QuestionStateCopyWithImpl<$Res, _$QuizImpl>
    implements _$$QuizImplCopyWith<$Res> {
  __$$QuizImplCopyWithImpl(_$QuizImpl _value, $Res Function(_$QuizImpl) _then)
      : super(_value, _then);

  /// Create a copy of QuestionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedGrade = freezed,
    Object? questionsByGrade = null,
    Object? currentQuestionIndex = null,
    Object? selectedAnswer = freezed,
    Object? showAnswer = null,
    Object? score = null,
  }) {
    return _then(_$QuizImpl(
      selectedGrade: freezed == selectedGrade
          ? _value.selectedGrade
          : selectedGrade // ignore: cast_nullable_to_non_nullable
              as String?,
      questionsByGrade: null == questionsByGrade
          ? _value._questionsByGrade
          : questionsByGrade // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
      currentQuestionIndex: null == currentQuestionIndex
          ? _value.currentQuestionIndex
          : currentQuestionIndex // ignore: cast_nullable_to_non_nullable
              as int,
      selectedAnswer: freezed == selectedAnswer
          ? _value.selectedAnswer
          : selectedAnswer // ignore: cast_nullable_to_non_nullable
              as String?,
      showAnswer: null == showAnswer
          ? _value.showAnswer
          : showAnswer // ignore: cast_nullable_to_non_nullable
              as bool,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$QuizImpl implements _Quiz {
  const _$QuizImpl(
      {required this.selectedGrade,
      required final List<Map<String, dynamic>> questionsByGrade,
      required this.currentQuestionIndex,
      required this.selectedAnswer,
      required this.showAnswer,
      required this.score})
      : _questionsByGrade = questionsByGrade;

  @override
  final String? selectedGrade;
  final List<Map<String, dynamic>> _questionsByGrade;
  @override
  List<Map<String, dynamic>> get questionsByGrade {
    if (_questionsByGrade is EqualUnmodifiableListView)
      return _questionsByGrade;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questionsByGrade);
  }

  @override
  final int currentQuestionIndex;
  @override
  final String? selectedAnswer;
  @override
  final bool showAnswer;
  @override
  final int score;

  @override
  String toString() {
    return 'QuestionState.quiz(selectedGrade: $selectedGrade, questionsByGrade: $questionsByGrade, currentQuestionIndex: $currentQuestionIndex, selectedAnswer: $selectedAnswer, showAnswer: $showAnswer, score: $score)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuizImpl &&
            (identical(other.selectedGrade, selectedGrade) ||
                other.selectedGrade == selectedGrade) &&
            const DeepCollectionEquality()
                .equals(other._questionsByGrade, _questionsByGrade) &&
            (identical(other.currentQuestionIndex, currentQuestionIndex) ||
                other.currentQuestionIndex == currentQuestionIndex) &&
            (identical(other.selectedAnswer, selectedAnswer) ||
                other.selectedAnswer == selectedAnswer) &&
            (identical(other.showAnswer, showAnswer) ||
                other.showAnswer == showAnswer) &&
            (identical(other.score, score) || other.score == score));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      selectedGrade,
      const DeepCollectionEquality().hash(_questionsByGrade),
      currentQuestionIndex,
      selectedAnswer,
      showAnswer,
      score);

  /// Create a copy of QuestionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuizImplCopyWith<_$QuizImpl> get copyWith =>
      __$$QuizImplCopyWithImpl<_$QuizImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool isLoadingQuestions) gradeSelection,
    required TResult Function(
            String? selectedGrade,
            List<Map<String, dynamic>> questionsByGrade,
            int currentQuestionIndex,
            String? selectedAnswer,
            bool showAnswer,
            int score)
        quiz,
    required TResult Function(String? selectedGrade, int score,
            List<Map<String, dynamic>> questionsByGrade)
        result,
  }) {
    return quiz(selectedGrade, questionsByGrade, currentQuestionIndex,
        selectedAnswer, showAnswer, score);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool isLoadingQuestions)? gradeSelection,
    TResult? Function(
            String? selectedGrade,
            List<Map<String, dynamic>> questionsByGrade,
            int currentQuestionIndex,
            String? selectedAnswer,
            bool showAnswer,
            int score)?
        quiz,
    TResult? Function(String? selectedGrade, int score,
            List<Map<String, dynamic>> questionsByGrade)?
        result,
  }) {
    return quiz?.call(selectedGrade, questionsByGrade, currentQuestionIndex,
        selectedAnswer, showAnswer, score);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool isLoadingQuestions)? gradeSelection,
    TResult Function(
            String? selectedGrade,
            List<Map<String, dynamic>> questionsByGrade,
            int currentQuestionIndex,
            String? selectedAnswer,
            bool showAnswer,
            int score)?
        quiz,
    TResult Function(String? selectedGrade, int score,
            List<Map<String, dynamic>> questionsByGrade)?
        result,
    required TResult orElse(),
  }) {
    if (quiz != null) {
      return quiz(selectedGrade, questionsByGrade, currentQuestionIndex,
          selectedAnswer, showAnswer, score);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GradeSelection value) gradeSelection,
    required TResult Function(_Quiz value) quiz,
    required TResult Function(_Result value) result,
  }) {
    return quiz(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GradeSelection value)? gradeSelection,
    TResult? Function(_Quiz value)? quiz,
    TResult? Function(_Result value)? result,
  }) {
    return quiz?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GradeSelection value)? gradeSelection,
    TResult Function(_Quiz value)? quiz,
    TResult Function(_Result value)? result,
    required TResult orElse(),
  }) {
    if (quiz != null) {
      return quiz(this);
    }
    return orElse();
  }
}

abstract class _Quiz implements QuestionState {
  const factory _Quiz(
      {required final String? selectedGrade,
      required final List<Map<String, dynamic>> questionsByGrade,
      required final int currentQuestionIndex,
      required final String? selectedAnswer,
      required final bool showAnswer,
      required final int score}) = _$QuizImpl;

  String? get selectedGrade;
  List<Map<String, dynamic>> get questionsByGrade;
  int get currentQuestionIndex;
  String? get selectedAnswer;
  bool get showAnswer;
  int get score;

  /// Create a copy of QuestionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuizImplCopyWith<_$QuizImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ResultImplCopyWith<$Res> {
  factory _$$ResultImplCopyWith(
          _$ResultImpl value, $Res Function(_$ResultImpl) then) =
      __$$ResultImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String? selectedGrade,
      int score,
      List<Map<String, dynamic>> questionsByGrade});
}

/// @nodoc
class __$$ResultImplCopyWithImpl<$Res>
    extends _$QuestionStateCopyWithImpl<$Res, _$ResultImpl>
    implements _$$ResultImplCopyWith<$Res> {
  __$$ResultImplCopyWithImpl(
      _$ResultImpl _value, $Res Function(_$ResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of QuestionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedGrade = freezed,
    Object? score = null,
    Object? questionsByGrade = null,
  }) {
    return _then(_$ResultImpl(
      selectedGrade: freezed == selectedGrade
          ? _value.selectedGrade
          : selectedGrade // ignore: cast_nullable_to_non_nullable
              as String?,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      questionsByGrade: null == questionsByGrade
          ? _value._questionsByGrade
          : questionsByGrade // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
    ));
  }
}

/// @nodoc

class _$ResultImpl implements _Result {
  const _$ResultImpl(
      {required this.selectedGrade,
      required this.score,
      required final List<Map<String, dynamic>> questionsByGrade})
      : _questionsByGrade = questionsByGrade;

  @override
  final String? selectedGrade;
  @override
  final int score;
  final List<Map<String, dynamic>> _questionsByGrade;
  @override
  List<Map<String, dynamic>> get questionsByGrade {
    if (_questionsByGrade is EqualUnmodifiableListView)
      return _questionsByGrade;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questionsByGrade);
  }

  @override
  String toString() {
    return 'QuestionState.result(selectedGrade: $selectedGrade, score: $score, questionsByGrade: $questionsByGrade)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResultImpl &&
            (identical(other.selectedGrade, selectedGrade) ||
                other.selectedGrade == selectedGrade) &&
            (identical(other.score, score) || other.score == score) &&
            const DeepCollectionEquality()
                .equals(other._questionsByGrade, _questionsByGrade));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedGrade, score,
      const DeepCollectionEquality().hash(_questionsByGrade));

  /// Create a copy of QuestionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResultImplCopyWith<_$ResultImpl> get copyWith =>
      __$$ResultImplCopyWithImpl<_$ResultImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(bool isLoadingQuestions) gradeSelection,
    required TResult Function(
            String? selectedGrade,
            List<Map<String, dynamic>> questionsByGrade,
            int currentQuestionIndex,
            String? selectedAnswer,
            bool showAnswer,
            int score)
        quiz,
    required TResult Function(String? selectedGrade, int score,
            List<Map<String, dynamic>> questionsByGrade)
        result,
  }) {
    return result(selectedGrade, score, questionsByGrade);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(bool isLoadingQuestions)? gradeSelection,
    TResult? Function(
            String? selectedGrade,
            List<Map<String, dynamic>> questionsByGrade,
            int currentQuestionIndex,
            String? selectedAnswer,
            bool showAnswer,
            int score)?
        quiz,
    TResult? Function(String? selectedGrade, int score,
            List<Map<String, dynamic>> questionsByGrade)?
        result,
  }) {
    return result?.call(selectedGrade, score, questionsByGrade);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(bool isLoadingQuestions)? gradeSelection,
    TResult Function(
            String? selectedGrade,
            List<Map<String, dynamic>> questionsByGrade,
            int currentQuestionIndex,
            String? selectedAnswer,
            bool showAnswer,
            int score)?
        quiz,
    TResult Function(String? selectedGrade, int score,
            List<Map<String, dynamic>> questionsByGrade)?
        result,
    required TResult orElse(),
  }) {
    if (result != null) {
      return result(selectedGrade, score, questionsByGrade);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_GradeSelection value) gradeSelection,
    required TResult Function(_Quiz value) quiz,
    required TResult Function(_Result value) result,
  }) {
    return result(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_GradeSelection value)? gradeSelection,
    TResult? Function(_Quiz value)? quiz,
    TResult? Function(_Result value)? result,
  }) {
    return result?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_GradeSelection value)? gradeSelection,
    TResult Function(_Quiz value)? quiz,
    TResult Function(_Result value)? result,
    required TResult orElse(),
  }) {
    if (result != null) {
      return result(this);
    }
    return orElse();
  }
}

abstract class _Result implements QuestionState {
  const factory _Result(
          {required final String? selectedGrade,
          required final int score,
          required final List<Map<String, dynamic>> questionsByGrade}) =
      _$ResultImpl;

  String? get selectedGrade;
  int get score;
  List<Map<String, dynamic>> get questionsByGrade;

  /// Create a copy of QuestionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResultImplCopyWith<_$ResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
