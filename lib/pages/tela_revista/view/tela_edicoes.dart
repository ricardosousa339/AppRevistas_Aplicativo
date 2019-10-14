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
          itemCount: widget.revista.edicoes.length,
          itemBuilder: (context, index){
            return ListTile(
              title: Text(widget.revista.edicoes[index].nome),
              subtitle: Text(widget.revista.edicoes[index].issn),
              onTap: (){
                 Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TelaEdicao(edicao: widget.revista.edicoes[index])));

              },
            );
          },
        )
      ),
    );
  }


}