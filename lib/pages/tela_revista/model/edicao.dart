import 'package:apprevistas_aplicativo/pages/tela_revista/model/revista.dart';

import 'artigo.dart';

class Edicao{

Edicao({this.issn, this.revista, this.nome, this.artigos});
String issn;
String revista;
String nome;
List<Artigo> artigos;

}