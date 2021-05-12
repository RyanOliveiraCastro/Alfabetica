import 'package:flutter/material.dart';

class ItemModel {
  String name;
  String value;
  IconData icon;
  bool accepting;

  ItemModel({this.name, this.value, this.icon, this.accepting = false});

  @override
  String toString() {
    return 'ItemModel{name: $name, value: $value, icon: $icon, accepting: $accepting}';
  }
}