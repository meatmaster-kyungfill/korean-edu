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
  String get characterMessage => _characterMessage;
  String get characterImage => _characterImage;
  bool get isAnswered => _isAnswered;
  Quiz? get currentQuestion => _quizzes.isNotEmpty ? _quizzes[_currentQuestionIndex] : null;

  Future<void> loadQuizzes() async {
    final String response = await rootBundle.loadString('assets/data/quiz_data.json');
    final List<dynamic> data = json.decode(response);
    _quizzes = data.map((json) => Quiz.fromJson(json)).toList();
    reset();
  }

  Future<bool> answerQuestion(int selectedIndex) async {
    if (_isAnswered) return false;

    _isAnswered = true;
    if (selectedIndex == currentQuestion!.answerIndex) {
      _score++;
      _characterMessage = "That's right! You're amazing!";
      _characterImage = 'assets/images/character_happy.png';
    } else {
      _characterMessage = "Oh, not this one. Don't worry!";
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
