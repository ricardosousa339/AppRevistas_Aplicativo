import 'edicao.dart';

class ListaDeEdicoes {
  final List<Edicao> edicoes;

  ListaDeEdicoes({
    this.edicoes,
  });
factory ListaDeEdicoes.fromJson(List<dynamic> parsedJson) {

    List<Edicao> edicoes = new List<Edicao>();
    edicoes = parsedJson.map((i)=>Edicao.fromJson(i)).toList();

    return new ListaDeEdicoes(
      edicoes: edicoes
    );
  }
  
}