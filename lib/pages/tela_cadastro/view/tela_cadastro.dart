import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:apprevistas_aplicativo/pages/tela_cadastro/controller/cadastra_usuario.dart';
import 'package:apprevistas_aplicativo/pages/tela_inicio/fragments/cores.dart';
import 'package:apprevistas_aplicativo/pages/tela_inicio/view/tela_inicial.dart';
import 'package:apprevistas_aplicativo/pages/tela_login/controller/faz_login.dart';
import 'package:apprevistas_aplicativo/pages/tela_login/controller/get_id_server.dart';
import 'package:apprevistas_aplicativo/pages/tela_login/controller/get_usuario.dart';
import 'package:apprevistas_aplicativo/pages/tela_login/model/usuario.dart';
import 'package:apprevistas_aplicativo/widgets_pers.dart';
//import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
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
 var res = await cadastraUsuario(
                    controllerPrimeiroNome.text,
                    controllerSegundoNome.text,
                    controllerEmail.text,
                    controllerSenha.text, context,_scaffoldKey);

                if(res == 201 || res ==200){
                  var res2 = await  loginUser(controllerEmail.text, controllerSenha.text);

                  
                  Usuario usuario = await getUsuario(controllerEmail.text);
                   List attr = await getIdServerEEAdministrador(usuario.id);

                      usuario.idServer = attr[0].toString();
                      usuario.eAdministrador = attr[1];
                  usuario.key = json.decode(res2.data)['key'];

                   SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.setString('key', usuario.key);
                      await prefs.setString('primeiroNome', usuario.primeiroNome);
                      await prefs.setString('segundoNome', usuario.segundoNome);
                      await prefs.setString('email', usuario.email);
                      await prefs.setString('id', usuario.id);
                      await prefs.setString('idServer', usuario.idServer);
                      await prefs.setString('urlDaFotoDePerfil', usuario.urlDaFotoDePerfil);
                      await prefs.setBool('eAdministrador', usuario.eAdministrador);
                      
 Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TelaInicial(
                          flag: 'cadastro',
                          user: usuario,
                          keyy: usuario.key,
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

  

}
