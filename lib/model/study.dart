import 'package:radio/model/laudo.dart';
import 'package:radio/model/series.dart';

class Study {
  Study(this.pk, this.uuid, this.series);

  int pk;
  String uuid;
  String modality;
  List<Laudo> laudos;
  List<Series> series;

  Study.fromJson(Map<String, dynamic> json) {
    pk = json['pk'];
    uuid = json['uuid'];
    modality = json['modality'];
    series = (json['series'] as List<dynamic>)
        .map((e) => Series.fromJson(e))
        .toList();
    laudos = (json['laudos'] as List<dynamic>)
        .map((e) => Laudo.fromJson(e))
        .toList();
  }

  @override
  String toString() {
    return 'Study{pk: $pk, uuid: $uuid, series: $series}';
  }
}
