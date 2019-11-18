import 'dart:convert';

import 'package:apprevistas_aplicativo/pages/tela_revista/model/revista.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../../../urls.dart';

class PostarNoticia extends StatefulWidget{

@override 
_PostarNoticiaState createState() => _PostarNoticiaState();

}

class _PostarNoticiaState extends State<PostarNoticia>{


  List <DropdownMenuItem<String>> revistas;
  String _selected = null;


@override
  void initState() {
    
    carregaRevistas();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   

    return Scaffold(
      appBar: AppBar(title: Text('Nova notícia'),),
      body: corpoPostNoticia(),
    );
  }




  Widget corpoPostNoticia(){
    return Padding(padding: EdgeInsets.all(20), child:Column(
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
            //border: InputBorder.none,
            icon: Icon(Icons.title),
            hintText: 'Título'
          ),
        ),
        TextField(
          decoration: InputDecoration(
           // border: InputBorder.none,
            hintText: 'Subtítulo',
            icon: Icon(Icons.subtitles)
          ),
        ),
        TextField(maxLines: 6,
          decoration: InputDecoration(
            //border: InputBorder.none,
        
            hintText: 'Corpo',
            icon: Icon(Icons.edit)
          ),
        ),
        Center(
          child: DropdownButton(
            items: revistas,
            hint: Text('Revista'),
            value: _selected,
          ),
        ),
        TextField(
          decoration: InputDecoration(
           // border: InputBorder.none,
            hintText: 'Link para o artigo (Opcional)',
            icon: Icon(Icons.link)
          ),
        ),


        Center(
          child: RaisedButton(
            child: Text('Postar Notícia'),
            onPressed: (){
              
            },
          ),
        )
      ],
    )
    );

  }

  Future<List<Revista>> carregaRevistas() async{
    List<Revista> list;
  

    String uri =
        raizApi+'/api/revistas';

    var response = await http
        .get(Uri.encodeFull(uri), headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var rest = data as List;
   
      list = rest.map<Revista>((json) => Revista.fromJson(json)).toList();
  
    }

    setState(() {
      revistas = extraiNomeRevistas(list);
    });
   return list;
  }

  List<DropdownMenuItem<String>> extraiNomeRevistas(List<Revista> revistas){

    List<DropdownMenuItem<String>> itens = new List();

_selected = revistas[0].id;
    for (Revista item in revistas) {
      itens.add(DropdownMenuItem(
        child: Text(item.nomeRevistaPortugues),
        value: item.id,
      ));
    }
    return itens;
  }


}




