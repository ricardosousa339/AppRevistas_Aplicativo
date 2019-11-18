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

  TelaRevista({Key key, @required this.idRevista, @required this.nomeRevista});
  @override
  _TelaRevistaState createState() => _TelaRevistaState();
}

class _TelaRevistaState extends State<TelaRevista> {
  PageController pgcontroller;
  String tituloAno;
  List anos = new List();

  List gradee;
  PageView listaDeEdicoesPorAno = new PageView();

  List<Edicao> edicoes = new List();

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
        ),
        body: FutureBuilder(
          future: carregaEdicoes(),

          builder: (context, snapshot) {
            return gradeEdicoes();
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

    setState(() {
      edicoes = list;
    });
    //print('listaaaa de edicoes:' + list.toString());
    return list;
  }

  GridView gradeEdicoes() {
    ordenaEdicoesPorAno(edicoes);

    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(edicoes.length, (indice) {
        return GestureDetector(
            child: Card(
                child: Container(
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
              children: <Widget>[
                Image.asset('images/default_logo.png'),
                Container(
                  color: Colors.black54,
                  //padding: EdgeInsets.fromLTRB(5, 100, 5, 5),
                  child: Text(
                    edicoes[indice].nomePortugues,
                    style: TextStyle(fontSize: 25,color: Colors.white),
                  ),
                )
              ],
            ))),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TelaEdicao(
                        nomeRevista: widget.nomeRevista,
                            idEdicao: edicoes[indice].id,
                          )));
            });
      }),
    );
  }

  List<Edicao> ordenaEdicoesPorAno(List<Edicao> edicoes) {
    edicoes.sort((a, b) => a.dataDeLancamento.compareTo(b.dataDeLancamento));
    return edicoes;
  }

/*

//Checa quais anos contem as edicoes, os salva em uma lista e chama a funcao que os utiliza para carregar as edicoes
  getAnosDasEdicoes() async {
    String uri =
        "http://matheusjv14.pythonanywhere.com/api/get-edicoesdarevista/" +
            widget.idRevista.toString();

    var response = await http
        .get(Uri.encodeFull(uri), headers: {"Accept": "application/json"});

    setState(()  {
      List extractData = json.decode(utf8.decode(response.bodyBytes));

      List anos = new List();
      for (var item in extractData) {
        String aux = item["data_lancamento"];
        aux = aux.split("-")[0];

        if (!anos.contains(aux)) anos.add(aux);
      }

      print("anos:" + anos.toString());
      listaDeEdicoesPorAno =  paginasAnos(anos);
    });
  }

 
//Utiliza a lista de anos anterior para buscar as edicoes por cada um dos anos

    Future<List<Edicao>> carregaEdicoesDeUmAno(String ano) async {
      List<Edicao> list;

      String uri =
          "http://matheusjv14.pythonanywhere.com/api/edicoes/?search=" + ano;

      var response = await http
          .get(Uri.encodeFull(uri), headers: {"Accept": "application/json"});

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        var rest = data as List;
        print('rest'+rest.toString());
        list = rest.map<Edicao>((json) => Edicao.fromJson(json)).toList();
      }
      return list;
    }

    PageView paginasAnos(List anos) {
      return PageView.builder(
        itemCount: anos.length,
        itemBuilder: (context, position) {
          return FutureBuilder(
            future: carregaEdicoesDeUmAno(anos[position]),
            builder: (context, snapshot) {
              return snapshot.data != null
                  ? paginaDeCadaAnoEdicao(snapshot.data)
                  : Center(child: CircularProgressIndicator());
            },
          );
        },
      );
    }

    GridView paginaDeCadaAnoEdicao(List<Edicao> edicoesDeUmAno) {
      return GridView.count(
          crossAxisCount: 2,
          scrollDirection: Axis.vertical,
          children: List.generate(edicoesDeUmAno.length, (index) {
            print('aas'+edicoesDeUmAno[index].nomePortugues);
            return Card(
              child: Text(edicoesDeUmAno[index].nomePortugues),
            );
          }));
    }
    */
}
