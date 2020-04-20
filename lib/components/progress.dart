import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyProgress extends StatelessWidget {

  final String text;

  const MyProgress({this.text = "Loading..."});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(text),
          ),
        ],
      ),
    );
  }
}
