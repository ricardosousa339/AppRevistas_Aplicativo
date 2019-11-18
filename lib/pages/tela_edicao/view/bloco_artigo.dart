
import 'package:apprevistas_aplicativo/pages/tela_artigo/view/tela_artigo.dart';
import 'package:apprevistas_aplicativo/pages/tela_revista/model/artigo.dart';
import 'package:apprevistas_aplicativo/pages/tela_revista/model/revista.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

Card cardBlocoArtigo(String revista, Artigo artigo, BuildContext context) {
  return Card(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
      elevation: 4.0,
      child: Column(children: <Widget>[
       
        ListTile(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TelaArtigo(revista: revista, artigo: artigo)));
          },
          contentPadding: EdgeInsets.fromLTRB(18, 5, 18, 18),
          title: Text(artigo.tituloPortugues,
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          subtitle: Text(
            artigo.descricaoPortugues,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          trailing: GestureDetector(
            child: Icon(Icons.share),
            onTap: () {
              Share.share(
                  artigo.linkPdf);
            },
          ),
        ),
      ]));
}
