import 'edicao.dart';

class Artigo {

Artigo ({this.ano, this.autores, this.descricao, this.dia, this.identifier, this.edicao, this.mes, this.titulo, this.relation, this.resource_identifier,this.setSpec, this.source});

  String ano;
  List<String> autores;
  String descricao;
  String dia;
  Edicao edicao;
  String identifier;
  String mes;
  String relation;
  String resource_identifier;
  String setSpec;
  String source;
  String titulo;
  


}