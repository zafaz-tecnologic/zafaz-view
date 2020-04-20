import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final TextEditingController controller;
  final String titulo;
  final String dica;
  final IconData icone;

  Editor({
    this.controller,
    this.titulo,
    this.dica,
    this.icone,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            labelText: titulo,
            hintText: dica,
            icon: icone != null ? Icon(icone) : null),
        style: TextStyle(fontSize: 24),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
