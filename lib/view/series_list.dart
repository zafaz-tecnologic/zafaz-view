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
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

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
                  if (study.modality == 'DR' ||
                      study.modality == 'CR' ||
                      study.modality == 'DX') {
                    return MyGridViewSeries(
                      unidade: widget.unidade,
                      study: study,
                    );
                  } else {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Visibility(
                            visible: study.laudos.isNotEmpty,
                            child: Html(
                              data: study.laudos.isEmpty
                                  ? ''
                                  : study.laudos[0].texto,
                            ),
                          ),
                          Visibility(
                            visible: study.laudos.isEmpty,
                            child:
                                Center(child: Text("Nenhum laudo encontrado.")),
                          ),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            onPressed: () =>
                                _launchURL(widget.unidade.ip, study.uuid),
                            child: Text(
                              "Abrir exame",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }
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

  _launchURL(String ip, String uuid) async {
    final url = 'http://$ip:9007/ZafazPacs/viewer.html?studyUID=$uuid';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
