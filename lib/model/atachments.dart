import 'package:json_annotation/json_annotation.dart';

part 'atachments.g.dart';

@JsonSerializable()
class Atachments {
  Atachments(this.id, this.nome, this.dataHora);

  final int id;
  final String nome;
  final DateTime dataHora;

  factory Atachments.fromJson(Map<String, dynamic> json) => _$AtachmentsFromJson(json);
  Map<String, dynamic> toJson() => _$AtachmentsToJson(this);
}