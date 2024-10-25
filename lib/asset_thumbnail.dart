import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:ldc_app/image_preview_page.dart';
import 'package:photo_manager/photo_manager.dart';

class AssetThumbnail extends StatelessWidget {
  final AssetEntity asset;

  const AssetThumbnail({Key? key, required this.asset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: asset.thumbData,
      builder: (_, snapshot) {
        final bytes = snapshot.data as Uint8List?;
        if (bytes == null) return const CircularProgressIndicator();
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ImagePreviewPage(bytes)));
          },
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Image.memory(bytes, fit: BoxFit.cover),
          ),
        );
      },
    );
  }
}
