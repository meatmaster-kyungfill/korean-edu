import 'package:flutter/material.dart';
import 'package:myapp/providers/quiz_provider.dart';
import 'package:myapp/screens/home_page.dart';
import 'package:provider/provider.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuizProvider>(context, listen: false);
    final score = provider.score;
    final total = provider.quizzes.length;
    String message;
    String image;

    if (score == total) {
      message = "Perfect score! Your Korean vocabulary is fantastic!";
      image = 'assets/images/character_happy.png';
    } else if (score >= total / 2) {
      message = "Good effort! Keep practicing and you'll be an expert soon!";
      image = 'assets/images/character_normal.png';
    } else {
      message = "It's okay! Every mistake is a chance to learn. Let's try again!";
      image = 'assets/images/character_sad.png';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Result'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 150,
                width: 150,
                child: Image.asset(
                  image,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'You scored $score out of $total',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  provider.reset();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                    (route) => false,
                  );
                },
                child: const Text('Back to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
