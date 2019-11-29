import 'package:apprevistas_aplicativo/pages/tela_inicio/fragments/cores.dart';
import 'package:flutter/material.dart';

Widget botaoPadrao(String texto, Function onpressed){

return ButtonTheme(
                  height: 40,
                  
                  child: RaisedButton(
                    elevation: 4,
                    color: corTerciaria,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                        side: BorderSide(color: corTerciaria)),
                    child: Text(texto,
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                    onPressed: onpressed
                  ),
                );

}