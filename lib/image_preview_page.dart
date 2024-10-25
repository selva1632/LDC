import 'dart:typed_data';

import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:ldc_app/classifier.dart';
import 'package:ldc_app/result_page.dart';

class ImagePreviewPage extends StatelessWidget {
  final Uint8List imgData;
  final Classifier _classifier = Classifier(numThreads: 1);
  ImagePreviewPage(this.imgData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Preview'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: Image.memory(imgData),
            ),
            IconButton(
              onPressed: () async {
                img.Image? imageInput = img.decodeImage(imgData);
                var pred = _classifier.predict(imageInput!);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ResultPage(imgData, pred.label, pred.score)));
              },
              icon: const Icon(Icons.check_circle_outline),
              iconSize: 48,
            ),
          ],
        ),
      ),
    );
  }
}
