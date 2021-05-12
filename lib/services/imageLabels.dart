import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageLabels {
  openImage() async {
    final String text = await processImage();
    return text;
  }

  processImage() async {
    final _picker = ImagePicker();
    final PickedFile pickedFile = await _picker.getImage(source: ImageSource.camera);

    if (pickedFile == null) {
      return "Imagem não selecionada";
    }

    final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(File(pickedFile.path));
    final TextRecognizer textRecognizer = FirebaseVision.instance.cloudTextRecognizer();
    final VisionText visionText = await textRecognizer.processImage(visionImage);
    String text = "";

    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
          text = text + ' ' + line.text;
      }
    }
    textRecognizer.close();

    debugPrint(text.trim());
    return text.trim();
  }
}
