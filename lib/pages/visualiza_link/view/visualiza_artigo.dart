
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VisualizaArtigo extends StatefulWidget{

VisualizaArtigo({this.url});

  String url;
  String titulo;
  _VisualizaArtigoState createState() => _VisualizaArtigoState();

}

class _VisualizaArtigoState extends State<VisualizaArtigo>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.titulo),),
      body: WebView(initialUrl: widget.url),
    );
  }
  
}