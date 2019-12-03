  import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:apprevistas_aplicativo/pages/tela_revista/model/artigo.dart';
import 'package:apprevistas_aplicativo/urls.dart';

Future <List<Artigo>> carregaArtigosDaEdicao(String idEdicao) async {
    List<Artigo> list;

    String uri =
        raizApi+'/api/get-artigosdaedicao/'+idEdicao;

    var response = await http
        .get(Uri.encodeFull(uri), headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      var data = json.decode(utf8.decode(response.bodyBytes));
      var rest = data as List;
      //print('rest'+rest.toString());
      list = rest.map<Artigo>((json) => Artigo.fromJson(json)).toList();
      print('listaaaa de artigos:' + list.toString());

      
    }


   
    return list;
  }