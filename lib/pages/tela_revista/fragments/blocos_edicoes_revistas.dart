

import 'package:apprevistas_aplicativo/pages/tela_edicao/view/tela_edicao.dart';
import 'package:apprevistas_aplicativo/pages/tela_revista/model/edicao.dart';
//import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

blocoEdicao(List<Edicao> edicoes, int indice, BuildContext context, String keyy, String nomeRevista, String idUsuario){

  Image imagemThumbEdicao = Image.asset('images/default_logo.png');
  if(edicoes[indice].urlDaImagem != null){
  imagemThumbEdicao =   Image.network(
  edicoes[indice].urlDaImagem,
  //width: 50,
  //height: 50,
  fit: BoxFit.fitHeight,
  //cache: true,
  //border: Border.all(color: Colors.red, width: 1.0),
  //shape: BoxShape.rectangle,
  //borderRadius: BorderRadius.all(Radius.circular(30.0)),
  //cancelToken: cancellationToken,
);
  }
  return GestureDetector(
        
            child: Card(
                child: Container(
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
              children: <Widget>[
               Positioned.fill(child: 
               imagemThumbEdicao,), 
                Container(
                  color: Colors.black38,
                  //padding: EdgeInsets.fromLTRB(5, 100, 5, 5),
                  child: Text(
                    edicoes[indice].nomePortugues,
                    style: TextStyle(fontSize: 25,color: Colors.white),
                  ),
                )
              ],
            ))),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TelaEdicao(
                        keyy:keyy,
                        nomeRevista: nomeRevista,
                            idEdicao: edicoes[indice].id,
                            idUsuario: idUsuario,
                          )));
            });
}