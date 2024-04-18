import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class Game {
  late String _roomId;
  bool _gameStarted = false;
  Timer? _searchTimer;
  Timer? _gameTimer;
  int _player1Score = 0;
  int _player2Score = 0;
  int _computerScore = 0;

  void startGame() {
    _gameStarted = true;
    _createRoom();
    _startSearchTimer();
  }

  void _createRoom() {
    _roomId = generateRoomId();
    print('Room created. ID: $_roomId');
    // Здесь должна быть логика добавления игрока в комнату
    // Например, отправка запроса на сервер для создания комнаты и добавления игрока
  }

  String generateRoomId() {
    final random = Random();
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final roomId =
        List.generate(6, (index) => chars[random.nextInt(chars.length)]).join();
    return roomId;
  }

  void _startSearchTimer() {
    const searchDuration = Duration(seconds: 10);
    _searchTimer = Timer(searchDuration, () {
      if (!_gameStarted) return;
      if (_player2Score == 0) {
        _playWithComputer();
      }
    });
  }

  void _playWithComputer() {
    _showWordsAndOptionsToPlayers();
    int computerAnswer = Random().nextInt(3) + 1;
    _checkAnswer(computerAnswer);
  }

  void _startGameTimer() {
    const gameDuration = Duration(minutes: 2); // Пример: игра длится 2 минуты
    _gameTimer = Timer(gameDuration, () {
      _gameOver();
    });
  }

  void _stopGameTimer() {
    _gameTimer?.cancel(); // Остановить таймер, если он активен
  }

  void _showWordsAndOptionsToPlayers() {
    // Слова и варианты ответов
    String word = "Apple";
    List<String> options = ["A", "B", "C"];

    // Показываем слово и варианты ответов игрокам
    print("Word: $word");
    print("Options:");
    for (int i = 0; i < options.length; i++) {
      print("${i + 1}. ${options[i]}");
    }
  }

  void _checkAnswer(int selectedOption) {
    // Предположим, что правильный ответ находится под индексом 1 (нумерация с 1)
    int correctOption = 1;

    // Проверяем ответ игрока
    if (selectedOption == correctOption) {
      print("Correct answer!");
      // Увеличиваем счет игрока
      _increasePlayerScore();
    } else {
      print("Wrong answer!");
      // Сбрасываем счет игрока (если это требуется в вашей логике)
      _resetPlayerScore();
    }
  }

  void _increasePlayerScore() {
    // Увеличиваем счет игрока
    // Например, для игрока 1:
    _player1Score++;
  }

  void _resetPlayerScore() {
    // Сбрасываем счет игрока
    // Например, для игрока 1:
    _player1Score = 0;
  }

  void _showWidget() {
    WidgetsFlutterBinding.ensureInitialized();

    // Пример виджета, который может отобразить текущую позицию в рейтинге
    Widget ratingWidget = Container(
      alignment: Alignment.center,
      child: Text(
        'Your rating: 5',
        style: TextStyle(fontSize: 20),
      ),
    );

    // Пример виджета призыва к действию, если пользователь не прошел авторизацию
    Widget actionPromptWidget = Container(
      alignment: Alignment.center,
      child: Text(
        'Please login to view your rating',
        style: TextStyle(fontSize: 20),
      ),
    );

    // Проверяем, прошел ли пользователь авторизацию
    bool isAuthenticated =
        false; // Предположим, что пользователь не авторизован

    // Отображаем виджет в зависимости от статуса авторизации
    Widget homeWidget = isAuthenticated ? ratingWidget : actionPromptWidget;

    runApp(MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Home Screen'),
        ),
        body: homeWidget,
      ),
    ));
  }

  void _showExerciseScreen() {
    // Логика отображения экрана упражнения
  }

  // void _recordAndRecognizeSpeech() async {
  //   SpeechRecognition _speech = SpeechRecognition();
  //   bool _isAvailable = await _speech.initialize(
  //     onStatus: (status) {
  //       print('Speech recognition status: $status');
  //     },
  //     onError: (errorNotification) {
  //       print('Speech recognition error: $errorNotification');
  //     },
  //   );
  //
  //   if (_isAvailable) {
  //     // Начинаем запись речи
  //     _speech.listen(
  //       onResult: (result) {
  //         print('Recognized speech: $result');
  //         // Здесь можно выполнить сравнение распознанной речи с ожидаемой и выполнить необходимую логику
  //       },
  //       listenFor: Duration(
  //           seconds: 10), // Пример: ограничение на время записи 10 секунд
  //     );
  //   } else {
  //     print('Speech recognition not available');
  //   }
  // }

  void _showNextWord(_currentWordIndex) {
    // Предположим, что у вас есть список слов и их транскрипций
    List<String> words = ['Apple', 'Banana', 'Orange'];
    List<String> transcriptions = ['/ˈæp.əl/', '/bəˈnænə/', '/ˈɔːrɪndʒ/'];

    // Предположим, что индекс текущего слова хранится в переменной _currentWordIndex
    // Если _currentWordIndex еще не был инициализирован, начнем с первого слова
    if (_currentWordIndex == null) {
      _currentWordIndex = 0;
    } else {
      // Переходим к следующему слову
      _currentWordIndex = (_currentWordIndex! + 1) % words.length;
    }

    // Отображаем следующее слово и его транскрипцию
    String nextWord = words[_currentWordIndex!];
    String nextTranscription = transcriptions[_currentWordIndex!];
    print('Next word: $nextWord');
    print('Next transcription: $nextTranscription');

    // Здесь может быть логика обновления интерфейса с новым словом и транскрипцией
  }

  void backButtonPressed() {
    // Логика обработки нажатия кнопки "назад"
  }

  void _gameOver() {
    _gameStarted = false;

    // Остановить таймеры, если они активны
    _searchTimer?.cancel();
    _gameTimer?.cancel();

    // Определить победителя
    String winner;
    if (_player1Score > _player2Score && _player1Score > _computerScore) {
      winner = 'Player 1';
    } else if (_player2Score > _player1Score &&
        _player2Score > _computerScore) {
      winner = 'Player 2';
    } else {
      winner = 'Computer';
    }

    // Вывести результаты игры
    print('Game over! Winner: $winner');
  }
}

void showExerciseScreen() {
  WidgetsFlutterBinding.ensureInitialized();

  // Предположим, что слово и транскрипция уже получены
  String word = 'Apple';
  String transcription = '/ˈæp.əl/';

  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Exercise Screen'),
      ),
      body: ExerciseScreen(word: word, transcription: transcription),
    ),
  ));
}

class ExerciseScreen extends StatelessWidget {
  final String word;
  final String transcription;

  const ExerciseScreen(
      {Key? key, required this.word, required this.transcription})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Word: $word',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(height: 20),
          Text(
            'Transcription: $transcription',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Обработка нажатия кнопки "Check my speech"
              //_recordAndRecognizeSpeech();
            },
            child: Text('Check my speech'),
          ),
        ],
      ),
    );
  }
}

// void _recordAndRecognizeSpeech() async {
//   stt.SpeechToText speech = stt.SpeechToText();
//
//   bool available = await speech.initialize();
//   if (available) {
//     // Начинаем запись речи
//     speech.listen(
//       onResult: (stt.SpeechRecognitionResult result) {
//         // Обрабатываем результат распознавания речи
//         String recognizedWords = result.recognizedWords;
//         // Здесь можно выполнить сравнение распознанных слов с ожидаемыми
//         print('Recognized words: $recognizedWords');
//         // Здесь может быть логика сравнения слов с ожидаемым и вывод результата пользователю
//       },
//     );
//   } else {
//     // Распознавание речи недоступно, выводим сообщение об ошибке
//     print('Speech recognition not available');
//   }
//}
