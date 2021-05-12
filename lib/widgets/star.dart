import 'package:flutter/material.dart';

class Star extends StatefulWidget {

  final double size;
  final Color color;

 Star({this.size, this.color});

  @override
  _StarState createState() => _StarState();
}

class _StarState extends State<Star> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 104,
      height: 104,
      child: Icon(
        Icons.star,
        color: widget.color,
        size: widget.size,
      ),
    );
  }
}
