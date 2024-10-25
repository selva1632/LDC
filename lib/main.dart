import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:ldc_app/custom_theme.dart';
import 'package:ldc_app/gallery_page.dart';
import 'package:ldc_app/image_preview_page.dart';
import 'package:photo_manager/photo_manager.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late CameraController cameraController;

  @override
  void initState() {
    super.initState();
    cameraController = CameraController(cameras[0], ResolutionPreset.max);
    cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!cameraController.value.isInitialized) {
      return MaterialApp(
        theme: customTheme,
        home: const Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: Text('Loading...'),
          ),
        ),
      );
    }
    return MaterialApp(
      theme: customTheme,
      home: HomePage(cameraController: cameraController),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.cameraController,
  }) : super(key: key);

  final CameraController cameraController;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isFlashOn = false;

  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery.of(context).size;
    final scale = 1 / (widget.cameraController.value.aspectRatio * mediaSize.aspectRatio);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            ClipRect(
              clipper: _MediaSizeClipper(mediaSize),
              child: Transform.scale(
                scale: scale,
                alignment: Alignment.topCenter,
                child: CameraPreview(widget.cameraController),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(isFlashOn ? Icons.flash_on : Icons.flash_off),
                        onPressed: () {
                          // Flash Pressed
                          widget.cameraController.setFlashMode(isFlashOn ? FlashMode.off : FlashMode.torch);
                          setState(() {
                            isFlashOn = !isFlashOn;
                          });
                        },
                      ),
                      const Text(
                        'LDC',
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 4),
                      ),
                      IconButton(
                        icon: Container(),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.collections),
                        onPressed: () async {
                          // Gallery Pressed
                          final permitted = await PhotoManager.requestPermissionExtend();
                          if (permitted.isAuth) Navigator.push(context, MaterialPageRoute(builder: (context) => const GalleryPage()));
                        },
                      ),
                      IconButton(
                        iconSize: 72,
                        icon: const Icon(Icons.circle_outlined),
                        onPressed: () async {
                          // Camera Preview
                          try {
                            widget.cameraController.takePicture().then((img) => img
                                .readAsBytes()
                                .then((imgData) => Navigator.push(context, MaterialPageRoute(builder: (context) => ImagePreviewPage(imgData)))));
                          } catch (e) {
                            print(e);
                          }
                        },
                      ),
                      IconButton(
                        icon: Container(),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _MediaSizeClipper extends CustomClipper<Rect> {
  final Size mediaSize;
  const _MediaSizeClipper(this.mediaSize);
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, mediaSize.width, mediaSize.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
