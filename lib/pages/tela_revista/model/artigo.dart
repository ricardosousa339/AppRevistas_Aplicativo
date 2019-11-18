import 'package:apprevistas_aplicativo/pages/tela_revista/model/categoria.dart';
import 'package:apprevistas_aplicativo/pages/tela_revista/model/palavra_chave.dart';

import 'autor.dart';
import 'edicao.dart';

class Artigo {
  Artigo(
      {this.autores,
      this.id,
      this.palavrasChave,
      this.categoria,
      this.tituloPortugues,
      this.tituloEnglish,
      this.descricaoPortugues,
      this.descricaoEnglish,
      this.identifier,
      this.linkPdf,
      this.idEdicao});

  List<Autor> autores;
  String id;
  List<PalavraChave> palavrasChave;
  Categoria categoria;
  String tituloPortugues;
  String tituloEnglish;
  String descricaoPortugues;
  String descricaoEnglish;
  String identifier;
  String linkPdf;
  String idEdicao;

  factory Artigo.fromJson(Map<String, dynamic> json) {
    var categoriaJson = json['categoria'];
    Categoria categoria =
        categoriaJson != null ? Categoria.fromJson(categoriaJson) : null;

    var autoresJson = json['autores'] as List;
    List<Autor> autores = autoresJson != null
        ? autoresJson.map((i) => Autor.fromJson(i)).toList()
        : null;

    var palavrasChaveJson = json['palavras_chave'] as List;
    List<PalavraChave> palavrasChave = palavrasChaveJson != null
    ? palavrasChaveJson.map((i) => PalavraChave.fromJson(i)).toList()
    : null;

    return Artigo(
      palavrasChave: palavrasChave,
        autores: autores,
        categoria: categoria,
        id: json['id'].toString(),
        tituloPortugues: json['titulo_portugues'],
        tituloEnglish: json['titulo_english'],
        descricaoPortugues: json['descricao_portugues'],
        descricaoEnglish: json['descricao_english'],
        identifier: json['identifier'],
        linkPdf: json['link_pdf'],
        idEdicao: json['edicao'].toString());
  }
}
