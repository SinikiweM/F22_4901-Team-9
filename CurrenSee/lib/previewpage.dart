import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class PreviewPage extends StatelessWidget {
  const PreviewPage({Key? key, required this.picture}) : super(key: key);

  final XFile picture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Image.file(File(picture.path)),
          const Center(
              child: Text(
                "placeholder",//picture.name
                style: TextStyle(
                  color: Colors.white,
          ),))
        ]),
      ),
      backgroundColor: Colors.black,
    );
  }
}