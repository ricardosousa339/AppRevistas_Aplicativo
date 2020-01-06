import 'package:apprevistas_aplicativo/pages/tela_edicao/view/tela_edicao.dart';
import 'package:apprevistas_aplicativo/pages/tela_inicio/fragments/cores.dart';
import 'package:apprevistas_aplicativo/pages/tela_revista/controller/carrega_edicoes.dart';
import 'package:apprevistas_aplicativo/pages/tela_revista/fragments/blocos_edicoes_revistas.dart';
import 'package:apprevistas_aplicativo/pages/tela_revista/model/edicao.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../urls.dart';

class TelaRevista extends StatefulWidget {
  final String idRevista;
final String nomeRevista;
final idUsuario;
String keyy;

  TelaRevista({Key key, @required this.idRevista, @required this.nomeRevista, this.keyy, this.idUsuario});
  @override
  _TelaRevistaState createState() => _TelaRevistaState();
}

class _TelaRevistaState extends State<TelaRevista> {
  PageController pgcontroller;
  String tituloAno;
  List anos = new List();

  List gradee;
  PageView listaDeEdicoesPorAno = new PageView();


  @override
  void initState() {
    pgcontroller = PageController();
    var currentPageValue = 0.0;
    tituloAno = 'Edições';

    //getAnosDasEdicoes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(tituloAno),
          backgroundColor: corPrincipal,
        ),
        body: FutureBuilder(
          future: carregaEdicoes(),

          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }
            else if(snapshot.connectionState == ConnectionState.done){
            return gradeEdicoes(snapshot.data);
            }
            else{
              return Text('Houve um problema');
            }
          },

          // : Center(child: CircularProgressIndicator());
        ));
  }

  Future<List<Edicao>> carregaEdicoes() async {
    List<Edicao> list;

    String uri =
        raizApi+'/api/get-edicoesdarevista/' +
            widget.idRevista;

    var response = await http
        .get(Uri.encodeFull(uri), headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var rest = data as List;
      //print('rest'+rest.toString());
      list = rest.map<Edicao>((json) => Edicao.fromJson(json)).toList();
      //print('listaaaa de edicoes:' + list.toString());
    }

 
    //print('listaaaa de edicoes:' + list.toString());
    return list;
  }

  GridView gradeEdicoes(List<Edicao> edicoes) {
    ordenaEdicoesPorAno(edicoes);

    return GridView.count(
      childAspectRatio: 3/4,
      crossAxisCount: 2,
      children: List.generate(edicoes.length, (indice) {
        
        return blocoEdicao(edicoes, indice, context, widget.keyy, widget.nomeRevista, widget.idUsuario);
        
      }),
    );
  }

  List<Edicao> ordenaEdicoesPorAno(List<Edicao> edicoes) {
    //edicoes.sort((a, b) => a.dataDeLancamento.compareTo(b.dataDeLancamento));
    return edicoes;
  }

}
