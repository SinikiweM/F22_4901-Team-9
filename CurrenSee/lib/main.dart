import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'camera_screen.dart';
import 'package:alan_voice/alan_voice.dart';
import 'drawer.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  AlanVoice.addButton(
      "49a3a5bcf9d0f24af51f564db6394bed2e956eca572e1d8b807a3e2338fdd0dc/stage",
      buttonAlign: AlanVoice.BUTTON_ALIGN_LEFT);

  AlanVoice.onCommand.add((command) async {
    if (command.data['command'] == 'Open_Drawer') {
      // Opens drawer

    }

    if (command.data['command'] == 'Close_Drawer') {
      // Opens drawer

    }
    if (command.data['command'] == 'Vibrate') {
      // Vibrate
      HapticFeedback.heavyImpact();
    }
    if (command.data['command'] == 'Test') {
      // Vibrate
      HapticFeedback.heavyImpact();
    }

    // Debugs the output to the console

    debugPrint("got new command ${command}");
    debugPrint("got new command ${command.data['command']}");
  });

  runApp(
    MaterialApp(
      theme: ThemeData(),
      home: CameraScreen(
        // Pass the appropriate camera to the CameraScreen widget.
        camera: firstCamera,
      ),
    ),
  );
}
