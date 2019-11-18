import 'package:apprevistas_aplicativo/pages/tela_comentarios/model/comentario.dart';
import 'package:flutter/material.dart';

blocoComentario(Comentario comentario, BuildContext context) {
  return Card(
    child: Column(
      children: <Widget>[
        Row(children: <Widget>[Icon(Icons.person), Text(comentario.autor)]),
        Padding(padding: EdgeInsets.all(4), child:Text(comentario.corpo))
      
      ],
    ),
    
  );
}
