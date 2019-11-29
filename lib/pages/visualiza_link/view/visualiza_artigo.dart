
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VisualizaArtigo extends StatefulWidget{

VisualizaArtigo({this.url});

  String url;
  _VisualizaArtigoState createState() => _VisualizaArtigoState();

}

class _VisualizaArtigoState extends State<VisualizaArtigo>{
  @override
  Widget build(BuildContext context) {
    return WebView(initialUrl: widget.url);
  }
  
}