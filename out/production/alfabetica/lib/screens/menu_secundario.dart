import 'package:Alfabetica/Database.dart';
import 'package:Alfabetica/model/ItemFase.dart';
import 'package:Alfabetica/screens/faseNova.dart';
import 'package:Alfabetica/screens/menu_principal.dart';
import 'package:flutter/material.dart';

class MenuSecundario extends StatefulWidget {
  final String local;

  const MenuSecundario({this.local});

  @override
  _MenuSecundario createState() => _MenuSecundario(local: local);
}

class _MenuSecundario extends State<MenuSecundario> {
  String local;

  _MenuSecundario({this.local});

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          local,
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
                builder: (context) => MenuPrincipal(),
              ),
            );
          },
        ),
      ),
      backgroundColor: Colors.lightBlueAccent,
      body: FutureBuilder<List<ItemFase>>(
        future: DBProvider.db.getFasesByLocal(local),
        builder:
            (BuildContext context, AsyncSnapshot<List<ItemFase>> snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: (widthScreen / 140).floor()),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Stack(children: <Widget>[
                      Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: AssetImage(
                              snapshot.data[index].url,
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child:  OutlineButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          borderSide: BorderSide(width: 0, style: BorderStyle.solid, color: Colors.transparent),
                          highlightedBorderColor: Colors.transparent,
                          child: null,
                          onPressed: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FaseNova(
                                        itemFase: new ItemFase(
                                            id: snapshot.data[index].id,
                                            local: snapshot.data[index].local,
                                            name: snapshot.data[index].name,
                                            url: snapshot.data[index].url,
                                            numeroFase: snapshot
                                                .data[index].numeroFase))));
                          },
                        )
                      ),
                      if (snapshot.data[index].lock == true)
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(0, 0, 0, 0.6),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Icon(
                              Icons.lock_outline,
                              size: 56,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                    ]);
                  }),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
