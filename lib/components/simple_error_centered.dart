import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MySimpleErrorCentered extends StatelessWidget {
  final String _errorMessage;

  const MySimpleErrorCentered(this._errorMessage);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.error_outline,
          size: 100,
        ),
        Text(_errorMessage),
      ],
    );
  }
}
