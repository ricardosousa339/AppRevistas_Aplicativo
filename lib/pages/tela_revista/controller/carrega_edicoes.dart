
import 'package:apprevistas_aplicativo/pages/tela_revista/model/lista_de_edicoes.dart';
import 'package:http/http.dart' as http;


Future<ListaDeEdicoes> getEdicoes(int indice) async {
    final response = await http
        .get('https://jsonplaceholder.typicode.com/photos/');

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.

      return ListaDeEdicoes.fromJson(response as List);

      // p = Noticia.fromJson(json.decode(response.body));

    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }
