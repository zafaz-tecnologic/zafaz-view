// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'atachments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Atachments _$AtachmentsFromJson(Map<String, dynamic> json) {
  return Atachments(
    json['id'] as int,
    json['nome'] as String,
    json['dataHora'] == null
        ? null
        : DateTime.parse(json['dataHora'] as String),
  );
}

Map<String, dynamic> _$AtachmentsToJson(Atachments instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'dataHora': instance.dataHora?.toIso8601String(),
    };
