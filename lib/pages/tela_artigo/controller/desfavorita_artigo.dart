import 'dart:async';
import 'dart:io';

import 'package:apprevistas_aplicativo/urls.dart';
import 'package:http/http.dart' as http;

Future<http.Response> desFavoritaArtigo(String idDoUsuario, String idDoArtigo, String keyy) {
  return http.get(
    raizApi+'/api/remove-artigofavoritousuario/'+idDoUsuario+'/'+idDoArtigo,
    // Send authorization headers to the backend.
    headers: {HttpHeaders.authorizationHeader: "Token "+keyy},
  );
}

  //    '/api/add-artigofavoritousuario/( id do usuario )/( id do artigo)