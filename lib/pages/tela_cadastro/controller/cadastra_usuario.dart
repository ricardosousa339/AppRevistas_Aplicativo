  import 'dart:convert';

import 'package:apprevistas_aplicativo/pages/tela_login/model/usuario.dart';
import 'package:apprevistas_aplicativo/urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//Cadastra o usuario, passadas as informacoes

Future<dynamic> cadastraUsuario(
      String nome, String sobrenome, String email, String password, BuildContext context, _scaffoldKey) async {
  

    Usuario user = Usuario(
        email: email,
        primeiroNome: nome,
        segundoNome: sobrenome,
        password: password);

    var res = await http.post(raizApi + '/api/usuarios/',
    
        body: json.encode(user.toJson(user)),
        headers: {
          "Content-Type": "application/json"
        });


final snackBar = SnackBar(content: Text(utf8.decode(res.bodyBytes)));
  
  if(res.statusCode != 201){
    _scaffoldKey.currentState.showSnackBar(snackBar);  
  }


  return (res.statusCode);
   
  }