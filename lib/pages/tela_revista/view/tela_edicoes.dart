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


  List<List<Edicao>> edicoes;

  @override
  void initState() {

edicoes = edicoess();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edições '),),
      body: 
      
      GridView.count(
          // Cria um grid com duas colunas
          crossAxisCount: 2,
          // Gera 100 Widgets que exibem o seu índice
          children: List.generate(10, (index) {
            return GestureDetector(child: 
             Card(child:Image.network(widget.revista.edicoes[index].urlDaCapa,)
           )
           ,onTap: (){
              Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TelaEdicao( edicao:widget.revista.edicoes[index])));
           },
            );
            
          }),
      /*Container(
        child: ListView.builder(
          itemCount: edicoes.length,
          shrinkWrap: true,
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

            
            return Container(child: 
             ListView.builder(
               shrinkWrap: true,
               scrollDirection: Axis.horizontal,
              itemCount: edicoes[index].length,
              itemBuilder: (contexto, indice){
                return Image.network(edicoes[index][indice].urlDaCapa, height: 100,);
              },
            )
            ,);
            
          },
        )
      ),
      */
    ));
  }

  List<Edicao> edicoesPorAno(int ano){
    List<Edicao> edic = new List();
    for (var edicAtual in widget.revista.edicoes) {
      if(edicAtual.ano == ano)
      edic.add(edicAtual);
    }
    return edic;
  }

  List<List<Edicao>> edicoess(){
    List<List<Edicao>> todasEdicoes = new List();

    todasEdicoes.add(edicoesPorAno(2015));
    todasEdicoes.add(edicoesPorAno(2016));
    todasEdicoes.add(edicoesPorAno(2017));
    todasEdicoes.add(edicoesPorAno(2018));
    todasEdicoes.add(edicoesPorAno(2019));
    return todasEdicoes;
  }
}