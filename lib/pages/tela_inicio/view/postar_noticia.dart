import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'dart:typed_data';
import 'package:apprevistas_aplicativo/pages/tela_inicio/fragments/cores.dart';
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
  PostarNoticia({this.revistas, this.keyy, this.idUsuario});
  final List revistas;
  final String keyy;
  final String idUsuario;
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
      body: corpoPostNoticia(),
    );
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  Widget corpoPostNoticia() {
    return Padding(
        padding: EdgeInsets.all(30),
        child: ListView(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                //border: InputBorder.none,
                icon: Icon(Icons.title),
                hintText: 'Título',
              ),
              controller: controllerTitulo,
            ),
            TextField(
              controller: controllerSubtitulo,
              decoration: InputDecoration(
                  // border: InputBorder.none,
                  hintText: 'Subtítulo',
                  icon: Icon(Icons.subtitles)),
            ),
            TextField(
              controller: controllerCorpo,
              maxLines: 6,
              decoration: InputDecoration(
                  //border: InputBorder.none,

                  hintText: 'Corpo',
                  icon: Icon(Icons.edit)),
            ),
            Column(
              children: <Widget>[

                Padding(
                  padding: EdgeInsets.all(5),
                  child:
                DropdownButton<String>(
                  hint: Text('Revista Relacionada'),
                  items:
                      extraiNomeRevistas(widget.revistas).map((String value) {
                    return new DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  //hint: Text('Revista'),
                  value: _selected,
                  onChanged: (newValue) {
                    setState(() {
                      _selected = newValue;
                    });
                  },
                )),
                Padding(
                  padding: EdgeInsets.all(5),
                  child:
                TextField(
              controller: controllerLink,
              decoration: InputDecoration(
                  // border: InputBorder.none,
                  hintText: 'Link para o artigo (Opcional)',
                  icon: Icon(Icons.link)),
            ),)
              ],
            ),
            
            Row(
              children: <Widget>[
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
                    icon:Icon(Icons.camera),
                    label: Text('Escolher Imagem'),
                    onPressed: () async {
                      getImage();
                    },
                  ),
                ),
              ],
            ),
            Padding(
                padding: EdgeInsets.all(5),
                child: botaoPadrao(
                  'Postar Notícia',
                  () async {
                    var res = await createPost(
                      widget.keyy,
                      widget.idUsuario,
                      controllerTitulo.text,
                      controllerSubtitulo.text,
                      controllerCorpo.text,
                      idDaRevista(_selected),
                      controllerLink.text,
                      utf8.encode(_image.path),
                    );
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
      itens.add(item.nomeRevistaPortugues);
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
