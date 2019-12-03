import 'dart:async';
import 'dart:convert';
import 'package:apprevistas_aplicativo/urls.dart';
import 'package:http/http.dart' as http;
import 'package:apprevistas_aplicativo/pages/tela_revista/model/revista.dart';

Future<List<Revista>> carregaRevistas() async {
  List revistas = List();

  var res = await http.get(Uri.encodeFull(raizApi+'/api/revistas'),headers: {"Accept":"application/json"});

  
    if (res.statusCode == 200) {
      var data = json.decode(utf8.decode(res.bodyBytes));
      var rest = data as List;
      //print('rest'+rest.toString());
      revistas = rest.map<Revista>((json) => Revista.fromJson(json)).toList();
      //print('listaaaa de edicoes:' + list.toString());
    }
    
    List remover = List();
    for (Revista item in revistas) {
      if (item.nomeRevistaPortugues == "Not found") {
        remover.add(item);
      }
    }

    revistas.removeWhere((item)=> item.nomeRevistaPortugues == "Not found");
    
    return revistas;

}