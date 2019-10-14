import 'package:apprevistas_aplicativo/pages/tela_revista/model/edicao.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TelaEdicao extends StatefulWidget{
  final Edicao edicao;
  
  TelaEdicao({Key key, @required this.edicao}) : super(key : key);

   @override
  _TelaEdicaoState createState() => _TelaEdicaoState();


}

class _TelaEdicaoState extends State<TelaEdicao>{
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Text('Artigos'),),
      body: ListView.builder(
        itemCount: widget.edicao.artigos.length,
        itemBuilder: (context, index){
          return ListTile(
            title: Text(widget.edicao.artigos[index].titulo),
            subtitle: Text(widget.edicao.artigos[index].ano),
          );
        },
      ),
    );
  }
  
 
}