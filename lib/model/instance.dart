import 'package:json_annotation/json_annotation.dart';

part 'instance.g.dart';

@JsonSerializable(explicitToJson: true)
class Instance {
  Instance(this.pk, this.uuid);

  int pk;
  String uuid;

  factory Instance.fromJson(Map<String, dynamic> json) => _$InstanceFromJson(json);
  Map<String, dynamic> toJson() => _$InstanceToJson(this);

  @override
  String toString() {
    return 'Instance{pk: $pk, uuid: $uuid}';
  }


}
