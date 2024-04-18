import 'dart:math';

import 'package:flutter/material.dart';

class MainAnimalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AnimalExercise()),
                );
              },
              child: Text('Упражнение - угадай животное'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WordExercise()),
                );
              },
              child: Text('Упражнение - выбери правильный вариант'),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimalExercise extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise - animals'),
      ),
      body: AnimalExerciseScreen(),
    );
  }
}

class AnimalExerciseScreen extends StatefulWidget {
  @override
  _AnimalExerciseScreenState createState() => _AnimalExerciseScreenState();
}

class _AnimalExerciseScreenState extends State<AnimalExerciseScreen> {
  int score = 0;
  int consecutiveSuccess = 0;
  String answer = '';

  void _incrementScore() {
    setState(() {
      score++;
      consecutiveSuccess++;
    });
  }

  void _resetConsecutiveSuccess() {
    setState(() {
      consecutiveSuccess = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Animal Exercise'),
            SizedBox(height: 20),
            // Placeholder for displaying random animal image
            Image.asset('assets/random_animal_image.jpg',
                width: 200, height: 200),
            SizedBox(height: 20),
            // Placeholder for text input
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                onChanged: (String? value) {
                  answer = value ?? '';
                },
                decoration: InputDecoration(
                  labelText: 'Enter animal name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Placeholder logic for checking user input// Replace this with actual user input
                String recognitionResult =
                    'Жираф'; // Replace this with actual recognition result from the service

                if (answer.toLowerCase() == recognitionResult.toLowerCase()) {
                  print(answer);
                  // If input matches recognition result, navigate to success screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AnimalSuccessScreen()),
                  );
                } else {
                  // If input doesn't match recognition result, navigate to error screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AnimalErrorScreen()),
                  );
                }
              },
              child: Text('Check'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Placeholder logic for generating and displaying new random animal image
                // You can implement this logic based on your requirements
                // For example, you can update the image asset path with a new random image
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

class WordExercise extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise - choose the correct word'),
      ),
      body: WordExerciseScreen(),
    );
  }
}

class WordExerciseScreen extends StatefulWidget {
  @override
  _WordExerciseScreenState createState() => _WordExerciseScreenState();
}

class _WordExerciseScreenState extends State<WordExerciseScreen> {
  int score = 0;
  int consecutiveSuccess = 0;

  List<String> words = [
    'apple',
    'banana',
    'cat',
    'dog',
    'elephant',
    'fish',
    'giraffe',
    'horse',
    'iguana',
    'jaguar',
    'koala',
    'lion',
    'monkey',
    'newt',
    'ostrich',
    'panda',
    'quail',
    'rabbit',
    'sheep',
    'tiger',
    'umbrellabird',
    'vulture',
    'whale',
    'xenops',
    'yak',
    'zebra',
  ];

  List<String> translations = [
    'яблоко',
    'банан',
    'кот',
    'собака',
    'слон',
    'рыба',
    'жираф',
    'лошадь',
    'игуана',
    'ягуар',
    'коала',
    'лев',
    'обезьяна',
    'тритон',
    'страус',
    'панда',
    'куропатка',
    'кролик',
    'овца',
    'тигр',
    'тукан',
    'стервятник',
    'кит',
    'ксенопс',
    'як',
    'зебра',
  ];

  String currentWord = '';
  List<String> options = [];

  @override
  void initState() {
    super.initState();
    _generateRandomWord();
  }

  void _generateRandomWord() {
    // Choose a random word from the list
    int index = Random().nextInt(words.length);
    currentWord = words[index];

    // Generate options by shuffling translations and choosing 3 random ones
    options = translations.toList()..shuffle();
    options = options.sublist(0, 3);

    // Add the correct translation to options
    options.add(translations[index]);
    options.shuffle();
  }

  void _checkAnswer(String selectedOption) {
    if (selectedOption == translations[words.indexOf(currentWord)]) {
      _incrementScore();
      _generateRandomWord();
    } else {
      _resetConsecutiveSuccess();
    }
  }

  void _incrementScore() {
    setState(() {
      score++;
      consecutiveSuccess++;
    });
  }

  void _resetConsecutiveSuccess() {
    setState(() {
      consecutiveSuccess = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Word Exercise'),
          SizedBox(height: 20),
          Text(
            currentWord,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Column(
            children: options.map((option) {
              return ElevatedButton(
                onPressed: () {
                  _checkAnswer(option);
                },
                child: Text(option),
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          Text('Score: $score'),
        ],
      ),
    );
  }
}

class AnimalSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise - animals - success'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Congratulations! You guessed the animal correctly!'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add logic to navigate back to the main screen
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: Text('Back to Main Screen'),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimalErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise - animals - error'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Sorry, the animal name you entered is incorrect.'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add logic to navigate back to the animal exercise screen
                Navigator.pop(context);
              },
              child: Text('Try Again'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add logic to navigate back to the main screen
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: Text('Back to Main Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
