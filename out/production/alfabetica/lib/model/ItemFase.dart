import 'dart:convert';

import 'ItemModel.dart';

class ItemFase {
  int id;
  String local;
  String name;
  int numeroFase;
  String url;
  bool lock;
  
  List<ItemModel> listLetrasShuffle = [];
  List<ItemModel> listLetras = [];
  bool gameOver;
  bool menuPopup = false;
  bool menuPopupFim = false;
  bool novaFase = true;

  @override
  String toString() {
    return 'ItemFase{id: $id, local: $local, name: $name, numeroFase: $numeroFase, url: $url, lock: $lock}';
  }

  ItemFase(
      {this.id, this.name, this.local, this.url, this.numeroFase, this.lock, this.listLetrasShuffle, this.listLetras, this.gameOver, this.menuPopup, this.menuPopupFim, this.novaFase});

  factory ItemFase.fromMap(Map<String, dynamic> json) => new ItemFase(
        id: json["id"],
        local: json["local"],
        name: json["name"],
        numeroFase: json["numeroFase"],
        url: json["url"],
        lock: json["lock"] == 1,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "local": local,
        "name": name,
        "numeroFase": numeroFase,
        "url": url,
        "lock": lock,
      };
}

ItemFase clientFromJson(String str) {
  final jsonData = json.decode(str);
  return ItemFase.fromMap(jsonData);
}

String clientToJson(ItemFase data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}