import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:apprevistas_aplicativo/pages/tela_inicio/fragments/cores.dart';
import 'package:apprevistas_aplicativo/pages/tela_inicio/view/tela_inicial.dart';
import 'package:apprevistas_aplicativo/pages/tela_login/controller/faz_login.dart';
import 'package:apprevistas_aplicativo/pages/tela_login/controller/get_usuario.dart';
import 'package:apprevistas_aplicativo/pages/tela_login/model/usuario.dart';
import 'package:apprevistas_aplicativo/widgets_pers.dart';
//import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../urls.dart';

class TelaCadastro extends StatefulWidget {
  _TelaCadastroState createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  static var uri = raizApi;

  TextEditingController controllerPrimeiroNome = TextEditingController(),
      controllerSegundoNome = TextEditingController(),
      controllerEmail = TextEditingController(),
      controllerSenha = TextEditingController(),
      controllerConfirmarSenha = TextEditingController();

      final _scaffoldKey = GlobalKey<ScaffoldState> ();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Cadastro'),
        //backgroundColor: corTerciaria,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20,40,20,20),
            child: textFieldPadrao('Nome', controllerPrimeiroNome)
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: textFieldPadrao('Sobrenome', controllerSegundoNome)
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: textFieldPadrao('Email', controllerEmail),),

          Padding(
            padding: EdgeInsets.all(20),
            child: textFieldSenha('Senha', controllerSenha)
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: textFieldSenha('Confirmar senha', controllerConfirmarSenha)
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(50, 20,50,20),
          
              child: botaoPadrao('Cadastrar', () async {
                
                if(controllerPrimeiroNome.text == "" || controllerSegundoNome.text == "" || controllerEmail.text == "" || controllerSenha.text=="" || controllerConfirmarSenha.text==""){

final snackBar = SnackBar(content: Text('Nenhum campo deve ser deixado em branco'));
  _scaffoldKey.currentState.showSnackBar(snackBar);  


                 }
              
                else if(controllerSenha.text != controllerConfirmarSenha.text){
                 final snackBar = SnackBar(content: Text('A senha digitada deve ser a mesma nos dois campos'));
  _scaffoldKey.currentState.showSnackBar(snackBar); 
                }
                //TODO: Confirmar o tamanho da senha
                else if(controllerSenha.text.length < 8){
                  final snackBar = SnackBar(content: Text('A senha deve ter 8 dígitos ou mais'));
  _scaffoldKey.currentState.showSnackBar(snackBar); 
                }
                
                else{
 var res = await _cadastraUsuario(
                    controllerPrimeiroNome.text,
                    controllerSegundoNome.text,
                    controllerEmail.text,
                    controllerSenha.text, context);

                if(res == 201){
                  var res2 = await  loginUser(controllerEmail.text, controllerSenha.text);
                  Usuario usuario = await getUsuario(controllerEmail.text);
                  usuario.key = res2['key'];
 Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TelaInicial(
                          flag: 'cadastro',
                          user: usuario,
                          keyy: res2['key'],
                        )));
                }
                

               
                print(res);
                }
               
              },)
            
          )
        ],
      ),
    );
  }

//Cadastra o usuario, passadas as informacoes
  Future<dynamic> _cadastraUsuario(
      String nome, String sobrenome, String email, String password, BuildContext context) async {
  

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
  

}
