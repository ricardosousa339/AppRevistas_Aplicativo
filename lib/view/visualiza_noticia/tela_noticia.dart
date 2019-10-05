
import 'package:apprevistas_aplicativo/model/noticia.dart';
import 'package:apprevistas_aplicativo/view/fragments/textoCorpoNoticia.dart';
import 'package:apprevistas_aplicativo/view/fragments/textoTituloNoticia.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TelaNoticia extends StatefulWidget {
  final Noticia noticia;

  TelaNoticia({Key key, @required this.noticia}) : super(key: key);

  @override
  _TelaNoticiaState createState() => _TelaNoticiaState();
}

class _TelaNoticiaState extends State<TelaNoticia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text("Revista Observatório",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,

                      )),
                  background: Image.asset(
                    'images/443.jpg',
                    fit: BoxFit.cover,
                  )),
            ),
          ];
        },
        body: Column(children: <Widget>[
 ListTile(
   contentPadding: EdgeInsets.all(13),
            title: textoTituloNoticia(widget.noticia.titulo),
            subtitle: textoCorpoNoticia(widget.noticia.conteudo),
          ),
        ],)
        
        ),
    );
  }

 

 


 
}
