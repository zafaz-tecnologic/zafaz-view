import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:radio/components/grid_view_series.dart';
import 'package:radio/components/progress.dart';
import 'package:radio/components/simple_error_centered.dart';
import 'package:radio/http/study_webclient.dart';
import 'package:radio/model/series.dart';
import 'package:radio/model/study.dart';
import 'package:radio/model/unidade.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SeriesList extends StatefulWidget {
  final Unidade unidade;
  final String studyUUID;

  SeriesList(this.unidade, this.studyUUID);

  @override
  _SeriesListState createState() => _SeriesListState();
}

class _SeriesListState extends State<SeriesList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Imagens"),
      ),
      body: FutureBuilder(
        future: StudyWebClient(widget.unidade).selecionar(widget.studyUUID),
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
                final Study study = snapshot.data;
                if (study.series.isNotEmpty) {
                  _saveStudy(study);
                  return MyGridViewSeries(
                    unidade: widget.unidade,
                    study: study,
                  );
                }
              }
              return Center(
                child: MySimpleErrorCentered("Erro ao buscar imagens."),
              );
              break;
          }
          return MyProgress();
        },
      ),
    );
  }

  void _saveStudy(Study study) async {
    final preferences = await SharedPreferences.getInstance();
    var studyList = preferences.getStringList("study");

    if (studyList != null) {
      for (String savedStudy in studyList) {
        if (savedStudy == study.uuid) {
          return;
        }
      }
    }

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text("Salvar exame"),
          content: Text(
              "Salvar o exame para não precisar digitar a chave novamente?"),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancelar"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text("Salvar"),
              onPressed: () {
                if (studyList == null) {
                  studyList = List();
                }
                studyList.add(study.uuid);
                preferences.setStringList("study", studyList);
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

}
