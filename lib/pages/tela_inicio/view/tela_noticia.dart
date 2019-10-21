
import 'package:apprevistas_aplicativo/pages/tela_inicio/fragments/textoCorpoNoticia.dart';
import 'package:apprevistas_aplicativo/pages/tela_inicio/fragments/textoTituloNoticia.dart';
import 'package:apprevistas_aplicativo/pages/tela_inicio/model/noticia.dart';
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
              expandedHeight: 170.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(widget.noticia.revista,
                      style: TextStyle(
                        color: Colors.white,
                         shadows: [
        Shadow(
            blurRadius: 10.0,
            color: Colors.black87,
            offset: Offset(2.0, 2.0),
            ),
        ],
                        fontSize: 20.0,
                        

                      )),
                  background: Image.asset('images/Observatorio.png')),
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
