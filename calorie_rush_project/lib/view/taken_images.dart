import 'dart:io';
import 'package:flutter/material.dart';

class TakenImagesScreen extends StatelessWidget {
  final List<File> takenImages;

  const TakenImagesScreen({Key? key, required this.takenImages})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All taken images'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: takenImages.length,
          itemBuilder: (context, index) {
            return Image.file(takenImages[index]);
          },
        ),
      ),
    );
  }
}
