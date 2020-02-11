import 'dart:io';

import 'package:apprevistas_aplicativo/urls.dart';
import 'package:http/http.dart' as http;

Future<http.Response> favoritaArtigo(String idDoUsuario, String idDoArtigo, String keyy) {
  return http.get(
    raizApi+'/api/add-artigofavoritousuario/'+idDoUsuario+'/'+idDoArtigo,
    // Send authorization headers to the backend.
    headers: {HttpHeaders.authorizationHeader: "Token "+keyy},
  );
}

  //    '/api/add-artigofavoritousuario/( id do usuario )/( id do artigo)