import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:radio/components/progress.dart';
import 'package:radio/http/unidade_webclient.dart';
import 'package:radio/model/unidade.dart';
import 'package:radio/view/saved_study_list.dart';
import 'package:radio/view/search_image.dart';
import 'package:radio/view/series_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZAFAZ View',
      theme: ThemeData(
        buttonTheme: ButtonThemeData(
          buttonColor: const Color(0xFFFF5252),
        ),
        textTheme: TextTheme(
          button: TextStyle(color: const Color(0xFFFFFFFF)),
          headline6: TextStyle(color: Colors.white),
        ),
        primaryTextTheme: TextTheme(
          button: TextStyle(color: const Color(0xFFFFFFFF)),
        ),
        primaryColor: const Color(0xFF009688),
        primaryColorLight: const Color(0xFFB2DFDB),
        accentColor: const Color(0xFFFF5252),
        primaryColorDark: const Color(0xFF00796B),
        dividerColor: const Color(0xFFBDBDBD),
      ),
      home: MyHomePage(
        title: "ZAFAZ View",
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Unidade> _unidades;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Image.asset('images/logo_zafaz.png'),
            ),
            ListTile(
              leading: Icon(Icons.archive),
              title: Text("Meus exames salvos"),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SavedStudyList(),
              )),
            )
          ],
        ),
      ),
      body: FutureBuilder(
        future: _listarUnidades(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              return Home(_unidades);
              break;
          }
          return MyProgress();
        },
      ),
    );
  }

  Future _listarUnidades() async {
    _unidades = await UnidadeWebClient().listar();
  }
}

class Home extends StatelessWidget {
  final List<Unidade> _unidades;

  Home(this._unidades);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64.0, vertical: 8.0),
//          child: Image.asset('images/logo_zafaz.png'),
          child: Image.asset("images/FHAJ_400x400.jpg"),
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              color: Theme.of(context).primaryColor,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Unidades disponíveis",
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(color: Colors.white70)),
                  Container(
                    margin: EdgeInsets.only(top: 16.0),
                    height: 200.0,
                    child: ListView.builder(
                      itemCount: _unidades.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return UnidadeItemList(_unidades[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class UnidadeItemList extends StatelessWidget {
  final Unidade _unidade;

  UnidadeItemList(this._unidade);

  @override
  Widget build(BuildContext context) {
    _unidade.nome = "FUNDAÇÃO HOSPITAL ADRIANO JORGE";
    _unidade.sigla = "FHAJ";
    return Card(
      elevation: 8.0,
      child: Container(
        width: 160.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _unidade.nome,
              ),
            ),
            Center(
                child: Icon(
              Icons.business,
              size: 54,
            )),
            Center(
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () => _pesquisarNaUnidade(context),
                child: Text(
                  "Pesquisar",
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _pesquisarNaUnidade(context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SearchImageForm(_unidade),
    ));
  }
}
