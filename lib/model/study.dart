import 'package:radio/model/atachments.dart';
import 'package:radio/model/laudo.dart';
import 'package:radio/model/series.dart';

class Study {
  Study(this.pk, this.uuid, this.series);

  int pk;
  String uuid;
  String modality;
  List<Laudo> laudos;
  List<Series> series;
  List<Atachments> atachments;

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
    // atachments = (json['anexos'] as List<dynamic>)
    //     .map((e) => Atachments.fromJson(e))
    //     .toList();
    atachments = [
      Atachments(
        47,
        'MARIA LUIZA GOMES PEREIRA - TÓRAX - 02-05-2020.pdf',
        DateTime.parse('2020-05-22T13:50:21.452+0000'),
      )
    ];
  }

  @override
  String toString() {
    return 'Study{pk: $pk, uuid: $uuid, series: $series}';
  }
}
