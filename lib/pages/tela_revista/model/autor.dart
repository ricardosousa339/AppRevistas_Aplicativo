class Autor{
Autor({this.id, this.nomeAutor});

  String id;
  String nomeAutor;

factory Autor.fromJson(Map<String, dynamic> json){
  return Autor(
    id: json['id'].toString(),
    nomeAutor: json['nome_autor'] as String
  );


}
}