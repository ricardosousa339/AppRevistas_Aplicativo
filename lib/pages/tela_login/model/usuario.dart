/*
class Usuario {

String id;
String primeiroNome;
String segundoNome;
String email;

Usuario ({this.id, this.primeiroNome, this.segundoNome, this.email});


}
*/
class Usuario {
  String _username;
  String _password;
  Usuario(this._username, this._password);

  Usuario.map(dynamic obj) {
    this._username = obj["username"];
    this._password = obj["password"];
  }

  String get username => _username;
  String get password => _password;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["username"] = _username;
    map["password"] = _password;

    return map;
  }
}