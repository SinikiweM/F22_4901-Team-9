import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'drawer.dart';
import 'previewpage.dart';

// A screen that allows users to see the cameraPreview
class CameraScreen extends StatefulWidget {
  const CameraScreen({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  CameraScreenState createState() => CameraScreenState();
}

class CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;

  //late CameraImage latestImage; **Will be used to keep track of latest image from the stream
  //String result = ""; **what txt2speech will read out.
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.max,
    );
    // Next, initialize the controller. This returns a Future.

    _initializeControllerFuture = _controller.initialize().then((_) {
      _controller.setFlashMode(FlashMode.auto);

      /*_controller.startImageStream((CameraImage image) {
        //This method captures random frames and saves the latest one
        //it allows for images to be automatically captured and sent to model
        //Images may have to be rescaled or modified
        //print(DateTime.now().millisecondsSinceEpoch); *THIS WAS FOR TESTING FRAME RATE*
      });*/
      //This is no longer used because we take a picture instead of streaming directly from feed.
    });
  }

  Future takePicture() async {
    if (!_controller.value.isInitialized) {
      return null;
    }
    if (_controller.value.isTakingPicture) {
      return null;
    }
    try {
      XFile picture = await _controller.takePicture(); //THIS IS THE PICTURE TAKEN FROM THE SCREEN
      //IT MUST BE PASSED TO THE MODEL HERE.

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PreviewPage(
              picture: picture,
          )));
    } on CameraException catch (e) {
      debugPrint('Error occured while taking picture: $e');
      return null;
    }
  }

  String noteIdentity(CameraImage latestImage) {
    String result = "";

    return result;
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          //title: const Text(),
          backgroundColor: Colors.black,
        ),

        drawer: DrawerWidget(),

// You must wait until the controller is initialized before displaying the
        // camera preview. Use a FutureBuilder to display a loading spinner until the
        // controller has finished initializing.
        body: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If the Future is complete, display the preview.
              return CameraPreview(_controller);
            } else {
              // Otherwise, display a loading indicator.
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: takePicture,
          tooltip: 'Take Picture',
          child: const Icon(Icons.camera_alt),
        ),

    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        backgroundColor: Colors.black,
      );
  Widget buildDrawer() => const DrawerWidget();
}
