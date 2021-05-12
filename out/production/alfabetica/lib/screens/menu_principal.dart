import 'package:Alfabetica/screens/menu_secundario.dart';
import 'package:flutter/material.dart';

import 'inicio.dart';

class MenuPrincipal extends StatefulWidget {
  @override
  _MenuPrincipal createState() => _MenuPrincipal();
}

class _MenuPrincipal extends State<MenuPrincipal> {
  final List<ItemModel> _listItem = [
    ItemModel(url: 'assets/images/quarto.jpg', name: 'Quarto'),
    ItemModel(url: 'assets/images/cozinha.jpg', name: 'Cozinha'),
    ItemModel(url: 'assets/images/banheiro.jpg', name: 'Banheiro'),
    ItemModel(url: 'assets/images/sala.jpg', name: 'Sala'),
    ItemModel(url: 'assets/images/brinquedo.png', name: 'Brinquedo'),
    ItemModel(url: 'assets/images/cores.jpg', name: 'Cores'),
    ItemModel(url: 'assets/images/escola.jpg', name: 'Escola'),
    ItemModel(url: 'assets/images/animais.jpg', name: 'Animais')
  ];

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Menu",
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Inicio(),
              ),
            );
          },
        ),
      ),
      backgroundColor: Colors.lightBlueAccent,
      body: Container(
        height: heightScreen - 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
              childAspectRatio: 1.4,
              crossAxisCount: 4,
              mainAxisSpacing: 0,
              children: _listItem
                  .map(
                    (item) => Stack(children: <Widget>[
                      Container(
                        width: 170,
                        height: 130,
                        margin: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                              image: AssetImage(item.url), fit: BoxFit.fill),
                        ),
                        child: OutlineButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.solid,
                              color: Colors.transparent),
                          highlightedBorderColor: Colors.transparent,
                          child: null,
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context)
                                    //if (item.name == 'quarto') {
                                    //return MenuQuarto();
                                    =>
                                    MenuSecundario(local: item.name),
                                //}
                              ),
                            );
                          },
                        ),
                      ),
                    ]),
                  )
                  .toList()),
        ),
      ),
    );
  }
}

class ItemModel {
  final String name;
  final String url;

  ItemModel({this.name, this.url});
}
