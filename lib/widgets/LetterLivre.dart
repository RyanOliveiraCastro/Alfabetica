import 'package:Alfabetica/model/ItemModel.dart';
import 'package:flutter/material.dart';

class LetterLivre extends StatefulWidget {
  final List<ItemModel> palavra;

  LetterLivre({this.palavra});

  @override
  _LetterLivreState createState() => _LetterLivreState(palavra: palavra);
}

class _LetterLivreState extends State<LetterLivre> {
  List<ItemModel> palavra = [];

  _LetterLivreState({this.palavra});

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
            maxWidth: widthScreen,
            minHeight: 0.0,
            maxHeight: heightScreen,
          ),

          child: SizedBox(
            height: ((heightScreen / 5) * 3),
            width: widthScreen,
            child: GridView.count(
              padding: EdgeInsets.fromLTRB(70, 8, 70, 8),
              crossAxisCount: 9,
              children: palavra
                  .map(
                    (item) => Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.5),
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.amberAccent,
                      ),
                      margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
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
                            border: Border.all(color: Colors.black, width: 2),
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
