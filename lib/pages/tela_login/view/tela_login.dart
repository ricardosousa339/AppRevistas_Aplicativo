import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:apprevistas_aplicativo/pages/tela_cadastro/view/tela_cadastro.dart';
import 'package:apprevistas_aplicativo/pages/tela_inicio/view/tela_inicial.dart';
import 'package:apprevistas_aplicativo/pages/tela_login/controller/faz_login.dart';
import 'package:apprevistas_aplicativo/pages/tela_login/controller/get_usuario.dart';
import 'package:apprevistas_aplicativo/urls.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:apprevistas_aplicativo/pages/tela_login/model/usuario.dart';

class LoginWithRestfulApi extends StatefulWidget {
  @override
  _LoginWithRestfulApiState createState() => _LoginWithRestfulApiState();
}

class _LoginWithRestfulApiState extends State<LoginWithRestfulApi> {


  

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text("Login using RESTFUL api")),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'Email',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: 'Senha',
                      ),
                    ),
                  ),
                  RaisedButton(
                    child: Text("Login"),
                    color: Colors.red,
                    onPressed: () async {
                      setState(() => _isLoading = true);
                      var res = await loginUser(
                          _emailController.text, _passwordController.text);
                      setState(() => _isLoading = false);

                      Usuario usu = await getUsuario(_emailController.text);

                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TelaInicial(user: usu, keyy: res['key'],flag: 'login',)));
                      //print(res+" --"+res['key']);
                    }
                  ),
                  RaisedButton(
                    child: Text('Criar conta'),
                    color: Colors.transparent,
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TelaCadastro()));

                    },
                  )
                ],
              ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  LoginScreen({ this.user});

  final Usuario user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: user != null ? TelaInicial() : LoginWithRestfulApi()
      ),
    );
  }
}
