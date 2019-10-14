//Padronização do bloco de notícias

import 'package:apprevistas_aplicativo/pages/tela_inicio/model/noticia.dart';
import 'package:apprevistas_aplicativo/pages/tela_inicio/view/tela_noticia.dart';
import 'package:flutter/material.dart';

Card cardBlocoNoticia(Noticia noticia, BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
      elevation: 0.0,
      child: ListTile(
      trailing: Container(alignment: Alignment.center, decoration: BoxDecoration(border: new Border.all(color: Colors.red, width: 1.5), ), child: Text(noticia.revista, style: TextStyle(color: Colors.red),maxLines: 1,overflow: TextOverflow.ellipsis,),width: 50,height: 25,),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TelaNoticia(noticia: noticia)));
        },
        contentPadding: EdgeInsets.fromLTRB(18, 10, 18, 18),
        title: Text(noticia.titulo,
            style: TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.bold)),
        subtitle: Text(
          noticia.id.toString() + ' ' + noticia.conteudo,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
      ),
    );
  }
