import 'dart:convert';

import 'package:http/http.dart' as http;
  import 'package:apprevistas_aplicativo/model/noticia.dart';

Future<Noticia> getNoticia(int indice) async {
    final response = await http
        .get('https://jsonplaceholder.typicode.com/posts/' + indice.toString());

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.

      return Noticia.fromJson(json.decode(response.body));

      // p = Noticia.fromJson(json.decode(response.body));

    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }
