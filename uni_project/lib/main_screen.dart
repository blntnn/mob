import 'package:flutter/material.dart';
import 'package:uni_project/animals.dart';
import 'package:uni_project/game.dart';
import 'package:uni_project/main.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Главный экран'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          UserHeader(),
          Leaderboard(),
          ExerciseGrid(),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainAnimalScreen(),
                  ),
                );
              },
              child: Text('Игра с животными')),
          ElevatedButton(
              onPressed: () {
                Game game = Game();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ExerciseScreen(
                        word: 'time', transcription: 'taim'),
                  ),
                );
              },
              child: Text('Игра и аудирование')),
        ],
      ),
    );
  }
}
