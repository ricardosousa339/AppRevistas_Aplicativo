

import 'artigo.dart';

class Edicao{

Edicao({this.id, this.nomePortugues, this.nomeEnglish, this.idDaRevista, this.dataDeLancamento});
String id;
String nomePortugues;
String nomeEnglish;
String idDaRevista;
String dataDeLancamento;


factory Edicao.fromJson(Map<String, dynamic> json){
  return Edicao(
   
    id: json['id'].toString(),
    nomePortugues: json['edicao_portugues'],
    nomeEnglish: json['edicao_english'],
    idDaRevista: json['revista_id'].toString(),
    dataDeLancamento: json['data_lancamento'],

     );
}
}