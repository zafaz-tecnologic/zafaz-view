import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:radio/components/centered_message.dart';
import 'package:radio/components/progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedStudyList extends StatefulWidget {
  @override
  _SavedStudyListState createState() => _SavedStudyListState();
}

class _SavedStudyListState extends State<SavedStudyList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus exames salvos"),
      ),
      body: Container(
        child: FutureBuilder(
          future: _listarEstudosSalvos(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                break;
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                if (snapshot.hasData) {
                  List<String> studys = snapshot.data;
                  if (studys.isNotEmpty) {
                    return ListView.builder(
                      itemCount: studys.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Chave:",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: Container(
                                            child: Text(studys[index]))),
                                    InkWell(
                                        onTap: () {
                                          Clipboard.setData(ClipboardData(text: studys[index]));
                                          Scaffold.of(context).showSnackBar(SnackBar(
                                            content: Text("Conteúdo copiado para área de transferência."),
                                          ));
                                        }
                                        ,child: Icon(Icons.content_copy)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                }
                return CenteredMessage("Nenhum exame salvo");
                break;
            }
            return MyProgress(
              text: "Buscando lista",
            );
          },
        ),
      ),
    );
  }

  _listarEstudosSalvos() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getStringList("study");
  }
}
