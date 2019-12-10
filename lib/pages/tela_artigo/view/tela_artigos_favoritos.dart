import 'package:apprevistas_aplicativo/pages/tela_artigo/controller/carrega_artigo.dart';
import 'package:apprevistas_aplicativo/pages/tela_artigo/controller/carrega_ids_artigos_favoritos.dart';
import 'package:apprevistas_aplicativo/pages/tela_edicao/view/bloco_artigo.dart';
import 'package:apprevistas_aplicativo/pages/tela_inicio/fragments/cores.dart';
import 'package:apprevistas_aplicativo/pages/tela_revista/model/artigo.dart';
import 'package:apprevistas_aplicativo/pages/tela_revista/model/revista.dart';
import 'package:flutter/material.dart';

class TelaArtigosFavoritos extends StatefulWidget {
  final String idDoUsuario;
  final String idUsuarioServer;
  List<Revista> revistas;
  String keyy;

  TelaArtigosFavoritos({this.idDoUsuario, this.revistas, this.keyy, this.idUsuarioServer});

  _TelaArtigosFavoritosState createState() => _TelaArtigosFavoritosState();
}

class _TelaArtigosFavoritosState extends State<TelaArtigosFavoritos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: corPrincipal,
          title: Text('Artigos favoritos'),
        ),
        body: FutureBuilder(
          future: listaFavoritos(widget.idDoUsuario),
          builder:
              (BuildContext context, AsyncSnapshot<List<Artigo>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(),);
             
            } else {

               return ListView.builder(
                 
                 itemCount: snapshot.data.length,
                itemBuilder: (context, indice) {
                  int idRevista =
                      int.parse(snapshot.data[indice].categoria.idDaRevista);
                  String nomeDaRevista =
                      widget.revistas[idRevista].nomeRevistaPortugues;
                  return Column(
                    children: <Widget>[
                      cardBlocoArtigo(nomeDaRevista, snapshot.data[indice],
                      context, widget.keyy, widget.idUsuarioServer, true),
                      Divider(height: 10,)
                    ],
                  );
                  
                  
                  
                },
              );
            }
          },
        ));
  }

  Future<List<Artigo>> listaFavoritos(String idUsuario) async {
    List<String> ids =
        await carregaIdsFavoritos(widget.idDoUsuario, widget.keyy);

    List<Artigo> artigos = new List();

    for (String id in ids) {
      artigos.add(await carregaArtigo(id.toString()));
    }
    return artigos;
  }
}
