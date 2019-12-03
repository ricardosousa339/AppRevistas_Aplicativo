import 'dart:convert';

import 'package:apprevistas_aplicativo/pages/tela_comentarios/model/comentario.dart';
import 'package:http/http.dart' as http;

import '../../../urls.dart';

Future<List<Comentario>> getComentario(String idNoticia) async {

  List<Comentario> list;
     String uri =
        raizApi+'/api/get-comentariosnoticia/'+idNoticia;

    var response = await http
        .get(Uri.encodeFull(uri), headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      var data = json.decode(utf8.decode(response.bodyBytes));
      var rest = data as List;
      //print('rest'+rest.toString());
      list = rest.map<Comentario>((json) => Comentario.fromJson(json)).toList();
  }
  return list;
}