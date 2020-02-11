//Padronização do bloco de notícias

import 'package:apprevistas_aplicativo/pages/tela_inicio/fragments/cores.dart';
import 'package:apprevistas_aplicativo/pages/tela_inicio/model/noticia.dart';
import 'package:apprevistas_aplicativo/pages/tela_inicio/view/tela_noticia.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

Card cardBlocoNoticia(Noticia noticia, BuildContext context, String idDoUsuario, String keyy) {
  return Card(
    shape: Border.all(width: 0),
      margin: EdgeInsets.fromLTRB(0, 5, 0, 10),
      
      elevation: 0.0,
      child: Column(children: <Widget>[
        Row(
          children: <Widget>[
            Spacer(),
            Expanded(child: 
            Container(
                margin: EdgeInsets.fromLTRB(18, 10, 18, 0),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                  border: new Border.all(color: corTerciaria, width: 1.5),
                ),
                child: 
                Text(
                

                  noticia.objetoRevista.nomeRevistaPortugues,
                  style: TextStyle(color: corTerciaria),
                  maxLines: 1,
                  
                  overflow: TextOverflow.ellipsis,
                )),)
          ],
        ),
        ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TelaNoticia(noticia: noticia, idDoUsuario: idDoUsuario , keyy: keyy)));
          },
          contentPadding: EdgeInsets.fromLTRB(18, 5, 18, 18),
          title: Text(noticia.titulo,
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          subtitle: Text(
             noticia.subtitulo,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          trailing: GestureDetector(
            child: Icon(Icons.share),
            onTap: () {
              Share.share(
                  noticia.linkArtigo);
            },
          ),
        ),
      ]));
}
