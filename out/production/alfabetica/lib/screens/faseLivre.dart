import 'package:Alfabetica/model/ItemModel.dart';
import 'package:Alfabetica/services/imageLabels.dart';
import 'package:Alfabetica/services/tts.dart';
import 'package:Alfabetica/widgets/BotaoElevado.dart';
import 'package:Alfabetica/widgets/LetterLivre.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';

class FaseLivre extends StatefulWidget {
  @override
  _FaseLivreState createState() => _FaseLivreState();
}

class _FaseLivreState extends State<FaseLivre> with TickerProviderStateMixin {
  List<ItemModel> listLetrasAlfabeto = [];
  List<ItemModel> listLetras = [];
  bool menuPopup = false;
  String alfabeto = "ABCDEFGHIJKLMNOPQRSTUVWXYZÇ";

  @override
  void initState() {
    super.initState();
    initGame();
  }

  initGame() {
    menuPopup = false;
    listLetrasAlfabeto.clear();
    listLetras.clear();
    for (int i = 0; i < alfabeto.length; i++) {
      listLetrasAlfabeto.add(ItemModel(
          icon: IconData(alfabeto.codeUnitAt(i), fontFamily: 'Roboto'),
          name: alfabeto[i],
          value: alfabeto[i]));
    }

    for (int i = 0; i < 10; i++) {
      listLetras.add(ItemModel(icon: const IconData(32, fontFamily: 'Roboto'),
          name:"",
          value: ""));
    }
  }

  falar(String palavra) {
    final tts = Tts();
    tts.falar(palavra);
  }

  tocarSomLetra() async {
    AudioCache().play('som/pop.mp3');
  }

  reproduzirPalavraEscrita() {
    String palavraEscrita = "";
    for (int i = 0; i < listLetras.length; i++) {
        palavraEscrita += listLetras[i].value;
    }
    falar(palavraEscrita);
  }

  verificaPopup(double heightScreen) {
    if (menuPopup == true) {
      return ((heightScreen / 2) - 105);
    } else {
      return (heightScreen + 300);
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageLabel = ImageLabels();
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Stack(children: [
          Row(
            children: <Widget>[
              //LETRAS ALFABETO
              Column(
                children: [
                  //letras Alfabeto
                  Container(
                    color: Colors.lightBlueAccent,
                    constraints: BoxConstraints.tightForFinite(
                      width: widthScreen,
                      height: heightScreen,
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        Stack(children: <Widget>[
                          LetterLivre(palavra: listLetrasAlfabeto),
                        ]),
                        //Icones
                        Container(
                          width: widthScreen,
                          height: 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,

                            children: <Widget>[
                              //Camera
                              BotaoElevado(
                                margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                padding: 0.00,
                                size: Size(65, 50),
                                boderSide:
                                    BorderSide(color: Colors.black, width: 2),
                                borderRadius: BorderRadius.circular(5),
                                backgroundColor: Colors.grey[200],
                                foregroundColor: Colors.black,
                                iconData: Icons.photo_camera,
                                function: () async {
                                  setState(() {
                                    verificaImagem(imageLabel);
                                  });
                                },
                              ),
                              //Reiniciar
                              BotaoElevado(
                                margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                padding: 0.00,
                                size: Size(65, 50),
                                boderSide:
                                    BorderSide(color: Colors.black, width: 2),
                                borderRadius: BorderRadius.circular(5),
                                backgroundColor: Colors.yellow,
                                foregroundColor: Colors.black,
                                iconData: Icons.autorenew,
                                function: () async {
                                  setState(() {
                                    initGame();
                                  });
                                },
                              ),
                              //BOTAO VOLUME
                              BotaoElevado(
                                margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                padding: 0.00,
                                size: Size(65, 50),
                                boderSide:
                                    BorderSide(color: Colors.black, width: 2),
                                borderRadius: BorderRadius.circular(5),
                                backgroundColor: Colors.grey[200],
                                foregroundColor: Colors.black,
                                iconData: Icons.volume_up,
                                function: () async {
                                  setState(() {
                                    reproduzirPalavraEscrita();
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        Row(children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                              color: Colors.transparent,
                            ),
                            constraints: BoxConstraints(
                                minWidth: 0.0,
                                maxWidth: widthScreen,
                                minHeight: 0.0,
                                maxHeight: (heightScreen / 4) - 6),
                            alignment: Alignment.center,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    children: listLetras.map((item) {
                                      return DragTarget<ItemModel>(
                                        onAccept: (ItemModel receivedItem) {
                                            setState(() {
                                              item.value = receivedItem.value;
                                              item.accepting = false;
                                              tocarSomLetra();
                                            });
                                        },
                                        onLeave: (receivedItem) {
                                          setState(() {
                                            item.accepting = false;
                                          });
                                        },
                                        onWillAccept: (receivedItem) {
                                          if (item.value.isNotEmpty) {
                                            return false;
                                          }
                                          setState(() {
                                            item.accepting = true;
                                          });
                                          return true;
                                        },
                                        builder:
                                            (context, acceptedItems, rejectItems) =>
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.lightBlueAccent,
                                              ),
                                              height: 50,
                                              width: 50,
                                              alignment: Alignment.center,
                                              margin: const EdgeInsets.all(2.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: item.value.isEmpty
                                                          ? Colors.black
                                                          : Colors.green[600],
                                                      width: 3),
                                                  borderRadius:
                                                  BorderRadius.circular(5.0),
                                                  color: item.value != ""
                                                      ? Colors.white
                                                      : Colors.white,
                                                ),
                                                alignment: Alignment.center,
                                                height: 50,
                                                width: 80,
                                                child: Text(
                                                  item.value,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 31.0),
                                                ),
                                              ),
                                            ),
                                      );
                                    }).toList(),
                                  ),
                                ]),
                          ),
                        ])
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }

  Future verificaImagem(ImageLabels imageLabel) async {
    String imageLabels = await imageLabel.openImage();
    setState(() {
      initGame();
      for (int i = 0; i < imageLabels.length; i++) {
          listLetras[i].name = imageLabels[i].toUpperCase();
          listLetras[i].value = imageLabels[i].toUpperCase();
      }
    });
  }
}
