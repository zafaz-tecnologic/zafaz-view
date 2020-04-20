import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:photo_view/photo_view.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:radio/components/progress.dart';
import 'package:radio/components/simple_error_centered.dart';

class InstanceView extends StatefulWidget {
  final String _url;

  InstanceView(this._url);

  @override
  _InstanceViewState createState() => _InstanceViewState();
}

class _InstanceViewState extends State<InstanceView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Instance"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.share),
            tooltip: "Compartilhar",
            onPressed: () => _compartilhar(widget._url),
          )
        ],
      ),
      body: Container(
        child: PhotoView(
          imageProvider: NetworkImage(widget._url),
          loadFailedChild: MySimpleErrorCentered("Erro ao carregar a image. Tente novamente."),
          loadingBuilder: (context, event) {
            var medida = 0;
            var unidadeMedida = "bytes";
            if (event != null) {
              var bytes = event.cumulativeBytesLoaded;
              medida = bytes;
              if (medida > 1024) {
                unidadeMedida = "KBs";
                medida = medida ~/ 1024;
                if (medida > 1024) {
                  unidadeMedida = "MBs";
                  medida = medida ~/ 1024;
                }
              }
            }
            return MyProgress(
              text: "Carregando imagem ($medida $unidadeMedida)",
            );
          },
        ),
      ),
    );
  }

  _compartilhar(String url) async {
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    Uint8List bytes = await consolidateHttpClientResponseBytes(response);
    await Share.file('Instance', 'instance.jpg', bytes, 'image/jpg');
  }
}
