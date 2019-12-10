import 'dart:convert';

import 'package:apprevistas_aplicativo/constantes.dart';
import 'package:apprevistas_aplicativo/pages/tela_artigo/controller/desfavorita_artigo.dart';
import 'package:apprevistas_aplicativo/pages/tela_artigo/controller/favorita_artigo.dart';
import 'package:apprevistas_aplicativo/pages/tela_inicio/fragments/cores.dart';
import 'package:apprevistas_aplicativo/pages/tela_login/view/solicita_login.dart';
import 'package:apprevistas_aplicativo/pages/tela_revista/model/artigo.dart';
import 'package:apprevistas_aplicativo/pages/tela_revista/model/revista.dart';
import 'package:apprevistas_aplicativo/urls.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:share/share.dart';
import 'package:open_file/open_file.dart';
import 'package:url_launcher/url_launcher.dart';

class TelaArtigo extends StatefulWidget {
  final Artigo artigo;
  final String revista;
  String idUsuario;
  String keyy;
  bool estaNaPaginaFav;
  String data;

  TelaArtigo({Key key, @required this.artigo, @required this.revista, this.idUsuario, this.keyy, this.estaNaPaginaFav,this.data})
      : super(key: key);

  @override
  _TelaArtigoState createState() => _TelaArtigoState();
}

class _TelaArtigoState extends State<TelaArtigo> {
  String autores;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();





  
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
      key: _scaffoldKey,
    appBar: AppBar(
      backgroundColor: corPrincipal,
      title: Text(widget.revista,)),
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: true,     
          body:   ListView(
            padding: EdgeInsets.only(bottom: 80, top: 20),
            children: <Widget>[
              ListTile(
                title: Text(widget.artigo.tituloPortugues, style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: corTitulos)),
              ),
              Divider(color: Colors.black54,indent: 30,endIndent: 30,),
              ListTile(
                contentPadding: EdgeInsets.all(5),
                title: Text('Autor(es):', style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Text(autores),
                leading: Icon(Icons.person),
              ),




              widget.data != null ?
              ListTile(
                
                leading: Icon(Icons.calendar_today),
                contentPadding: EdgeInsets.all(5),
                title: Text('Data:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold) ),
                //TODO: Ajustar quando o Matheus colocar a Data
                subtitle: Text(widget.data,
              )) : Text(''),
              Divider(color: Colors.black45,indent: 30, endIndent: 30,),
              ListTile(
                  contentPadding: EdgeInsets.all(17),
                  title: Text('Descrição:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: corSubtitulos,)),
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
            backgroundColor: corTerciaria,
            heroTag: null,
            child: Icon(Icons.share),
            onPressed: () {
              Share.share(widget.artigo.linkPdf);
            },
          ),
          FloatingActionButton(
            backgroundColor: corTerciaria,
            heroTag: null,
            child: Icon(Icons.picture_as_pdf),
            onPressed: () {
              _launchURL(widget.artigo.linkPdf.replaceAll('/view/', '/download/'));
            },
          ),
          FloatingActionButton(
            backgroundColor: corTerciaria,
            heroTag: null,
            child: widget.estaNaPaginaFav ? Icon(Icons.delete) : Icon(Icons.star),
            onPressed: () async {
              if(widget.idUsuario != null){
                if (widget.estaNaPaginaFav == true) {
                 var res =  await desFavoritaArtigo(widget.idUsuario, widget.artigo.id, widget.keyy);
                String mensagem;
                if(res.statusCode!= 200){
                  mensagem = json.decode(res.body)[0];

                }
                else {
                  mensagem = 'Artigo removido dos favoritos';

                  print(res);
                }
                 final snackBar = SnackBar(content: Text(mensagem));

                  _scaffoldKey.currentState.showSnackBar(snackBar); 
                }
                else{
                var res = await favoritaArtigo(widget.idUsuario, widget.artigo.id, widget.keyy);
                String mensagem;
                if(res.statusCode!= 200){
                  mensagem = json.decode(res.body)[0];

                }
                else {
                  mensagem = 'Artigo adicionado aos favoritos';

                  
                  print(res);
                }
                final snackBar = SnackBar(content: Text(mensagem));

                  _scaffoldKey.currentState.showSnackBar(snackBar); 
                }
              }
              else{
                solicitaLogin(context, Constantes.FLAG_TELA_ARTIGO, artigo:widget.artigo, revista: widget.revista);
              }
            },
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


}
