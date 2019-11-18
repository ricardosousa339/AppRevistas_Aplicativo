class Noticia{

Noticia({this.id,this.titulo, this.subtitulo, this.corpo, this.dataPostagem, this.autor, this.revista, this.linkArtigo,this.imagem});

  String id;
  String titulo;
  String subtitulo;
  String corpo;
  String dataPostagem;
  String autor;
 
  String revista;
  String linkArtigo;
  String imagem;


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


}