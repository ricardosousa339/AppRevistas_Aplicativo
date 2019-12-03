import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:apprevistas_aplicativo/pages/tela_artigo/view/tela_artigo.dart';
import 'package:apprevistas_aplicativo/pages/tela_cadastro/view/tela_cadastro.dart';
import 'package:apprevistas_aplicativo/pages/tela_comentarios/view/tela_comentarios.dart';
import 'package:apprevistas_aplicativo/pages/tela_inicio/view/tela_inicial.dart';
import 'package:apprevistas_aplicativo/pages/tela_login/controller/faz_login.dart';
import 'package:apprevistas_aplicativo/pages/tela_login/controller/get_usuario.dart';
import 'package:apprevistas_aplicativo/pages/tela_revista/model/artigo.dart';
import 'package:apprevistas_aplicativo/urls.dart';
import 'package:apprevistas_aplicativo/widgets_pers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:apprevistas_aplicativo/pages/tela_login/model/usuario.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constantes.dart';

class LoginWithRestfulApi extends StatefulWidget {
  final flag;
  final String idNoticia;
  final Artigo artigo;
  final String revista; 

  LoginWithRestfulApi({this.flag, this.idNoticia, this.artigo, this.revista});

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
      //appBar: AppBar(title: Text("Login")),

      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(70, 50, 60, 70),
                    child: Image.asset('images/LogoLupaBlue.png'),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 30, 30, 15),
                    child: textFieldPadrao('Email', _emailController, icone:Icon(Icons.email)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 30, 30),
                    child: textFieldSenha('Senha', _passwordController, icone:Icon(Icons.lock)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: botaoPadrao('Login', () async {
                      setState(() => _isLoading = true);
                      var res = await loginUser(
                          _emailController.text, _passwordController.text);
                      setState(() => _isLoading = false);

                      Usuario usu = await getUsuario(_emailController.text);

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TelaInicial(
                                user: usu,
                                keyy: res['key'],
                                flag: 'login',
                              )));
                      if (widget.flag == Constantes.FLAG_COMENTARIOS) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => TelaComentarios(
                                  idDoUsuario: usu.id,
                                  keyy: res['key'],
                                  idNoticia: widget.idNoticia,
                                )));
                      }
                      else if(widget.flag == Constantes.FLAG_TELA_ARTIGO){
                         Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => TelaArtigo(
                                  artigo: widget.artigo,
                                  revista: widget.revista,
                                  keyy: res['key'],
                                  idUsuario: usu.id,
                                )));
                      }
                      //print(res+" --"+res['key']);
                    }),
                  ),
                  Row(
                    children: <Widget>[
                       botaoSemFundo(
                    'Criar conta',
                    () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TelaCadastro()));
                    },
                  ),
                  VerticalDivider(width: 60,),
                  botaoSemFundo('Esqueci minha senha', (){
                    _launchURL(raizApi+'/password-reset/');
                  })
                    ],
                  )
                 
                ],
              ),
      ),
    );
  }
    _launchURL(String uri) async {
  var url =uri;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
}

class LoginScreen extends StatelessWidget {
  LoginScreen({this.user, this.flag, this.idNoticia, this.artigo, this.revista});

  final String idNoticia;
  final Usuario user;
  final Artigo artigo;
  final String revista;

  //Para o login retornar o usuario para onde ele estava
  final flag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: user != null
              ? TelaInicial()
              : LoginWithRestfulApi(
                  flag: flag,
                  idNoticia: idNoticia,
                  artigo: artigo,
                  revista: revista,
                )),
    );
  }
}
