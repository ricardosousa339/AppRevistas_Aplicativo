
import 'package:apprevistas_aplicativo/constantes.dart';
import 'package:apprevistas_aplicativo/pages/tela_inicio/view/tela_inicial.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
 
  
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: TelaInicial(flag: Constantes.INICIO_APLICACAO,)
    );
  }
}
