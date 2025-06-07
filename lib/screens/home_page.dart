import 'package:flutter/material.dart';
import 'package:myapp/providers/quiz_provider.dart';
import 'package:myapp/screens/quiz_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Korean Quiz App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Character image in a fixed size container
            SizedBox(
              height: 150,
              width: 150, // 너비를 고정하여 레이아웃 안정성 확보
              child: Image.asset(
                'assets/images/character_normal.png',
                fit: BoxFit.contain, // 비율을 유지하며 컨테이너에 맞춤
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Hello! 한국어 공부하러 왔구나?',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                await Provider.of<QuizProvider>(context, listen: false).loadQuizzes();
                if (context.mounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const QuizPage()),
                  );
                }
              },
              child: const Text('Start Quiz (Beginner)'),
            ),
          ],
        ),
      ),
    );
  }
}
