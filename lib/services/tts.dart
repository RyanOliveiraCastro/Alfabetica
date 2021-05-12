import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Tts {
  final FlutterTts flutterTts = FlutterTts();

  Future falar(String texto) async{
    await flutterTts.setLanguage("pt-BR");
    await flutterTts.setPitch(1.0);
    var result = await flutterTts.speak(texto);

    debugPrint(texto);
  }
}
