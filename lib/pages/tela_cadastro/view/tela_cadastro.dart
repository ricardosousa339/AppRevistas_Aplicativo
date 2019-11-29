import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:apprevistas_aplicativo/pages/tela_inicio/view/tela_inicial.dart';
import 'package:apprevistas_aplicativo/pages/tela_login/controller/faz_login.dart';
import 'package:apprevistas_aplicativo/pages/tela_login/model/usuario.dart';
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
/*
  static BaseOptions options = BaseOptions(
      baseUrl: uri,
      responseType: ResponseType.plain,
      connectTimeout: 30000,
      receiveTimeout: 30000,
      validateStatus: (code) {
        if (code >= 200) {
          return true;
        }
      });
      
  static Dio dio = Dio(options);
  */
  TextEditingController controllerPrimeiroNome = TextEditingController(),
      controllerSegundoNome = TextEditingController(),
      controllerEmail = TextEditingController(),
      controllerSenha = TextEditingController(),
      controllerConfirmarSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: TextField(
              controller: controllerPrimeiroNome,
              decoration: InputDecoration(hintText: 'Nome'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: TextField(
              controller: controllerSegundoNome,
              decoration: InputDecoration(hintText: 'Sobrenome'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: TextField(
                controller: controllerEmail,
                decoration: InputDecoration(hintText: 'Email')),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: TextField(
              controller: controllerSenha,
              decoration: InputDecoration(hintText: 'Senha'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: TextField(
              controller: controllerSenha,
              decoration: InputDecoration(hintText: 'Confirmar Senha'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(30),
            child: RaisedButton(
              child: Text('Cadastrar'),
              onPressed: () async {
                
                var res = await _cadastraUsuario(
                    controllerPrimeiroNome.text,
                    controllerSegundoNome.text,
                    controllerEmail.text,
                    controllerSenha.text);

                if(res != null){
                  var res2 = await  loginUser(controllerEmail.text, controllerSenha.text);
 Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TelaInicial(
                          flag: 'cadastro',
                          user: Usuario(
                            email: controllerEmail.text,
                            key: res2['key']
                            ),

                        )));
                }

               
                print(res);
              },
            ),
          )
        ],
      ),
    );
  }

//Cadastra o usuario, passadas as informacoes
  Future<dynamic> _cadastraUsuario(
      String nome, String sobrenome, String email, String password) async {
    /* try {
      Options options = Options(
       contentType: 'application/json'
      );

      Response response = await dio.post('/api/usuarios/',
          data: {"email:": email,"username": email, "password": password, "first_name":nome, "last_name":sobrenome}, options: options);
*/

    Usuario user = Usuario(
        email: email,
        primeiroNome: nome,
        segundoNome: sobrenome,
        password: password);

    return http.post(raizApi + '/api/usuarios/',
        body: json.encode(user.toJson(user)),
        headers: {
          "Content-Type": "application/json"
        }).then((http.Response response) {
      print(response.body);
    });

    final response = await http.post(raizApi + '/api/usuarios/',
        body: json.encode({
          'username': email,
          'email': email,
          'password': password,
          'first_name': nome,
          'second_name': sobrenome
          //headers: {HttpHeaders.authorizationHeader: "Token ${widget.key}"},
        }));

    if (response.statusCode == 200 || response.statusCode == 201) {
      var responseJson = json.decode(response.body);
      return responseJson;
    } else if (response.statusCode == 401) {
      throw Exception("Incorrect Email/Password");
    } else {
      print(response.statusCode);

      throw Exception('Authentication Error');
    }
  }
  /*
     on DioError catch (exception) {
      if (exception == null ||
          exception.toString().contains('SocketException')) {
        throw Exception("Network Error");
      } else if (exception.type == DioErrorType.RECEIVE_TIMEOUT ||
          exception.type == DioErrorType.CONNECT_TIMEOUT) {
        throw Exception(
            "Could'nt connect, please ensure you have a stable network.");
      } else {
        return null;
      }
    }

    */

}
