import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:apprevistas_aplicativo/pages/tela_revista/model/revista.dart';
import 'package:http/http.dart' as http;

class Noticia{

Noticia({this.id,this.titulo, this.subtitulo, this.corpo, this.dataPostagem, this.autor, this.revista, this.linkArtigo,this.imagem, this.arquivoImagem, this.objetoRevista, this.nomeAutor});

  String id;
  String titulo;
  String subtitulo;
  String corpo;
  String dataPostagem;
  String autor;
  String nomeAutor;
 
  String revista;
  Revista objetoRevista;
  String linkArtigo;
  String imagem;
  Uint8List arquivoImagem;


//Quando mudar a fonte de dados, só trocar as chaves pra pegar as corretas do banco de dados e salvar como noticia
factory Noticia.fromJson(Map<String, dynamic> json){


  var revistaJson = json['revista_relacionada'];
    Revista revista =
        revistaJson != null ? Revista.fromJson(revistaJson) : null;

  return Noticia(
    id:json['id'].toString(),
    titulo: json['titulo'],
    subtitulo: json['subtitulo'],
    corpo: json['corpo'],
    dataPostagem: json['data_postagem'],
    autor: json['autor'].toString(),
    objetoRevista : revista,
    linkArtigo: json['link_artigo'],
    imagem: json['imagem'],
    nomeAutor: json['nome_autor']
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