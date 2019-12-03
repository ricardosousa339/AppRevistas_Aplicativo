import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'dart:typed_data';
import 'package:apprevistas_aplicativo/pages/tela_inicio/fragments/cores.dart';
import 'package:apprevistas_aplicativo/pages/tela_inicio/view/tela_inicial.dart';
import 'package:apprevistas_aplicativo/trata_imagem.dart';
import 'package:apprevistas_aplicativo/widgets_pers.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:apprevistas_aplicativo/pages/tela_inicio/model/noticia.dart';
import 'package:apprevistas_aplicativo/pages/tela_revista/model/revista.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import '../../../urls.dart';
import 'package:apprevistas_aplicativo/pages/tela_login/model/usuario.dart';

class PostarNoticia extends StatefulWidget {
  PostarNoticia({this.revistas, this.keyy, this.idUsuario,this.user});
  final List revistas;
  final String keyy;
  final String idUsuario;
  final Usuario user;
  @override
  _PostarNoticiaState createState() => _PostarNoticiaState();
}

class _PostarNoticiaState extends State<PostarNoticia> {
  List<DropdownMenuItem<String>> revistasItens;
  String _selected = null;
  File _image;
  TextEditingController controllerTitulo = new TextEditingController(),
      controllerSubtitulo = new TextEditingController(),
      controllerCorpo = new TextEditingController(),
      controllerLink = new TextEditingController();

  @override
  void initState() {
    //carregaRevistas();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova notícia'),
      ),
      body: corpoPostNoticia(context),
    );
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  Widget corpoPostNoticia(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: ListView(
          children: <Widget>[
            textFieldPost('Título', controllerTitulo, Icon(Icons.title),1),
            Divider(),
            textFieldPost('Subtítulo', controllerSubtitulo, Icon(Icons.subtitles),1),
            Divider(),
            textFieldPost('Corpo', controllerCorpo, Icon(Icons.text_fields), 6),
            Divider(),
                Padding(
                  padding: EdgeInsets.all(0),
                  child:
                  Row(children: <Widget>[
                    Icon(Icons.library_books,color: Colors.grey,),
                    Padding(padding: EdgeInsets.fromLTRB(20, 0,10,5),
                    child: 
                     DropdownButton<String>(
                  //icon: Icon(Icons.library_books),
                  
                  hint: Text('Revista Relacionada'),
                  items:
                      extraiNomeRevistas(widget.revistas).map((String value) {
                    return new DropdownMenuItem(
                      value: value,
                      child: Text(value.length >20 ? value.substring(0,20)+'...': value),
                    );
                  }).toList(),
                  //hint: Text('Revista'),
                  value: _selected,
                  onChanged: (newValue) {
                    setState(() {
                      _selected = newValue;
                    });
                  },
                )
                    ,)


                  ],)
               ),
               Divider(),
                Padding(
                  padding: EdgeInsets.all(5),
                  child:
               textFieldPost('Link para o artigo (Opcional)', controllerLink, Icon(Icons.link), 1)),
             
            Divider(),
            
                _image == null
                    ? Text('')
                    : Image.asset(
                        _image.path,
                        width: 150,
                        height: 150,
                      ),
                Padding(
                  padding: EdgeInsets.all(4),
                  child: RaisedButton.icon(
                    color: Colors.cyan,
                    icon:Icon(Icons.image),
                    label: Text('Escolher Imagem'),
                    onPressed: () async {
                      getImage();
                    },
                  ),
                ),
             

            Padding(
                padding: EdgeInsets.all(5),
                child: botaoPadrao(
                  'Postar Notícia',
                  () async {
                    var imagemComprimida  = await comprimeImagemComoArquivo(_image, _image.path);
                    var res = await createPost(
                      widget.keyy,
                      widget.idUsuario,
                      controllerTitulo.text,
                      controllerSubtitulo.text,
                      controllerCorpo.text,
                      idDaRevista(_selected),
                      controllerLink.text,
                      utf8.encode(imagemComprimida.path),
                    );

                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> TelaInicial(keyy: widget.keyy,user:widget.user,)));
                    //Noticia noticia = Noticia(titulo: controllerTitulo.text, subtitulo: controllerSubtitulo.text, corpo: controllerCorpo.text, revista:  idDaRevista(_selected),linkArtigo: controllerLink.text, arquivoImagem: _image.readAsBytesSync());
                    //Noticia noticiaPublicada = await createPost((raizApi+'/api/noticias'),body: noticia.toMap());
                    print(res);
                  },
                ))
          ],
        ));
  }

  List<String> extraiNomeRevistas(List<Revista> revistas) {
    List<String> itens = new List();

    for (Revista item in revistas) {
      if(item.nomeRevistaPortugues != "Not found"){
      itens.add(item.nomeRevistaPortugues);
      }
    }

    return itens;

    //revistasItens = itens;
    //return itens;
  }

  Future<Noticia> createPost(
      String key,
      String id,
      String titulo,
      String subtitulo,
      String corpo,
      String revista,
      String linkArtigo,
      Uint8List arquivoImagem) async {
    Noticia noticia = Noticia(
        id: id,
        titulo: titulo,
        subtitulo: subtitulo,
        revista: revista,
        linkArtigo: linkArtigo,
        arquivoImagem: arquivoImagem);

    BaseOptions options = BaseOptions(
        baseUrl: raizApi,
        responseType: ResponseType.plain,
        connectTimeout: 30000,
        receiveTimeout: 30000,
        validateStatus: (code) {
          if (code >= 200) {
            return true;
          }
        });

/*var headers = {
    'Authorization':'Token '+key,
    ricardosousa339@gmail.com
  };
*/

    var uri = Uri.parse(raizApi + '/api/create-noticias/');
    var request = new http.MultipartRequest("POST", uri);
    request.fields['id'] = id;
    request.fields['titulo'] = titulo;
    request.fields['subtitulo'] = subtitulo;
    request.fields['corpo'] = corpo;
    request.fields['autor'] = widget.idUsuario;
    request.fields['revista_relacionada'] = revista;
    request.fields['link_artigo'] = linkArtigo;

    request.headers.addAll({"Authorization": "Token " + key});
    request.files.add(await http.MultipartFile.fromPath('imagem', _image.path,
        contentType: new MediaType('image', 'jpeg')));
    var response = await request.send();
    if (response.statusCode == 200) print('Uploaded!');

    return noticia;
  }

  String idDaRevista(String nomeRevista) {
    for (Revista item in widget.revistas) {
      if (nomeRevista == item.nomeRevistaPortugues) {
        print(item.id);

        return item.id;
      }
    }
  }
}
