import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:apprevistas_aplicativo/pages/tela_artigo/view/tela_artigo.dart';
import 'package:apprevistas_aplicativo/pages/tela_cadastro/view/tela_cadastro.dart';
import 'package:apprevistas_aplicativo/pages/tela_comentarios/view/tela_comentarios.dart';
import 'package:apprevistas_aplicativo/pages/tela_inicio/view/tela_inicial.dart';
import 'package:apprevistas_aplicativo/pages/tela_login/controller/faz_login.dart';
import 'package:apprevistas_aplicativo/pages/tela_login/controller/get_id_server.dart';
import 'package:apprevistas_aplicativo/pages/tela_login/controller/get_usuario.dart';
import 'package:apprevistas_aplicativo/pages/tela_revista/model/artigo.dart';
import 'package:apprevistas_aplicativo/urls.dart';
import 'package:apprevistas_aplicativo/widgets_pers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:apprevistas_aplicativo/pages/tela_login/model/usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  

  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
      final _scaffoldKey = GlobalKey<ScaffoldState> ();

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
                    padding: EdgeInsets.fromLTRB(50,20,50,20),
                    child: botaoPadrao('Login', () async {

                      if(_emailController.text == '' || _passwordController.text==''){
                        final snackBar = SnackBar(content: Text('Todos os campos devem ser preenchidos'));
  _scaffoldKey.currentState.showSnackBar(snackBar); 
                      }
                      else{
                      setState(() => _isLoading = true);
                      
                      Response res = await loginUser(
                          _emailController.text, _passwordController.text);

                      setState(() => _isLoading = false);

                          if(res.statusCode != 200){
                            final snackBar = SnackBar(content: Text('Houve um erro de autenticação'));
  _scaffoldKey.currentState.showSnackBar(snackBar); 
                          }
                          else{
        var responseJson = json.decode(res.data);

                      Usuario usu = await getUsuario(_emailController.text);
                      List attr = await getIdServerEEAdministrador(usu.id);

                      usu.idServer = attr[0].toString();
                      usu.eAdministrador = attr[1];

                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.setString('key', responseJson['key']);
                      await prefs.setString('primeiroNome', usu.primeiroNome);
                      await prefs.setString('segundoNome', usu.segundoNome);
                      await prefs.setString('email', usu.email);
                      await prefs.setString('id', usu.id);
                      await prefs.setString('idServer', usu.idServer);
                      await prefs.setString('urlDaFotoDePerfil', usu.urlDaFotoDePerfil);
                      await prefs.setBool('eAdministrador', usu.eAdministrador);

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TelaInicial(
                                user: usu,
                                keyy: responseJson['key'],
                                flag: 'login',
                                
                              )));
                      if (widget.flag == Constantes.FLAG_COMENTARIOS) {

                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => TelaComentarios(
                                  idDoUsuario: usu.idServer,
                                  keyy: responseJson['key'],
                                  idNoticia: widget.idNoticia,
                                )));
                      }
                      else if(widget.flag == Constantes.FLAG_TELA_ARTIGO){
                         Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                            builder: (context) => TelaArtigo(
                                  artigo: widget.artigo,
                                  revista: widget.revista,
                                  keyy: responseJson['key'],
                                  idUsuario: usu.id,
                                )), (e)=> false);
                      }
                    }
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
                  Spacer(),
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
