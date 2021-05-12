import 'package:Alfabetica/Database.dart';
import 'package:Alfabetica/model/ItemFase.dart';

/*List<ItemFase> _listItem = [
  ItemFase(id: 1,
      url: 'assets/images/quarto/2.jpg',
      name: "CAMA",
      numeroFase: 1,
      lock: false),
  ItemFase(id: 2,
      url: 'assets/images/quarto/3.jpg',
      name: "CORTINA",
      numeroFase: 2,
      lock: false),
  ItemFase(id: 3,
      url: 'assets/images/quarto/4.png',
      name: "TAPETE",
      numeroFase: 3,
      lock: false),
  ItemFase(id: 4,
      url: 'assets/images/quarto/5.png',
      name: "ABAJUR",
      numeroFase: 4,
      lock: false),
  ItemFase(id: 5,
      url: 'assets/images/quarto/6.jpg',
      name: "VENTILADOR",
      numeroFase: 5,
      lock: true),
  ItemFase(id: 6,
      url: 'assets/images/quarto/7.jpg',
      name: "JANELA",
      numeroFase: 6,
      lock: true),
  ItemFase(id: 7,
      url: 'assets/images/quarto/8.png',
      name: "CÔMODA",
      numeroFase: 7,
      lock: true),
];*/

class InitDatabase{

  criarFases() async {
    await DBProvider.db.newFase(new ItemFase(id: 1, local: "Quarto", name: "CAMA", numeroFase: 1, url: 'assets/images/quarto/2.png', lock: false));
    await DBProvider.db.newFase(new ItemFase(id: 2, local: "Quarto", name: "JANELA",numeroFase: 2, url: 'assets/images/quarto/7.png', lock: true));
    await DBProvider.db.newFase(new ItemFase(id: 3, local: "Quarto", name: "CORTINA", numeroFase: 3, url: 'assets/images/quarto/3.jpg', lock: true));
    await DBProvider.db.newFase(new ItemFase(id: 4, local: "Quarto", name: "TAPETE", numeroFase: 4, url: 'assets/images/quarto/4.png', lock: true));
    await DBProvider.db.newFase(new ItemFase(id: 5, local: "Quarto", name: "ABAJUR", numeroFase: 5, url: 'assets/images/quarto/5.png', lock: true));
    await DBProvider.db.newFase(new ItemFase(id: 6, local: "Quarto", name: "CÔMODA",numeroFase: 6, url: 'assets/images/quarto/8.png', lock: true));
    await DBProvider.db.newFase(new ItemFase(id: 7, local: "Quarto", name: "VENTILADOR", numeroFase: 7, url: 'assets/images/quarto/6.jpg', lock: true));

    await DBProvider.db.newFase(new ItemFase(id: 8,  local: "Cozinha", name: "FACA", numeroFase: 1, url: 'assets/images/cozinha/faca.jpg', lock: false));
    await DBProvider.db.newFase(new ItemFase(id: 9,  local: "Cozinha", name: "GARFO",numeroFase: 2, url: 'assets/images/cozinha/garfo.png', lock: true));
    await DBProvider.db.newFase(new ItemFase(id: 10, local: "Cozinha", name: "PRATO",numeroFase: 3, url: 'assets/images/cozinha/prato.jpg', lock: true));
    await DBProvider.db.newFase(new ItemFase(id: 11, local: "Cozinha", name: "PANELA",numeroFase: 4, url: 'assets/images/cozinha/panela.jpg', lock: true));
    await DBProvider.db.newFase(new ItemFase(id: 12, local: "Cozinha", name: "COLHER", numeroFase: 5, url: 'assets/images/cozinha/colher.png', lock: true));
    await DBProvider.db.newFase(new ItemFase(id: 13, local: "Cozinha", name: "FOGÃO", numeroFase: 6, url: 'assets/images/cozinha/fogao.jpg', lock: true));
    await DBProvider.db.newFase(new ItemFase(id: 14, local: "Cozinha", name: "CADEIRA", numeroFase: 7, url: 'assets/images/cozinha/cadeira.jpg', lock: true));
    await DBProvider.db.newFase(new ItemFase(id: 15, local: "Cozinha", name: "GELADEIRA",numeroFase: 8, url: 'assets/images/cozinha/geladeira.jpg', lock: true));
    await DBProvider.db.newFase(new ItemFase(id: 16, local: "Cozinha", name: "MICROONDAS",numeroFase: 9, url: 'assets/images/cozinha/microondas.jpg', lock: true));
    await DBProvider.db.newFase(new ItemFase(id: 17, local: "Cozinha", name: "BATEDEIRA", numeroFase: 10, url: 'assets/images/cozinha/batedeira.jpg', lock: true));
    await DBProvider.db.newFase(new ItemFase(id: 18, local: "Cozinha", name: "LIQUIDIFICADOR",numeroFase: 11, url: 'assets/images/cozinha/liquidificador.jpg', lock: true));
 }

  Future<void> drop() async {
    await DBProvider.db.deleteAll();
  }

}