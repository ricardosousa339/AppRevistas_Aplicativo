import 'package:apprevistas_aplicativo/pages/tela_revista/model/edicao.dart';
import 'package:apprevistas_aplicativo/pages/tela_revista/model/revista.dart';
import 'package:apprevistas_aplicativo/pages/tela_revista/view/tela_edicao.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TelaEdicoes extends StatefulWidget{
  final Revista revista;
  
  TelaEdicoes({Key key, @required this.revista});
  @override
  _TelaEdicoesState createState() => _TelaEdicoesState();

}

class _TelaEdicoesState extends State<TelaEdicoes>{


  
  @override
  void initState() {


    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edições'),),
      body: Container(
        child: ListView.builder(
          itemCount: edicoess().length,
          itemBuilder: (context, index){
            
            
            /*return ListTile(
              title: Text(widget.revista.edicoes[index].nome),
              subtitle: Text(widget.revista.edicoes[index].issn),
              onTap: (){
                 Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TelaEdicao(edicao: widget.revista.edicoes[index])));

              },
            );
            */
            return ListView.builder(
              itemCount: edicoess()[index].length,
              itemBuilder: (contexto, indice){
                return Image.network(edicoess()[index][indice].urlDaCapa);
              },
            );
          },
        )
      ),
    );
  }

  List<Edicao> edicoesPorAno(int ano){
    List<Edicao> edic = new List();
    for (var edicAtual in widget.revista.edicoes) {
      if(edicAtual.ano == ano)
      edic.add(edicAtual);
    }
  }

  List<List<Edicao>> edicoess(){
    List<List<Edicao>> todasEdicoes = new List();

    todasEdicoes.add(edicoesPorAno(2015));
    todasEdicoes.add(edicoesPorAno(2016));
    todasEdicoes.add(edicoesPorAno(2017));
    todasEdicoes.add(edicoesPorAno(2018));
    todasEdicoes.add(edicoesPorAno(2019));

  }
}