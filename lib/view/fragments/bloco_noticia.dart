//Padronização do bloco de notícias

  import 'package:apprevistas_aplicativo/model/noticia.dart';
import 'package:apprevistas_aplicativo/view/visualiza_noticia/tela_noticia.dart';
import 'package:flutter/material.dart';

Card cardBlocoNoticia(Noticia noticia, BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
      elevation: 4.0,
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TelaNoticia(noticia: noticia)));
        },
        contentPadding: EdgeInsets.all(18),
        title: Text(noticia.titulo,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text(
          noticia.id.toString() + ' ' + noticia.conteudo,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
        ),
      ),
    );
  }
