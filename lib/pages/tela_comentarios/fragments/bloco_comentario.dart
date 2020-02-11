import 'package:apprevistas_aplicativo/pages/tela_comentarios/model/comentario.dart';
import 'package:flutter/material.dart';

blocoComentario(Comentario comentario, BuildContext context) {
  return Padding(
      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: Card(
        
        elevation: 0,
          child: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0,5),
        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(children: <Widget>[
              Icon(Icons.person,color: Colors.black45,),
              Text(
                ' '+comentario.autor,
                style: TextStyle(fontSize: 17,color:Colors.black45, fontWeight: FontWeight.bold),
              )
            ]),
            //Divider(),
            Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  ' '+comentario.corpo,
                  style: TextStyle(fontSize: 18,),
                  textAlign: TextAlign.left,
                ))
          ],
        ),
      )));
}
