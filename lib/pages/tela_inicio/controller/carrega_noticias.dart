import 'dart:convert';

import 'package:apprevistas_aplicativo/pages/tela_inicio/model/noticia.dart';
import 'package:http/http.dart' as http;

import '../../../urls.dart';

Future<List<Noticia>> getNoticia() async {

  /*
    final response = await http
        .get('https://jsonplaceholder.typicode.com/posts/');

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.

      return Noticia.fromJson(json.decode(response.body));

      // p = Noticia.fromJson(json.decode(response.body));

    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }

*/


    List<Noticia> list;

    String uri =
       raizApi+'/api/noticias';

    var response = await http
        .get(Uri.encodeFull(uri), headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var rest = data as List;
      //print('rest'+rest.toString());
      list = rest.map<Noticia>((json) => Noticia.fromJson(json)).toList();
      //print('listaaaa de edicoes:' + list.toString());
    }

    return list;
  }
