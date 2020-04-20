import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:radio/model/unidade.dart';
import 'package:http/http.dart' as http;

import 'endpoints.dart';

class UnidadeWebClient {

  Future<List<Unidade>> listar() async {
    var client = http.Client();
    try {
      var uriResponse = await client.get(Endpoints.unidades);
      var jsonDecoded = jsonDecode(uriResponse.body);

      List<Unidade> unidades = List();
      for (var dado in jsonDecoded) {
        unidades.add(Unidade.fromJSON(dado));
      }
      return unidades;
    } finally {
      client.close();
    }
  }
}