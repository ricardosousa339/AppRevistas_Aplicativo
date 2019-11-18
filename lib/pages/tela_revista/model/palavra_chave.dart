class PalavraChave{

PalavraChave({this.id, this.assunto});
  String id;
  String assunto;

factory PalavraChave.fromJson(Map<String,dynamic>json){
  return PalavraChave(
    id: json['id'].toString(),
    assunto: json['assunto']
  );
}

}