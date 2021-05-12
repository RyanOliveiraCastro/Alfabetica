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
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2),
            color: Colors.transparent,
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
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.yellow,
                      ),
                      margin: const EdgeInsets.all(5.0),
                      child: Draggable<ItemModel>(
                        data: item,
                        childWhenDragging: Container(
                          child: Icon(
                            item.icon,
                            color: Colors.grey,
                            size: 31,
                          ),
                        ),
                        feedback: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.blue,
                          ),
                          height: 50,
                          width: 50,
                          child: Icon(
                            item.icon,
                            color: Colors.black,
                            size: 31,
                          ),
                        ),
                        child: Icon(
                          item.icon,
                          color: Colors.black,
                          size: 31,
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
