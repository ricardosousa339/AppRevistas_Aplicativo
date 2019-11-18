import 'edicao.dart';

class Revista{

  Revista( {this.id,this.issn, this.nomeRevistaPortugues, this.nomeRevistaEnglish});

  String id;
  String issn;
  String nomeRevistaPortugues;
  String nomeRevistaEnglish;

  factory Revista.fromJson(Map<String, dynamic> json){
    return Revista(
      id: json['id'].toString(),
      issn: json['issn'],
      nomeRevistaPortugues: json['nome_revista_portugues'],
      nomeRevistaEnglish: json['nome_revista_english']
    );

  }

}