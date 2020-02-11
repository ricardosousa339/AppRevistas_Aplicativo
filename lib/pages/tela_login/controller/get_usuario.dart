import 'dart:convert';

import 'package:apprevistas_aplicativo/pages/tela_login/model/usuario.dart';
import 'package:apprevistas_aplicativo/urls.dart';
import 'package:http/http.dart' as http;

Future <Usuario> getUsuario(String email) async{
  final response = await http.get(Uri.decodeFull( raizApi+'/api/usuarios/?search='+email,)
   
    
  );
  final responseJson = json.decode(response.body);

  return Usuario.fromJson(responseJson[0]);
}