
import 'package:apprevistas_aplicativo/conteudo/noticia.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TelaNoticia extends StatefulWidget{
  
  Noticia noticia;

  TelaNoticia({Key key, @required this.noticia}) : super(key: key);

@override
  _TelaNoticiaState createState() => _TelaNoticiaState();

}

class _TelaNoticiaState extends State<TelaNoticia>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notícia'),
      ),
      body: corpoNoticia(),
    );
  }

Column corpoNoticia(){
  return Column(children: <Widget>[
    Image.asset('images/443.jpg'),
    textoTituloNoticia(widget.noticia.titulo),
    textoCorpoNoticia(widget.noticia.conteudo)
  ],);
}

Text textoTituloNoticia(String texto){
  return Text(texto, style: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20
  ),);
}

Text textoCorpoNoticia(String texto){
  return Text(texto);
  
}
}
