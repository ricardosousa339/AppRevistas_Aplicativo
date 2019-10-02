class Noticia{

Noticia({this.titulo, this.conteudo, this.id, this.idUsuario});

  String titulo;
  String conteudo;
  final int id;
  final int idUsuario;


//Quando mudar a fonte de dados, só trocar as chaves pra pegar as corretas do banco de dados e salvar como noticia
factory Noticia.fromJson(Map<String, dynamic> json){
  return Noticia(
    titulo: json['title'],
    conteudo: json['body'],
    idUsuario: json['userId'],
    id: json['id']
  );
}


}