import 'dart:io';

import 'package:calorie_rush_project/view/taken_images.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';

class FourthTab extends StatefulWidget {
  @override
  _FourthTabState createState() => _FourthTabState();
}

class _FourthTabState extends State<FourthTab> {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  int direction = 0;
  File? _image;
  List<File> _takenImages = [];

  _FourthTabState() {
    initializeCamera(direction);
  }

  Future<void> initializeCamera(int direction) async {
    _cameras = await availableCameras();
    _cameraController = CameraController(
      _cameras![0],
      ResolutionPreset.high,
      enableAudio: false,
    );
    await _cameraController?.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((error) {
      print(error);
    });
  }

  void takePicture() async {
    if (_cameraController != null &&
        !_cameraController!.value.isTakingPicture) {
      XFile image = await _cameraController!.takePicture();
      setState(() {
        _image = File(image.path);
        _takenImages.add(_image!);
      });
    }
  }

  void pickImageFromGallery() async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
        _takenImages.add(_image!);
      });
    }
  }

  void showTakenImages() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TakenImagesScreen(takenImages: _takenImages),
      ),
    );
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraController!.value.isInitialized) {
      return Scaffold(
        body: Stack(
          fit: StackFit.expand, // Ensure the Stack fills the available space
          children: [
            CameraPreview(_cameraController!),
            GestureDetector(
              onTap: () {
                setState(() {
                  direction = direction == 0 ? 1 : 0;
                  initializeCamera(direction);
                });
              },
              child:
                  button(Icons.flip_camera_ios_outlined, Alignment.bottomLeft),
            ),
            GestureDetector(
              onTap: () {
                _cameraController!.takePicture().then((XFile? file) {
                  if (mounted) {
                    if (file != null) {
                      print("Picture saved to ${file.path}");
                      setState(() {
                        _image = File(file.path);
                        _takenImages.add(_image!);
                      });
                    }
                  }
                });
              },
              child: button(Icons.camera_alt_outlined, Alignment.bottomCenter),
            ),
            GestureDetector(
              onTap: showTakenImages, // Show taken images
              child: button(Icons.image_outlined, Alignment.bottomRight),
            ),
          ],
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget button(IconData icon, Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.only(
          left: 20,
          bottom: 20,
        ),
        height: 50,
        width: 50,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(2, 2),
              blurRadius: 10,
            ),
          ],
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}
