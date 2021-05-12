import 'package:Alfabetica/model/ItemModel.dart';
import 'package:flutter/material.dart';

class LetterShuffle extends StatefulWidget {
  final List<ItemModel> palavra;

  LetterShuffle({this.palavra});

  @override
  _LetterShuffleState createState() => _LetterShuffleState(palavra: palavra);
}

class _LetterShuffleState extends State<LetterShuffle> {
  List<ItemModel> palavra = [];

  _LetterShuffleState({this.palavra});

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          constraints: BoxConstraints(
            minWidth: 0.0,
            maxWidth: widthScreen / 5,
            minHeight: 0.0,
            maxHeight: heightScreen,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 4),
            color: Colors.transparent,
          ),
          child: SizedBox(
            height: heightScreen - 8,
            width: widthScreen / 5,
            child: GridView.count(
              padding: EdgeInsets.fromLTRB(5, 20, 5, 10),
              crossAxisCount: 2,
              children: palavra
                  .map(
                    (item) => Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.5),
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.yellow,
                      ),
                      margin: const EdgeInsets.all(8.0),
                      child: Draggable<ItemModel>(
                        data: item,
                        childWhenDragging: Container(
                          alignment: Alignment.center,
                          child: Text(
                            item.value,
                            style: TextStyle(
                                height: 1.2,
                                color: Colors.black,
                                fontSize: 40.0,
                                fontFamily: 'KTFRoadbrush'),
                          ),
                        ),
                        feedback: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.blue,
                          ),
                          height: 60,
                          width: 60,
                          alignment: Alignment.center,
                          child: Text(
                            item.value,
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                height: 1.2,
                                color: Colors.black,
                                fontSize: 40.0,
                                fontFamily: 'KTFRoadbrush'),
                          ),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            item.value,
                            style: TextStyle(
                                height: 1.2,
                                color: Colors.black,
                                fontSize: 40.0,
                                fontFamily: 'KTFRoadbrush'),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
