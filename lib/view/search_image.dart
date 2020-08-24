import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:radio/model/unidade.dart';

import 'series_list.dart';

class SearchImageForm extends StatelessWidget {
  var _controller = TextEditingController();
  final Unidade _unidade;

  SearchImageForm(this._unidade);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _unidade.sigla,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextField(
                          cursorColor: Theme.of(context).accentColor,
                          controller: _controller,
                          autofocus: true,
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Theme.of(context).textTheme.headline6.color,
                          ),
                          maxLines: 3,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Chave:",
                            labelStyle: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white),
                          ),
                        ),
                        RaisedButton(
                          onPressed: () => adicionarExame(_unidade, context),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            "Procurar exame",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          color: Theme.of(context).accentColor,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  adicionarExame(Unidade unidade, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SeriesList(unidade, _controller.text),
    ));
  }
}
