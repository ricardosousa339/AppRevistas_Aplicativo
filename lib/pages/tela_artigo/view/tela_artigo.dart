import 'package:apprevistas_aplicativo/pages/tela_revista/model/artigo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:share/share.dart';
import 'package:open_file/open_file.dart';

class TelaArtigo extends StatefulWidget {
  final Artigo artigo;

  TelaArtigo({Key key, @required this.artigo}) : super(key: key);

  @override
  _TelaArtigoState createState() => _TelaArtigoState();
}

class _TelaArtigoState extends State<TelaArtigo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 150.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: false,
                    title: Text('Artigo'
                    ,
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
                 ),
              ),
            ];
          },
          body: Column(
            children: <Widget>[

              ListTile(title: Text(widget.artigo.titulo),
              ),
               ListTile(
                contentPadding: EdgeInsets.all(13),
                title: Text('Autor(es)'),
                subtitle:Text(widget.artigo.autores[0]+(widget.artigo.autores.length == 1 ? "" : "et al."))),
              ListTile(
                contentPadding: EdgeInsets.all(13),
                title: Text('Data de publicação'),
                subtitle:Text(widget.artigo.dia+widget.artigo.mes+widget.artigo.ano),
              ),
              ListTile(
                contentPadding: EdgeInsets.all(13),
                title: Text('Descrição'),
                subtitle:Text(widget.artigo.descricao),
              ),
             
              
            ],
          )),

          floatingActionButton: ButtonBar(children: <Widget>[
            FloatingActionButton(heroTag: null, child: Icon(Icons.share),onPressed: (){Share.share('https://sistemas.uft.edu.br/periodicos/index.php/observatorio/article/view/7221');},),
            FloatingActionButton(heroTag: null, child: Icon(Icons.picture_as_pdf),onPressed: (){OpenFile.open('sdcard/Rg.pdf');},),
            FloatingActionButton(heroTag: null, child: Icon(Icons.star),onPressed: (){},),
            FloatingActionButton(heroTag: null, child: Icon(Icons.comment),onPressed: (){},)
          ],),
    );
  }
}
