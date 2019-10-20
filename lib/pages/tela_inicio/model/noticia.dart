class Noticia{

Noticia({this.titulo, this.conteudo, this.id, this.idUsuario, this.revista});

  String titulo;
  String conteudo;
  final int id;
  final int idUsuario;
  String revista;


//Quando mudar a fonte de dados, só trocar as chaves pra pegar as corretas do banco de dados e salvar como noticia
factory Noticia.fromJson(Map<String, dynamic> json){
  return Noticia(
    titulo: json['title'][0].toString().toUpperCase()+json['title'].toString().substring(1),
    conteudo: json['body'],
    idUsuario: json['userId'],
    id: json['id'],
    revista : json['id'] % 10 == 1 ? 'Revista Observatório' : json['id']%10 == 2 ? 'Revista Desafios' : 'Revista Aturá' 
  );
}


}