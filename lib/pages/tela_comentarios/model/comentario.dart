class Comentario {
  String id;
  String corpo;
  String autor;
  String noticia;
  String idAutor;

  Comentario({this.id, this.corpo, this.autor, this.noticia, this.idAutor});

  factory Comentario.fromJson(Map<String, dynamic> json) {
    return Comentario(
     id: json['id'].toString(),
     corpo: json['corpo'],
     autor: json['nome_autor'],
     noticia: json['noticia'].toString()

    );
  }

  
 Map toMap() {
    var map = new Map<String, dynamic>();
   
    map["id"] = id;
    map["corpo"] = corpo;
    map['autor'] = autor;
    map['noticia'] = noticia;
    map['id_autor'] = idAutor;
    
    return map;
  }
}
