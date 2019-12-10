import 'dart:convert';

import 'package:apprevistas_aplicativo/urls.dart';
import 'package:http/http.dart' as http;

Future <List> getIdServerEEAdministrador(String idNormalApp) async{
  final response = await http.get(Uri.decodeFull(raizApi+'/api/get-usuariosporid/'+idNormalApp));
  final responseJson = json.decode(response.body);
int idServer = responseJson[0]['id'];
bool eAdministrador = responseJson[0]['administrador'];
  return [idServer, eAdministrador];
}