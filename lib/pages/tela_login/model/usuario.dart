import 'dart:convert';

class Usuario {
  String key;

  String primeiroNome;
  String segundoNome;
  String email;
  String id;
  String urlDaFotoDePerfil;
  String password;
  String idServer;
  bool eAdministrador;

  Usuario({
    this.key,
    this.primeiroNome,
    this.segundoNome,
    this.email,
    this.id,
    this.urlDaFotoDePerfil,
    this.password,
    this.idServer,
    this.eAdministrador  });

  factory Usuario.fromJson(Map<String, dynamic> parsedJson) {
    
    return Usuario(
      id: parsedJson['id'].toString(),
      primeiroNome: parsedJson['first_name'],
      segundoNome: parsedJson['last_name'],
      email: parsedJson['email'],
      eAdministrador: parsedJson['administrador']
      
    );
  }

  Map<String, dynamic> toJson(Usuario instance) => <String, dynamic>{
      'email': instance.email,
      'username': instance.email,
      'password': instance.password,
      'first_name': instance.primeiroNome,
      'last_name': instance.segundoNome,
    };
}