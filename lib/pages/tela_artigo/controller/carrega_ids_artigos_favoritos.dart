import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../urls.dart';

Future<List<String>> carregaIdsFavoritos(String idDoUsuario, String keyy) async {

  List<String> revistas = List();
    String uri =
       raizApi+'/api/get-usuariosporid/'+idDoUsuario;

    var response = await http
        .get(Uri.encodeFull(uri), headers: {"Accept": "application/json", "Authorization":"Token "+keyy});

    if (response.statusCode == 200) {
      var data = json.decode(utf8.decode(response.bodyBytes));
      var rest = data[0]['artigos_favoritos'] as List;


      for (var item in rest) {

        revistas.add(item["id"].toString());
      }
      print(rest);
      return revistas;
    }

  }
