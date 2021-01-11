import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:radio/model/study.dart';
import 'package:radio/model/unidade.dart';

class StudyWebClient {
  final Unidade _unidade;

  StudyWebClient(this._unidade);

  Future<Study> selecionar(String uuid) async {
    var client = http.Client();
    try {
      final ip = _unidade.ip;
      final porta = _unidade.portaTomcat;
      final url = "http://$ip:$porta/Raioz/study?uuid=$uuid";
      debugPrint(url);
      var uriResponse = await client.get(url);

      debugPrint(uriResponse.body);
      final data = jsonDecode(uriResponse.body);
      return Study.fromJson(data[0]);
    } finally {
      client.close();
    }
  }
}
