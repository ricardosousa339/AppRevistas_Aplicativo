

import 'artigo.dart';

class Edicao{

Edicao({this.ano,this.urlDaCapa,this.issn, this.revista, this.nome, this.artigos});
String issn;
String revista;
String nome;
List<Artigo> artigos;
String urlDaCapa;
int ano;


factory Edicao.fromJson(Map<String, dynamic> json){
  return Edicao(
    issn: json['id'][0].toString().toUpperCase()+json['title'].toString().substring(1),
    revista: json['url'],
    ano:  json['albumId'],

     );
}
}