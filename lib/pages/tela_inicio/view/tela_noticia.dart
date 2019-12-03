import 'package:apprevistas_aplicativo/pages/tela_comentarios/view/tela_comentarios.dart';
import 'package:apprevistas_aplicativo/pages/tela_inicio/fragments/textoCorpoNoticia.dart';
import 'package:apprevistas_aplicativo/pages/tela_inicio/fragments/textoTituloNoticia.dart';
import 'package:apprevistas_aplicativo/pages/tela_inicio/model/noticia.dart';
import 'package:apprevistas_aplicativo/pages/visualiza_link/view/visualiza_artigo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class TelaNoticia extends StatefulWidget {
  final Noticia noticia;
  final String idDoUsuario;
  final String keyy;

  TelaNoticia({Key key, @required this.noticia, @required this.keyy, @required this.idDoUsuario}) : super(key: key);

  @override
  _TelaNoticiaState createState() => _TelaNoticiaState();
}

class _TelaNoticiaState extends State<TelaNoticia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.noticia.objetoRevista.nomeRevistaPortugues),
        ),
        body: ListView(
          padding: EdgeInsets.only(bottom: 80, top: 20),
          children: <Widget>[
            ListTile(
              title: Text(
                widget.noticia.titulo,
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 163, 0, 0)),
              ),
            ),
            Divider(
              color: Colors.black26,
              indent: 30,
              endIndent: 30,
            ),

            //title: Text('Descrição:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255,100,3,3),)),
            //TODO: Achar solução pra retirar essas partes erradas

            Padding(
              child: Text(widget.noticia.subtitulo,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                  )),
              padding:
                  EdgeInsets.only(left: 30, top: 10, bottom: 10, right: 30),
            ),

            Image.network(widget.noticia.imagem, fit: BoxFit.fitWidth,height: 250,),

            //Divider(color: Colors.black26,indent: 30,endIndent: 30,),
            ListTile(
              title: Text(
                'Autor(a)',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(widget.noticia.autor),
              leading: Icon(Icons.person),
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),

              title: Text('Data:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              //TODO: Ajustar quando o Matheus colocar a Data
              subtitle: Text(widget.noticia.dataPostagem.substring(0, 10)),
            ),

            Padding(
                padding: EdgeInsets.all(30),
                child: Center(
                  child: Text(
                    widget.noticia.corpo,
                    style: TextStyle(fontSize: 18),
                  ),
                ))
          ],
        ),
        floatingActionButton: ButtonBar(
          children: <Widget>[
            FloatingActionButton(
                tooltip: 'Comentários',
                heroTag: null,
                child: Icon(Icons.comment),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              TelaComentarios(idNoticia: widget.noticia.id, idDoUsuario: widget.idDoUsuario, keyy: widget.keyy,)));
                }),
            FloatingActionButton(
              tooltip: 'Artigo relacionado',
              heroTag: null,
              child: Icon(Icons.link),
              onPressed: () {
                /*Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        VisualizaArtigo(url: widget.noticia.linkArtigo)));
                        */

                _launchURL(widget.noticia.linkArtigo);
              },
            )
          ],
        ));
  }

  _launchURL(String uri) async {
    var url = uri;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
