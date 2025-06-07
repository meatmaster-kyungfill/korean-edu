import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/models/quiz.dart';

class QuizProvider with ChangeNotifier {
  List<Quiz> _quizzes = [];
  int _currentQuestionIndex = 0;
  int _score = 0;
  String _characterMessage = "What is this word in Korean? Choose the correct answer!";
  String _characterImage = 'assets/images/character_normal.png';
  bool _isAnswered = false;

  List<Quiz> get quizzes => _quizzes;
  int get currentQuestionIndex => _currentQuestionIndex;
  int get score => _score;
  Quiz? get currentQuestion => _quizzes.isNotEmpty ? _quizzes[_currentQuestionIndex] : null;
  String get characterMessage => _characterMessage;
  String get characterImage => _characterImage;
  bool get isAnswered => _isAnswered;

  Future<void> loadQuizzes() async {
    final String response = await rootBundle.loadString('assets/data/quiz_data.json');
    final data = await json.decode(response);
    _quizzes = (data as List).map((i) => Quiz.fromJson(i)).toList();
    reset();
    notifyListeners();
  }

  Future<bool> answerQuestion(int selectedOptionIndex) async {
    _isAnswered = true;
    if (selectedOptionIndex == currentQuestion!.answerIndex) {
      _score++;
      _characterMessage = "That's correct! Great job!";
      _characterImage = 'assets/images/character_happy.png';
    } else {
      _characterMessage = "Not quite. The correct answer was '${currentQuestion!.options[currentQuestion!.answerIndex]}'.";
      _characterImage = 'assets/images/character_sad.png';
    }
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    if (_currentQuestionIndex < _quizzes.length - 1) {
      _currentQuestionIndex++;
      _characterMessage = "What is this word in Korean? Choose the correct answer!";
      _characterImage = 'assets/images/character_normal.png';
      _isAnswered = false;
      notifyListeners();
      return false;
    } else {
      return true;
    }
  }

  void reset() {
    _currentQuestionIndex = 0;
    _score = 0;
    _characterMessage = "What is this word in Korean? Choose the correct answer!";
    _characterImage = 'assets/images/character_normal.png';
    _isAnswered = false;
    notifyListeners();
  }
}
