import 'package:exchange_book/service/assistant_service.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class Question extends StatefulWidget {
  const Question({super.key});

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  int currentQuestionIndex = 0;
  String? selectedAnswer;
  bool showAnswer = false;
  int score = 0;
  bool isQuizCompleted = false;
  String? selectedGrade;
  bool showGradeSelection = true;
  bool isLoadingQuestions = false;

  // Thêm controller cho input
  final TextEditingController _gradeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Questions sẽ được load từ AI
  List<Map<String, dynamic>> questionsByGrade = [];

  @override
  void dispose() {
    _gradeController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get currentQuestions {
    return questionsByGrade;
  }

  void startQuiz() {
    if (_formKey.currentState!.validate()) {
      String grade = _gradeController.text.trim();

      setState(() {
        isLoadingQuestions = true;
      });

      createQuestion(
        grade,
            (data) {
          print("Raw data received: $data");

          try {
            // Xử lý dữ liệu trả về dạng String
            List<Map<String, dynamic>> parsedQuestions;

            // Nếu data là String, parse JSON
            List<dynamic> jsonList = jsonDecode(data);
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

            setState(() {
              selectedGrade = grade;
              questionsByGrade = parsedQuestions;
              showGradeSelection = false;
              currentQuestionIndex = 0;
              selectedAnswer = null;
              showAnswer = false;
              score = 0;
              isQuizCompleted = false;
              isLoadingQuestions = false;
            });

          } catch (e) {
            print("Error parsing data: $e");
            _showErrorDialog("Lỗi xử lý dữ liệu");
            setState(() {
              isLoadingQuestions = false;
            });
          }
        },
            (error) {
          print("API Error: $error");
          _showErrorDialog("Không thể tạo câu hỏi");
          setState(() {
            isLoadingQuestions = false;
          });
        },
      );
    }
  }

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

  void backToGradeSelection() {
    setState(() {
      showGradeSelection = true;
      selectedGrade = null;
      currentQuestionIndex = 0;
      selectedAnswer = null;
      showAnswer = false;
      score = 0;
      isQuizCompleted = false;
      questionsByGrade = [];
      _gradeController.clear();
    });
  }

  void selectAnswer(String answer) {
    if (!showAnswer) {
      setState(() {
        selectedAnswer = answer;
      });
    }
  }

  void checkAnswer() {
    if (selectedAnswer != null) {
      setState(() {
        showAnswer = true;
        if (selectedAnswer ==
            currentQuestions[currentQuestionIndex]['correct']) {
          score++;
        }
      });
    }
  }

  void nextQuestion() {
    if (currentQuestionIndex < currentQuestions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswer = null;
        showAnswer = false;
      });
    } else {
      setState(() {
        isQuizCompleted = true;
      });
    }
  }

  void resetQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      selectedAnswer = null;
      showAnswer = false;
      score = 0;
      isQuizCompleted = false;
    });
  }

  Color getAnswerColor(String option) {
    if (!showAnswer) {
      return selectedAnswer == option ? Colors.blue.shade100 : Colors.white;
    }

    String correctAnswer = currentQuestions[currentQuestionIndex]['correct'];

    if (option == correctAnswer) {
      return Colors.green.shade100;
    } else if (option == selectedAnswer && selectedAnswer != correctAnswer) {
      return Colors.red.shade100;
    } else {
      return Colors.grey.shade100;
    }
  }

  Color getAnswerBorderColor(String option) {
    if (!showAnswer) {
      return selectedAnswer == option
          ? Colors.blue.shade600
          : Colors.grey.shade300;
    }

    String correctAnswer = currentQuestions[currentQuestionIndex]['correct'];

    if (option == correctAnswer) {
      return Colors.green.shade600;
    } else if (option == selectedAnswer && selectedAnswer != correctAnswer) {
      return Colors.red.shade600;
    } else {
      return Colors.grey.shade300;
    }
  }

  IconData getAnswerIcon(String option) {
    if (!showAnswer) return Icons.radio_button_unchecked;

    String correctAnswer = currentQuestions[currentQuestionIndex]['correct'];

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
    if (showGradeSelection) {
      return _buildGradeSelectionScreen();
    }

    if (isQuizCompleted) {
      return _buildResultScreen();
    }

    return _buildQuizScreen();
  }

  Widget _buildGradeSelectionScreen() {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          'Câu hỏi ôn tập',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.indigo.shade600,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                // Header Icon
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.indigo.shade100,
                        Colors.indigo.shade50,
                      ],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.indigo.withOpacity(0.2),
                        spreadRadius: 0,
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.quiz_rounded,
                    size: 50,
                    color: Colors.indigo.shade600,
                  ),
                ),

                const SizedBox(height: 40),

                // Title
                Text(
                  'Chào mừng đến với\nCâu hỏi ôn tập AI!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo.shade800,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 16),

                Text(
                  'AI sẽ tạo câu hỏi phù hợp với lớp của bạn',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 30),

                // Grade Input
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        spreadRadius: 0,
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.indigo.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.school_rounded,
                              color: Colors.indigo.shade600,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            'Bạn đang học lớp mấy?',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      TextFormField(
                        controller: _gradeController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        enabled: !isLoadingQuestions,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          hintText: 'VD: 10, 11, 12',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: Colors.indigo.shade600,
                              width: 3,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                              width: 2,
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: Colors.grey.shade200,
                              width: 2,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: Colors.red.shade400,
                              width: 2,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: Colors.red.shade600,
                              width: 3,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 20,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Vui lòng nhập lớp của bạn';
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) =>
                        isLoadingQuestions ? null : startQuiz(),
                      ),

                      const SizedBox(height: 16),

                      // AI Info
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.blue.shade200,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.auto_awesome_rounded,
                              color: Colors.blue.shade600,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'AI sẽ tạo câu hỏi đa dạng từ nhiều môn học phù hợp với lớp của bạn',
                                style: TextStyle(
                                  color: Colors.blue.shade700,
                                  fontSize: 14,
                                  height: 1.3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Start Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: isLoadingQuestions ? null : startQuiz,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isLoadingQuestions
                          ? Colors.grey.shade400
                          : Colors.indigo.shade600,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shadowColor: Colors.indigo.withOpacity(0.3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: isLoadingQuestions
                        ? const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Text(
                          'AI đang tạo câu hỏi...',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                        : const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.play_arrow_rounded,
                          size: 28,
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Bắt đầu làm bài',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuizScreen() {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          'Câu hỏi AI - Lớp $selectedGrade',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.indigo.shade600,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: backToGradeSelection,
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
              '${currentQuestionIndex + 1}/${currentQuestions.length}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: currentQuestions.isEmpty
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
                          color: Colors.indigo.shade600,
                        ),
                      ),
                      Text(
                        'Điểm: $score/${currentQuestions.length}',
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
                    value: (currentQuestionIndex + 1) / currentQuestions.length,
                    backgroundColor: Colors.grey.shade300,
                    valueColor:
                    AlwaysStoppedAnimation<Color>(Colors.indigo.shade600),
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
                currentQuestions[currentQuestionIndex]['content'] ?? 'Đang tải câu hỏi...',
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
                      onTap: () => selectAnswer(option),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: getAnswerColor(option),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: getAnswerBorderColor(option),
                            width: 2,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: getAnswerBorderColor(option),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                getAnswerIcon(option),
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
                                color: getAnswerBorderColor(option),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                currentQuestions[currentQuestionIndex][option] ?? '',
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
                  onPressed: selectedAnswer != null ? checkAnswer : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo.shade600,
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
                  onPressed: nextQuestion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade600,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    currentQuestionIndex < currentQuestions.length - 1
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
  }

  Widget _buildResultScreen() {
    double percentage = (score / currentQuestions.length) * 100;
    String resultMessage;
    Color resultColor;
    IconData resultIcon;

    if (percentage >= 80) {
      resultMessage = 'Xuất sắc!';
      resultColor = Colors.green;
      resultIcon = Icons.star;
    } else if (percentage >= 60) {
      resultMessage = 'Tốt!';
      resultColor = Colors.blue;
      resultIcon = Icons.thumb_up;
    } else if (percentage >= 40) {
      resultMessage = 'Khá!';
      resultColor = Colors.orange;
      resultIcon = Icons.sentiment_satisfied;
    } else {
      resultMessage = 'Cần cố gắng thêm!';
      resultColor = Colors.red;
      resultIcon = Icons.sentiment_dissatisfied;
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          'Kết quả - Lớp $selectedGrade',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.indigo.shade600,
        foregroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: resultColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  resultIcon,
                  size: 80,
                  color: resultColor,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                resultMessage,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: resultColor,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Bạn đã trả lời đúng',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '$score',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: resultColor,
                      ),
                    ),
                    TextSpan(
                      text: '/${currentQuestions.length}',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${percentage.toStringAsFixed(0)}% chính xác',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 48),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: backToGradeSelection,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.indigo.shade600,
                        side: BorderSide(color: Colors.indigo.shade600),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Tạo bài mới',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: resetQuiz,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo.shade600,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Làm lại',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}