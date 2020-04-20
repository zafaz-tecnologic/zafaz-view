import 'package:radio/model/instance.dart';

class Series {
  Series(this.pk, this.uuid, this.instances);

  int pk;
  String uuid;
  List<Instance> instances;

  Series.fromJson(Map<String, dynamic> json) {
    pk = json['pk'];
    uuid = json['uuid'];
    instances = (json['instances'] as List<dynamic>).map((e) => Instance.fromJson(e)).toList();
  }

  @override
  String toString() {
    return 'Series{pk: $pk, uuid: $uuid, instances: $instances}';
  }


}
