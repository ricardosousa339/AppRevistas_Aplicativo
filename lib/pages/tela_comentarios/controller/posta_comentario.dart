 import 'dart:convert';

import 'package:apprevistas_aplicativo/pages/tela_comentarios/model/comentario.dart';
import 'package:apprevistas_aplicativo/urls.dart';
import 'package:http/http.dart' as http;


Future<dynamic> postaComentario(String idDaNoticia, String idDoAutor, String corpo, String key) async {
  


 
   
   Comentario comentario = Comentario(
     autor: idDoAutor,
     noticia: idDaNoticia,
     corpo: corpo
   );

var resposta = await http.post(raizApi+ '/api/create-comentarios/',
body: json.encode(comentario.toMap()),
headers: {'Content-Type': 'application/json',
"Authorization": "Token " + key});

return resposta;
   
  }