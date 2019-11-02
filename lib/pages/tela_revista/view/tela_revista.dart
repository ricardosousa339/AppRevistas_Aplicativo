
import 'package:apprevistas_aplicativo/pages/tela_revista/fragments/blocos_edicoes_revistas.dart';
import 'package:apprevistas_aplicativo/pages/tela_revista/model/edicao.dart';
import 'package:apprevistas_aplicativo/pages/tela_revista/model/revista.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TelaRevista extends StatefulWidget {
  final Revista revista;

  TelaRevista({Key key, @required this.revista});
  @override
  _TelaRevistaState createState() => _TelaRevistaState();
}

class _TelaRevistaState extends State<TelaRevista> {
  List<List<Edicao>> edicoes;
  PageController pgcontroller;
  String tituloAno;

  @override
  void initState() {
    pgcontroller = PageController();
    var currentPageValue = 0.0;
   tituloAno = 'Edições';
    edicoes = edicoess();
     pgcontroller.addListener(() {
      setState(() {
        currentPageValue = pgcontroller.page;
        tituloAno = edicoes[currentPageValue.toInt()][0].ano.toString();
      });
    }); 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(tituloAno),
        ),
        body: pagina_das_edicoes_da_revista(widget.revista, edicoes, pgcontroller));
  }

  List<Edicao> edicoesPorAno(int ano) {
    List<Edicao> edic = new List();
    for (var edicAtual in widget.revista.edicoes) {
      if (edicAtual.ano == ano) edic.add(edicAtual);
    }
    return edic;
  }

  List<List<Edicao>> edicoess() {
    List<List<Edicao>> todasEdicoes = new List();

    todasEdicoes.add(edicoesPorAno(2015));
    todasEdicoes.add(edicoesPorAno(2016));
    todasEdicoes.add(edicoesPorAno(2017));
    todasEdicoes.add(edicoesPorAno(2018));
    todasEdicoes.add(edicoesPorAno(2019));
    return todasEdicoes;
  }



  
}
