import 'dart:convert';

import 'package:apprevistas_aplicativo/pages/tela_edicao/view/bloco_artigo.dart';
import 'package:apprevistas_aplicativo/pages/tela_revista/model/artigo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../../../urls.dart';


class TelaEdicao extends StatefulWidget {
  final String idEdicao;
  final String nomeRevista;

  TelaEdicao({Key key, @required this.idEdicao, @required this.nomeRevista}) : super(key: key);

  @override
  _TelaEdicaoState createState() => _TelaEdicaoState();
}

class _TelaEdicaoState extends State<TelaEdicao> {
  
  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        title: Text('Artigos'),
      ),
      body: FutureBuilder(
        future: carregaArtigos(),
        builder: (context, snapshot){
          if(snapshot.data != null)
          return listaDeArtigo(snapshot.data);
          return Center(child: CircularProgressIndicator(),);
        },
      )

      
    );


    


  }

  Future <List<Artigo>> carregaArtigos() async {
    List<Artigo> list;

    String uri =
        raizApi+'/api/get-artigosdaedicao/'+widget.idEdicao;

    var response = await http
        .get(Uri.encodeFull(uri), headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      var data = json.decode(utf8.decode(response.bodyBytes));
      var rest = data as List;
      //print('rest'+rest.toString());
      list = rest.map<Artigo>((json) => Artigo.fromJson(json)).toList();
      print('listaaaa de artigos:' + list.toString());

      
    }


   
    return list;
  }



  ListView listaDeArtigo(List <Artigo> artigos){

    return ListView.builder(
      
      itemCount: artigos.length,
      itemBuilder: (context, indice){
        return Column(children: <Widget>[
           cardBlocoArtigo(widget.nomeRevista,artigos[indice], context),
           Divider(height: 10, color: Colors.black54,),
        ],);
        return cardBlocoArtigo(widget.nomeRevista,artigos[indice], context);
          },
    );

  }
  
}
