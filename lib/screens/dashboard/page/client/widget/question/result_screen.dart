import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  final int score ;
  final int noQuestionsByGrade ;
  final String selectedGrade ;

  final Function() backToGradeSelection ;
  final Function() resetQuiz ;

  final Function() receivePoint ;

  const ResultScreen({super.key, required this.score, required this.noQuestionsByGrade, required this.selectedGrade, required this.backToGradeSelection, required this.resetQuiz, required this.receivePoint});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {

  @override
  Widget build(BuildContext context) {
    double percentage = (widget.score / widget.noQuestionsByGrade) * 100;
    String resultMessage;
    Color resultColor;
    IconData resultIcon;

    if (percentage >= 80) {
      resultMessage = 'Xuất sắc!';
      resultColor = Colors.green;
      resultIcon = Icons.star_rounded;
    } else if (percentage >= 60) {
      resultMessage = 'Tốt!';
      resultColor = Colors.blue;
      resultIcon = Icons.thumb_up_rounded;
    } else if (percentage >= 40) {
      resultMessage = 'Khá!';
      resultColor = Colors.orange;
      resultIcon = Icons.sentiment_satisfied_rounded;
    } else {
      resultMessage = 'Cần cố gắng thêm!';
      resultColor = Colors.red;
      resultIcon = Icons.sentiment_dissatisfied_rounded;
    }
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          'Kết quả - Lớp ${widget.selectedGrade}',
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
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Result Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: resultColor.withOpacity(0.08),
                      spreadRadius: 0,
                      blurRadius: 30,
                      offset: const Offset(0, 12),
                    ),
                    BoxShadow(
                      color: Colors.grey.shade100,
                      spreadRadius: 2,
                      blurRadius: 0,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    TweenAnimationBuilder(
                      tween: Tween<double>(begin: 0, end: 1),
                      duration: const Duration(milliseconds: 700),
                      curve: Curves.elasticOut,
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: value,
                          child: child,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(28),
                        decoration: BoxDecoration(
                          color: resultColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: resultColor.withOpacity(0.2),
                              blurRadius: 28,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                        child: Icon(
                          resultIcon,
                          size: 72,
                          color: resultColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    Center(
                      child: Text(
                        resultMessage,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: resultColor,
                          letterSpacing: 0.5,

                        ),
                      ),
                    ) ,
                    const SizedBox(height: 16),
                    Text(
                      'Bạn đã trả lời đúng',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                      decoration: BoxDecoration(
                        color: resultColor.withOpacity(0.06),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: resultColor.withOpacity(0.15),
                          width: 1.5,
                        ),
                      ),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '${widget.score}',
                              style: TextStyle(
                                fontSize: 52,
                                fontWeight: FontWeight.w900,
                                color: resultColor,
                              ),
                            ),
                            TextSpan(
                              text: ' / ${widget.noQuestionsByGrade}',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      '${percentage.toStringAsFixed(0)}% chính xác',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 36),

              // Receive Point Button
              if (widget.score > 0) ...[
                SizedBox(
                  width: double.infinity,
                  height: 62,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      gradient: LinearGradient(
                        colors: [Colors.amber.shade400, Colors.orange.shade500],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: widget.receivePoint,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.stars_rounded,
                            size: 26,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Nhận ${widget.score * 10} VNĐ',
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],

              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 54,
                      child: OutlinedButton(
                        onPressed: widget.backToGradeSelection,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.indigo.shade600,
                          side: BorderSide(color: Colors.indigo.shade200, width: 1.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Text(
                          'Trở về',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo.shade600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: SizedBox(
                      height: 54,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          gradient: LinearGradient(
                            colors: [Colors.indigo.shade600, Colors.blue.shade500],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.indigo.withOpacity(0.25),
                              blurRadius: 14,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: widget.resetQuiz,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
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
