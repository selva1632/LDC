import 'dart:typed_data';

import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final Uint8List imgData;
  final String category;
  final double confidence;
  const ResultPage(this.imgData, this.category, this.confidence, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Result'),
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 500,
                  child: Image.memory(
                    imgData,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: Text(
                    category,
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
