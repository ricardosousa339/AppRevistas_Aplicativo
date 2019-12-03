import 'package:apprevistas_aplicativo/pages/tela_comentarios/model/comentario.dart';
import 'package:flutter/material.dart';

blocoComentario(Comentario comentario, BuildContext context) {
  return Padding(
      padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
      child: Card(
        elevation: 5,
          child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(children: <Widget>[
              Icon(Icons.person),
              Text(
                comentario.autor,
                style: TextStyle(fontSize: 17),
              )
            ]),
            Divider(),
            Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  comentario.corpo,
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.left,
                ))
          ],
        ),
      )));
}
