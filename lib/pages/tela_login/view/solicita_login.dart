
import 'package:apprevistas_aplicativo/pages/tela_login/view/tela_login.dart';
import 'package:apprevistas_aplicativo/pages/tela_revista/model/artigo.dart';
import 'package:flutter/material.dart';

solicitaLogin(BuildContext context, String flag,{String idNoticia, Artigo artigo, String revista}){
return showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      // retorna um objeto do tipo Dialog
                      return AlertDialog(
                        title: new Text("Você não está logado!"),
                        content: new Text("Faça login para executar essa ação"),
                        actions: <Widget>[
                          // define os botões na base do dialogo
                          new FlatButton(
                            child: new Text("Login"),
                            onPressed: () {

                              
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen(flag: flag,idNoticia: idNoticia,artigo: artigo,revista: revista,)));
                            },
                          ),
                          FlatButton(
                              child: new Text("Voltar"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              })
                        ],
                      );
                    },
                  );


}