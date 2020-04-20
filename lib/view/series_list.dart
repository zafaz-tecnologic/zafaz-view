import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:radio/components/progress.dart';
import 'package:radio/components/simple_error_centered.dart';
import 'package:radio/http/study_webclient.dart';
import 'package:radio/model/series.dart';
import 'package:radio/model/study.dart';
import 'package:radio/model/unidade.dart';
import 'package:radio/view/single_image_visualizer.dart';

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
                  final List<Series> series = study.series;
                  return GridView.builder(
                    itemCount: series.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (BuildContext context, int index) {
                      final ip = widget.unidade.ip;
//                      final porta = widget.unidade.porta;
                      final porta = "9007";
                      final studyUuid = study.uuid;
                      final seriesUuid = study.series[index].uuid;
                      final objectUuid = study.series[index].instances[0].uuid;
                      String url =
                          "http://$ip:$porta/wado/wado?requestType=WADO&studyUID=$studyUuid&seriesUID=$seriesUuid&objectUID=$objectUuid&contentType=image/jpeg";

                      return MyCardSeries(url);
                    },
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
}

class MyCardSeries extends StatelessWidget {
  final String _url;

  MyCardSeries(this._url);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      color: Colors.black,
      child: InkWell(
        onTap: () => _abrirImagem(context, _url),
        splashColor: Theme.of(context).accentColor,
        child: Ink.image(image: NetworkImage('$_url&rowns=200&columns=200')),
      ),
    );
  }
}

_abrirImagem(BuildContext context, String url) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => InstanceView(url),
  ));
}
