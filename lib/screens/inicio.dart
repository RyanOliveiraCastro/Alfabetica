import 'package:Alfabetica/screens/menu_principal.dart';
import 'package:flutter/material.dart';

import 'faseLivre.dart';

class Inicio extends StatefulWidget {
  @override
  _Inicio createState() => _Inicio();
}

class _Inicio extends State<Inicio> {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height - 10;
    return Scaffold(
      primary: false,
      body: Container(

        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/fundo_inicio.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "A",
                    style: TextStyle(
                      fontSize: 80,
                      //fontWeight: FontWeight.w600,
                      fontFamily: 'toyblocks',
                      color: Colors.red,
                    ),
                  ),
                  Text(
                    "L",
                    style: TextStyle(
                      fontSize: 80,
                      //fontWeight: FontWeight.w600,
                      fontFamily: 'toyblocks',
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    "F",
                    style: TextStyle(
                      fontSize: 80,
                      //fontWeight: FontWeight.w600,
                      fontFamily: 'toyblocks',
                      color: Colors.amber,
                    ),
                  ),
                  Text(
                    "A",
                    style: TextStyle(
                      fontSize: 80,
                      //fontWeight: FontWeight.w600,
                      fontFamily: 'toyblocks',
                      color: Colors.pink,
                    ),
                  ),
                  Text(
                    "B",
                    style: TextStyle(
                      fontSize: 80,
                      //fontWeight: FontWeight.w600,
                      fontFamily: 'toyblocks',
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    "É",
                    style: TextStyle(
                      fontSize: 80,
                      //fontWeight: FontWeight.w600,
                      fontFamily: 'toyblocks',
                      color: Colors.purple,
                    ),
                  ),
                  Text(
                    "T",
                    style: TextStyle(
                      fontSize: 80,
                      //fontWeight: FontWeight.w600,
                      fontFamily: 'toyblocks',
                      color: Colors.teal,
                    ),
                  ),
                  Text(
                    "I",
                    style: TextStyle(
                      fontSize: 80,
                      //fontWeight: FontWeight.w600,
                      fontFamily: 'toyblocks',
                      color: Colors.deepOrange,
                    ),
                  ),
                  Text(
                    "C",
                    style: TextStyle(
                      fontSize: 80,
                      //fontWeight: FontWeight.w600,
                      fontFamily: 'toyblocks',
                      color: Colors.cyan,
                    ),
                  ),
                  Text(
                    "A",
                    style: TextStyle(
                      fontSize: 80,
                      //fontWeight: FontWeight.w600,
                      fontFamily: 'toyblocks',
                      color: Colors.brown,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.transparent,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.6),
                      spreadRadius: 2,
                      blurRadius: 0,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                width: 400,
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                      child: TextButton(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all<Size>(
                            Size(160, 75),
                          ),
                          side: MaterialStateProperty.all<BorderSide>(
                            BorderSide(color: Colors.black, width: 1),
                          ),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.fromLTRB(25, 10, 25, 10),
                          ),
                        ),
                        child: Text(
                          "Livre",
                          style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FaseLivre(),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                      child: TextButton(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all<Size>(
                            Size(160, 75),
                          ),
                          side: MaterialStateProperty.all<BorderSide>(
                            BorderSide(color: Colors.black, width: 1),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.fromLTRB(25, 10, 25, 10),
                          ),
                        ),
                        child: Text(
                          "Fases",
                          style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MenuPrincipal(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
