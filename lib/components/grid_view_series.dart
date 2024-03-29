import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:radio/model/series.dart';
import 'package:radio/model/study.dart';
import 'package:radio/model/unidade.dart';
import 'package:radio/view/single_image_visualizer.dart';

class MyGridViewSeries extends StatelessWidget {
  final Unidade unidade;
  final Study study;

  MyGridViewSeries({Key key, this.unidade, this.study}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: study.series.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        final ip = unidade.ip;
//                      final porta = widget.unidade.porta;
        final porta = unidade.portaJboss;
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

  _abrirImagem(BuildContext context, String url) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => InstanceView(url),
    ));
  }
}
