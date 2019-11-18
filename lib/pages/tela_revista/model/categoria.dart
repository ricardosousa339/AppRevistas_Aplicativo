class Categoria{

String id;
String nomeCategoria;
String idDaRevista;

Categoria({this.id, this.nomeCategoria, this.idDaRevista});

factory Categoria.fromJson(Map<String, dynamic> json){
  return Categoria(
    id: json['id'].toString(),
    nomeCategoria: json['nome_categoria'],
    idDaRevista: json['revista_id'].toString()
  );
}

}