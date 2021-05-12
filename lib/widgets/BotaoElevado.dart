import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BotaoElevado extends StatefulWidget {
  Size size;
  BorderSide boderSide;
  BorderRadius borderRadius;
  Color backgroundColor;
  Color foregroundColor;
  double padding;
  EdgeInsets margin;
  IconData iconData;
  VoidCallback function;

  BotaoElevado(
      {this.size, 
      this.boderSide,
      this.borderRadius,
      this.backgroundColor,
      this.foregroundColor,
      this.padding,
      this.margin,
      this.iconData,
      this.function});

  @override
  _BotaoElevadoState createState() => _BotaoElevadoState(
      size: size,
      boderSide: boderSide,
      borderRadius: borderRadius,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      padding: padding,
      margin: margin,
      iconData: iconData,
      function: function);
}

class _BotaoElevadoState extends State<BotaoElevado> {
  
  Size size;
  BorderSide boderSide;
  BorderRadius borderRadius;
  Color backgroundColor;
  Color foregroundColor;
  double padding;
  EdgeInsets margin;
  IconData iconData;
  VoidCallback function;

  _BotaoElevadoState(
      {this.size, 
      this.boderSide,
      this.borderRadius,
      this.backgroundColor,
      this.foregroundColor,
      this.padding,
      this.margin,
      this.iconData,
      this.function});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: ElevatedButton(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all<Size>(size),
          side: MaterialStateProperty.all<BorderSide>(boderSide),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: borderRadius)),
          backgroundColor: MaterialStateProperty.all<Color>(backgroundColor),
          foregroundColor: MaterialStateProperty.all<Color>(foregroundColor),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.all(padding)),
        ),
        child: Icon(iconData),
        onPressed: () async {        
          function();
      },
      ),
    );
  }
}
