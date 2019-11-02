//Padronização do bloco de notícias

import 'package:apprevistas_aplicativo/pages/tela_inicio/model/noticia.dart';
import 'package:apprevistas_aplicativo/pages/tela_inicio/view/tela_noticia.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

Card cardBlocoNoticia(Noticia noticia, BuildContext context) {
  return Card(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
      elevation: 4.0,
      child: Column(children: <Widget>[
        Row(
          children: <Widget>[
            Container(
                margin: EdgeInsets.fromLTRB(18, 10, 18, 0),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                  border: new Border.all(color: Colors.red, width: 1.5),
                ),
                child: Text(
                  noticia.revista,
                  style: TextStyle(color: Colors.red),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )),
          ],
        ),
        ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TelaNoticia(noticia: noticia)));
          },
          contentPadding: EdgeInsets.fromLTRB(18, 5, 18, 18),
          title: Text(noticia.titulo,
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          subtitle: Text(
            noticia.id.toString() + ' ' + noticia.conteudo,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          trailing: GestureDetector(
            child: Icon(Icons.share),
            onTap: () {
              Share.share(
                  'https://sistemas.uft.edu.br/periodicos/index.php/observatorio');
            },
          ),
        ),
      ]));
}
