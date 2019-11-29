import 'package:apprevistas_aplicativo/pages/tela_revista/model/artigo.dart';
import 'package:apprevistas_aplicativo/pages/tela_revista/model/revista.dart';
import 'package:apprevistas_aplicativo/urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:share/share.dart';
import 'package:open_file/open_file.dart';
import 'package:url_launcher/url_launcher.dart';

class TelaArtigo extends StatefulWidget {
  final Artigo artigo;
  final String revista;

  TelaArtigo({Key key, @required this.artigo, @required this.revista})
      : super(key: key);

  @override
  _TelaArtigoState createState() => _TelaArtigoState();
}

class _TelaArtigoState extends State<TelaArtigo> {
  String autores;

  @override
  void initState() {
    autores = "";
    for (var item in widget.artigo.autores) {
      autores += item.nomeAutor + ", ";
    }
    autores = autores.substring(0, autores.length - 3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(title: Text(widget.revista,)),
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,     
          body:   ListView(
            padding: EdgeInsets.only(bottom: 80, top: 20),
            children: <Widget>[
              ListTile(
                title: Text(widget.artigo.tituloPortugues, style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Color.fromARGB(255,163,0,0)),),
              ),
              Divider(color: Colors.black54,indent: 30,endIndent: 30,),
              ListTile(
                contentPadding: EdgeInsets.all(5),
                title: Text('Autor(es):', style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Text(autores),
                leading: Icon(Icons.person),
              ),
              ListTile(
                
                
                leading: Icon(Icons.calendar_today),
                contentPadding: EdgeInsets.all(5),
                title: Text('Data:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold) ),
                //TODO: Ajustar quando o Matheus colocar a Data
                subtitle: Text('22/09/2018'),
              ),
              Divider(color: Colors.black45,indent: 30, endIndent: 30,),
              ListTile(
                  contentPadding: EdgeInsets.all(17),
                  title: Text('Descrição:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255,100,3,3),)),
                  //TODO: Achar solução pra retirar essas partes erradas
                  
                  subtitle: Padding(child: Text(
                    "\t"+widget.artigo.descricaoPortugues.replaceAll("&nbsp;", " "), style: TextStyle(color: Colors.black87, fontSize: 16,))
                  ,padding: EdgeInsets.only(left: 10, top: 10),),
                  
                  
                  ),
                  
            ],
          ),
      floatingActionButton: ButtonBar(
        children: <Widget>[
          FloatingActionButton(
            heroTag: null,
            child: Icon(Icons.share),
            onPressed: () {
              Share.share(widget.artigo.linkPdf);
            },
          ),
          FloatingActionButton(
            heroTag: null,
            child: Icon(Icons.picture_as_pdf),
            onPressed: () {
              _launchURL(widget.artigo.linkPdf);
            },
          ),
          FloatingActionButton(
            heroTag: null,
            child: Icon(Icons.star),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  _launchURL(String uri) async {
  var url =uri;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

adicionaArtigoAosFavoritos (){
  String url = raizApi + '/api/add-artigofavoritousuario/';
}
}
