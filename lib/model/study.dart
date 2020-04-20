import 'package:radio/model/series.dart';

class Study {
  Study(this.pk, this.uuid, this.series);

  int pk;
  String uuid;
  List<Series> series;

  Study.fromJson(Map<String, dynamic> json) {
    pk = json['pk'];
    uuid = json['uuid'];
    series = (json['series'] as List<dynamic>).map((e) => Series.fromJson(e)).toList();
  }

  @override
  String toString() {
    return 'Study{pk: $pk, uuid: $uuid, series: $series}';
  }


}
