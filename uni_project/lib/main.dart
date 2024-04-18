import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uni_project/main_screen.dart';

void main() {
  runApp(
    MyApp(
      themeData: ThemeMode.system == ThemeData.dark()
          ? ThemeData.dark()
          : ThemeData.light(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final ThemeData themeData;
  const MyApp({super.key, required this.themeData});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode
          .system, // Устанавливаем тему приложения в зависимости от системной темы
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const MainScreen(),
    );
  }
}

class ProfileSettings extends StatelessWidget {
  ProfileSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () {
              // Toggle theme mode
              ThemeData themeData = ThemeMode.system == ThemeData.dark
                  ? ThemeData.dark()
                  : ThemeData.light();
              // Apply theme mode
              MaterialPageRoute(
                builder: (BuildContext context) => MyApp(themeData: themeData),
              );
            },
            child: Text(Theme.of(context).brightness == Brightness.light
                ? 'Switch to Dark Mode'
                : 'Switch to Light Mode'),
          ),
          ElevatedButton(
            onPressed: () {
              // Navigate to language selection screen
            },
            child: Text('Change Language'),
          ),
          ElevatedButton(
            onPressed: () async {
              final pickedFile =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
              if (pickedFile != null) {
                // Navigate to edit profile photo screen with selected image
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          EditProfilePhotoScreen(imagePath: pickedFile.path)),
                );
              }
            },
            child: Text('Change Your Image'),
          ),
        ],
      ),
    );
  }
}

class UserHeader extends StatelessWidget {
  const UserHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: const Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/avatar.jpg'),
            radius: 30,
          ),
          SizedBox(width: 16.0),
          Text(
            'Некий скуф',
            style: TextStyle(fontSize: 20.0),
          ),
        ],
      ),
    );
  }
}

class Leaderboard extends StatelessWidget {
  const Leaderboard({super.key});

  @override
  Widget build(BuildContext context) {
    // Placeholder for leaderboard widget
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: const Text('Leaderboard'),
    );
  }
}

class ExerciseGrid extends StatelessWidget {
  const ExerciseGrid({super.key});

  @override
  Widget build(BuildContext context) {
    // Placeholder for exercise grid widget
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: const Text('Exercise Grid'),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: const ProfileBody(),
    );
  }
}

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        UserHeader(),
        ProfileSettings(),
      ],
    );
  }
}

class ThemeSettings with ChangeNotifier {
  ThemeData _themeData = ThemeData.light();

  ThemeData get themeData => _themeData;

  void toggleTheme() {
    _themeData =
        _themeData == ThemeData.light() ? ThemeData.dark() : ThemeData.light();
    notifyListeners();
  }
}

class EditProfilePhotoScreen extends StatefulWidget {
  final String imagePath;

  EditProfilePhotoScreen({required this.imagePath});

  @override
  _EditProfilePhotoScreenState createState() => _EditProfilePhotoScreenState();
}

class _EditProfilePhotoScreenState extends State<EditProfilePhotoScreen> {
  late File _croppedImage;
  late double _scale = 1.0;
  late Offset _previousOffset = Offset.zero;
  late Offset _currentOffset = Offset.zero;

  void _onScaleStart(ScaleStartDetails details) {
    _previousOffset = details.focalPoint;
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      _scale = details.scale;
      _currentOffset = details.focalPoint - _previousOffset;
    });
  }

  void _onScaleEnd(ScaleEndDetails details) {
    _previousOffset = _currentOffset;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile - Resize Photo'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              // Upload cropped image to server
              // Navigate back to profile screen
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Center(
        child: GestureDetector(
          onScaleStart: _onScaleStart,
          onScaleUpdate: _onScaleUpdate,
          onScaleEnd: _onScaleEnd,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.file(
                File(widget.imagePath),
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              Positioned(
                left: _currentOffset.dx,
                top: _currentOffset.dy,
                child: Transform.scale(
                  scale: _scale,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.7,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
