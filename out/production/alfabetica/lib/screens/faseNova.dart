import 'package:Alfabetica/Database.dart';
import 'package:Alfabetica/model/ItemFase.dart';
import 'package:Alfabetica/model/ItemModel.dart';
import 'package:Alfabetica/screens/menu_secundario.dart';
import 'package:Alfabetica/services/imageLabels.dart';
import 'package:Alfabetica/services/tts.dart';
import 'package:Alfabetica/widgets/BotaoElevado.dart';
import 'package:Alfabetica/widgets/LetterShuffle.dart';
import 'package:Alfabetica/widgets/star.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';

class FaseNova extends StatefulWidget {
  final ItemFase itemFase;

  FaseNova({this.itemFase});

  @override
  _FaseNovaState createState() => _FaseNovaState(itemFase: itemFase);
}

class _FaseNovaState extends State<FaseNova> with TickerProviderStateMixin {
  ItemFase itemFase;

  _FaseNovaState({this.itemFase});

  List<ItemModel> listLetrasShuffle = [];
  List<ItemModel> listLetras = [];
  bool gameOver;
  bool menuPopup = false;
  bool menuPopupFim = false;
  bool novaFase = true;

  @override
  void initState() {
    super.initState();
    initGame();
  }

  initGame() {
    menuPopup = false;
    menuPopupFim = false;
    novaFase = false;
    gameOver = false;
    listLetrasShuffle.clear();
    listLetras.clear();
    for (int i = 0; i < itemFase.name.length; i++) {
      listLetrasShuffle.add(ItemModel(
          icon: IconData(itemFase.name.codeUnitAt(i), fontFamily: 'Roboto'),
          name: itemFase.name[i],
          value: itemFase.name[i]));
    }
    listLetrasShuffle.shuffle();

    for (int i = 0; i < itemFase.name.length; i++) {
      listLetras.add(ItemModel(name: itemFase.name[i], value: ""));
    }
  }

  unlockFase() async {
    ItemFase itemFaseBanco = await DBProvider.db.getFase(itemFase.id + 1);
    itemFaseBanco.lock = false;
    DBProvider.db.updateFase(itemFaseBanco);
  }

  Future<ItemFase> proximafase() async {
    ItemFase itemFaseBanco = await DBProvider.db.getFase(itemFase.id + 1);
    return itemFaseBanco;
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
      if (listLetras[i].accepting == false) {
        palavraEscrita += listLetras[i].value;
      }
    }
    falar(palavraEscrita);
  }

  verificaPopup(double heightScreen) {
    if (menuPopupFim == true || menuPopup == true) {
      return ((heightScreen / 2) - 105);
    } else {
      return (heightScreen + 300);
    }
  }

  verificaPopupOpacity() {
    if (menuPopupFim == true || menuPopup == true) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageLabel = ImageLabels();
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;

    if (listLetrasShuffle.length == 0 && novaFase == false) {
      gameOver = true;
      unlockFase();
      menuPopupFim = true;
      falar(itemFase.name);
      novaFase = true;
      setState(() {});
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Stack(children: [
          Row(
            children: <Widget>[
              //Letter Shuffle Lado Esquerdo
              Container(
                color: Colors.lightBlueAccent,
                constraints: BoxConstraints.tightForFinite(
                  width: widthScreen / 5,
                  height: heightScreen,
                ),
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Stack(children: <Widget>[
                      LetterShuffle(
                        palavra: listLetrasShuffle,
                      ),
                    ]),
                  ],
                ),
              ),
              //Imagem / Caixas Lado Direito
              Column(
                children: [
                  //Icones Imagens Cnfigurações
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 4),
                      color: Colors.lightBlueAccent,
                    ),
                    width: ((widthScreen / 5) * 4),
                    height: ((heightScreen / 4) * 3),
                    child: Row(
                      children: <Widget>[
                        //Icones
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent,
                          ),
                          child: Column(
                            verticalDirection: VerticalDirection.up,
                            children: <Widget>[
                              //Camera
                              BotaoElevado(
                                margin: EdgeInsets.fromLTRB(5, 5, 5, 10),
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
                            ],
                          ),
                        ),
                        //Imagem
                        Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            constraints: BoxConstraints(
                              minWidth: 0.0,
                              maxWidth: ((widthScreen / 5) * 3) - 22,
                              minHeight: 0.0,
                              maxHeight: ((heightScreen / 4) * 3),
                            ),
                            alignment: Alignment.center,
                            child: OutlineButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.solid,
                                  color: Colors.transparent),
                              highlightedBorderColor: Colors.transparent,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Image.asset(
                                  itemFase.url,
                                  height: ((heightScreen / 4) * 3),
                                  width: ((widthScreen / 5) * 4),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              onPressed: () async {
                                falar(itemFase.name);
                              },
                            )),

                        //Configurações
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent,
                          ),
                          child: Column(
                            verticalDirection: VerticalDirection.down,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              // BOTAO ENGRENAGEM
                              BotaoElevado(
                                margin: EdgeInsets.fromLTRB(5, 10, 5, 5),
                                padding: 00.00,
                                size: Size(65, 50),
                                boderSide:
                                    BorderSide(color: Colors.black, width: 2),
                                borderRadius: BorderRadius.circular(5),
                                backgroundColor: Colors.grey[200],
                                foregroundColor: Colors.black,
                                iconData: Icons.settings,
                                function: () async {
                                  setState(() {
                                    menuPopup = true;
                                  });
                                },
                              ),
                              //BOTAO VOLUME
                              BotaoElevado(
                                margin: EdgeInsets.fromLTRB(5, 5, 5, 10),
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
                      ],
                    ),
                  ),
                  //Caixa de Letras
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                    width: ((widthScreen / 5) * 4),
                    height: ((heightScreen / 4)),
                    child: Row(children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                        ),
                        constraints: BoxConstraints(
                            minWidth: 0.0,
                            maxWidth: widthScreen * 0.78,
                            minHeight: 0.0,
                            maxHeight: (heightScreen / 4)),
                        alignment: Alignment.center,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                children: listLetras.map((item) {
                                  return DragTarget<ItemModel>(
                                    onAccept: (ItemModel receivedItem) {
                                      if (item.name == receivedItem.name) {
                                        setState(() {
                                          listLetrasShuffle
                                              .remove(receivedItem);
                                          item.value = receivedItem.value;
                                          item.accepting = false;
                                          tocarSomLetra();
                                        });
                                      } else {
                                        setState(() {
                                          item.accepting = false;
                                        });
                                      }
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
                                              width: 2.5),
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
                    ]),
                  )
                ],
              ),
            ],
          ),
          poupupMenu(heightScreen, widthScreen),
          estrelas(heightScreen, widthScreen, 0, 1100),
          estrelas(heightScreen, widthScreen, 104, 800),
          estrelas(heightScreen, widthScreen, 204, 500),
        ]),
      ),
    );
  }

  Widget poupupMenu(heightScreen, widthScreen) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 0),
      top: verificaPopup(heightScreen),
      right: (widthScreen / 2) - 200,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: verificaPopupOpacity() ? 1.00 : 0.00,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 4),
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
          ),
          constraints: BoxConstraints.tightForFinite(
            height: 250,
            width: 400,
          ),
          alignment: Alignment.center,
          child: Stack(children: <Widget>[
            Column(
              children: <Widget>[
                Flexible(
                  flex: 3,
                  //IMAGEM
                  child: Container(
                      width: 400,
                      padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                      ),
                      child: OutlineButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        borderSide: BorderSide(
                            width: 0,
                            style: BorderStyle.solid,
                            color: Colors.transparent),
                        highlightedBorderColor: Colors.transparent,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.asset(
                            itemFase.url,
                            fit: BoxFit.cover,
                          ),
                        ),
                        onPressed: () async {
                          falar(itemFase.name);
                        },
                      )),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5)),
                      color: Colors.blueAccent,
                    ),
                    height: 60,
                    width: 400,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        //BOTAO RENEW
                        BotaoElevado(
                          margin: EdgeInsets.fromLTRB(5, 5, 0, 5),
                          padding: 0.00,
                          size: Size(65, 50),
                          boderSide: BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(5),
                          backgroundColor: Colors.yellow,
                          foregroundColor: Colors.black,
                          iconData: Icons.autorenew,
                          function: () async {
                            setState(() {
                              initGame();
                              menuPopupFim = false;
                            });
                          },
                        ),
                        // BOTAO MENU
                        BotaoElevado(
                          margin: EdgeInsets.fromLTRB(5, 5, 0, 5),
                          padding: 0.00,
                          size: Size(65, 50),
                          boderSide: BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(5),
                          backgroundColor: Colors.yellow,
                          foregroundColor: Colors.black,
                          iconData: Icons.menu,
                          function: () async {
                            setState(() async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        MenuSecundario(local: itemFase.local),
                                  ));
                            });
                          },
                        ),

                        // BOTAO PROXIMA FASE
                        if (menuPopupFim == true)
                          BotaoElevado(
                            margin: EdgeInsets.fromLTRB(5, 5, 0, 5),
                            padding: 0.00,
                            size: Size(65, 50),
                            boderSide:
                                BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(5),
                            backgroundColor: Colors.yellow,
                            foregroundColor: Colors.black,
                            iconData: Icons.arrow_forward,
                            function: () async {
                              ItemFase proximaFase = await proximafase();
                              setState(() async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        FaseNova(itemFase: proximaFase),
                                  ),
                                );
                              });
                            },
                          ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            if (menuPopupFim == false)
              Positioned(
                top: 3,
                right: 3,
                child: BotaoElevado(
                  padding: 0.00,
                  size: Size(45, 45),
                  boderSide: BorderSide(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(5.00),
                  backgroundColor: Colors.yellow,
                  foregroundColor: Colors.black,
                  iconData: Icons.close,
                  function: () async {
                    setState(() {
                      menuPopup = false;
                    });
                  },
                ),
              ),
          ]),
        ),
      ),
    );
  }

  Widget estrelas(heightScreen, widthScreen, left, duration) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: duration),
      top: menuPopupFim ? ((heightScreen / 2) - 160) : -300,
      right: (widthScreen / 2) - 156 + left,
      child: Stack(
        children: [
          Star(size: 104, color: Colors.black),
          Star(size: 90, color: Colors.yellow),
        ],
      ),
    );
  }

  Future verificaImagem(ImageLabels imageLabel) async {
    String imageLabels = await imageLabel.openImage();
    setState(() {
      for (int i = 0; i < itemFase.name.length; i++) {
        if (itemFase.name[i] == imageLabels[i]) {
          listLetras[i].name = imageLabels[i];
          listLetras[i].value = imageLabels[i];
          listLetrasShuffle.removeAt(listLetrasShuffle
              .indexWhere((element) => element.name == imageLabels[i]));
        }
      }
    });
  }
}
