class Quiz {
  final int id;
  final String level;
  final String question;
  final List<String> options;
  final int answerIndex;
  final String explanation;

  Quiz({
    required this.id,
    required this.level,
    required this.question,
    required this.options,
    required this.answerIndex,
    required this.explanation,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'],
      level: json['level'],
      question: json['question'],
      options: List<String>.from(json['options']),
      answerIndex: json['answerIndex'],
      explanation: json['explanation'],
    );
  }
}
