import 'dart:convert';

import 'package:apprevistas_aplicativo/pages/tela_busca_artigo/view/tela_busca_artigo.dart';
import 'package:apprevistas_aplicativo/pages/tela_edicao/controller/carrega_artigos_da_edicao.dart';
import 'package:apprevistas_aplicativo/pages/tela_edicao/view/bloco_artigo.dart';
import 'package:apprevistas_aplicativo/pages/tela_inicio/fragments/cores.dart';
import 'package:apprevistas_aplicativo/pages/tela_revista/model/artigo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../../../urls.dart';


class TelaEdicao extends StatefulWidget {
  final String idEdicao;
  final String nomeRevista;
  final String idUsuario;
  String keyy;

  TelaEdicao({Key key, @required this.idEdicao, @required this.nomeRevista,this.keyy, this.idUsuario}) : super(key: key);

  @override
  _TelaEdicaoState createState() => _TelaEdicaoState();
}

class _TelaEdicaoState extends State<TelaEdicao> {
  
  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        backgroundColor: corPrincipal,
        title: Text('Artigos'),
      ),
      body: FutureBuilder(
        future: carregaArtigosDaEdicao(widget.idEdicao),
        builder: (context, snapshot){
          if(snapshot.data != null)
          return listaDeArtigo(snapshot.data);
          return Center(child: CircularProgressIndicator(),);
        },
      ),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.search),onPressed: (){
       
        

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TelaBuscaArtigo(
                                  keyy: widget.keyy,
                                  idUsuario: widget.idUsuario)));
      },),

      
    );
  }

  ListView listaDeArtigo(List <Artigo> artigos){

    return ListView.builder(
      
      itemCount: artigos.length,
      itemBuilder: (context, indice){
        return Column(children: <Widget>[
           cardBlocoArtigo(widget.nomeRevista,artigos[indice], context, widget.keyy, widget.idUsuario,false),
           Divider(height: 10, color: Colors.black54,),
        ],);
       
          },
    );

  }
  
}
