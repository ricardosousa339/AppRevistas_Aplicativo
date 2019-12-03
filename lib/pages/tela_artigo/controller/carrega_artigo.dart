import 'dart:async';
import 'dart:convert';
import 'package:apprevistas_aplicativo/urls.dart';
import 'package:http/http.dart' as http;
import 'package:apprevistas_aplicativo/pages/tela_revista/model/artigo.dart';

Future<Artigo> carregaArtigo(String idArtigo) async{
  final response =
      await http.get(raizApi+'/api/detail-artigos/'+idArtigo);

       if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    return Artigo.fromJson(json.decode(utf8.decode(response.bodyBytes)));
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
  

}