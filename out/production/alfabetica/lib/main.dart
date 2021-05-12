import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Alfabetica/Database.dart';
import 'package:Alfabetica/screens/inicio.dart';
import 'package:Alfabetica/screens/faseLivre.dart';
import 'package:Alfabetica/services/initDatabase.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<dynamic> deleteAll = DBProvider.db.deleteAll();
  @override
    void initState() {
      SystemChrome.setEnabledSystemUIOverlays([]);
      super.initState();
    }
  @override
  Widget build(BuildContext context) {
    InitDatabase inidb = new InitDatabase();
    inidb.criarFases();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'PressStart',
      ),
      home: Inicio(),
    );
  }
}
