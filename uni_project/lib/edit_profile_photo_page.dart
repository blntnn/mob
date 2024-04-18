import 'package:flutter/material.dart';
import 'dart:io';

class EditProfilePhotoPage extends StatelessWidget {
  final String imagePath;

  const EditProfilePhotoPage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile - Resize Photo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.file(
              File(imagePath),
              height: 300,
              width: 300,
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate back to profile page with cropped image
              },
              child: const Text('Use That Image'),
            ),
          ],
        ),
      ),
    );
  }
}
