import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

 final GlobalKey<FormState> formKey = new GlobalKey<FormState>();

AlertDialog telaDeLogin(){

String _email, _senha;


final campoUsuario = TextFormField(
  decoration: InputDecoration(labelText: 'Email'),
  validator: (input) => !input.contains('@')? 'Email inválido' : null,
  onSaved: (input)=> _email = input,
);

final campoSenha = TextFormField(
  decoration: InputDecoration(labelText: 'Senha'),
  obscureText: true,
  onSaved: (input)=>_senha = input,
);

final botaoLogin = RaisedButton(
  
  child: Text('Entrar'),
  onPressed: (){
    print('a');
  },
);

return AlertDialog(
  
  content: SingleChildScrollView(



    
  child: Padding(padding: EdgeInsets.all(15.0),
  
  child: Form(
    key: formKey,
    child: Column(
      children: <Widget>[
        Image.asset('images/periodicosHeader.png',),
        campoUsuario,
        campoSenha,
        botaoLogin
      ],
    ),
  ),
  
  
  ) ),
);

}