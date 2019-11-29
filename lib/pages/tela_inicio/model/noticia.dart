import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

class Noticia{

Noticia({this.id,this.titulo, this.subtitulo, this.corpo, this.dataPostagem, this.autor, this.revista, this.linkArtigo,this.imagem, this.arquivoImagem});

  String id;
  String titulo;
  String subtitulo;
  String corpo;
  String dataPostagem;
  String autor;
 
  String revista;
  String linkArtigo;
  String imagem;
  Uint8List arquivoImagem;


//Quando mudar a fonte de dados, só trocar as chaves pra pegar as corretas do banco de dados e salvar como noticia
factory Noticia.fromJson(Map<String, dynamic> json){
  return Noticia(
    id:json['id'].toString(),
    titulo: json['titulo'],
    subtitulo: json['subtitulo'],
    corpo: json['corpo'],
    dataPostagem: json['data_postagem'],
    autor: json['autor'].toString(),
    revista : json['revista_relacionada'].toString(),
    linkArtigo: json['link_artigo'],
    imagem: json['imagem'],
  );
}

 Map toMap() {
    var map = new Map<String, dynamic>();
   
    map["titulo"] = titulo;
    map["subtitulo"] = subtitulo;
    map['corpo'] = corpo;
    map['revista_relacionada'] = revista;
    map['link_artigo'] = linkArtigo;
    map['imagem'] = arquivoImagem;
 
    return map;
  }

}