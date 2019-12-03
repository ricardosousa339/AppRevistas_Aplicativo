import 'package:apprevistas_aplicativo/pages/tela_inicio/fragments/cores.dart';
import 'package:flutter/material.dart';

Widget botaoPadrao(String texto, Function onpressed){

return ButtonTheme(
                  height: 45,
                  
                  child: RaisedButton(
                    elevation: 4,
                    color: corTerciaria,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                        side: BorderSide(color: corTerciaria)),
                    child: Text(texto,
                        style: TextStyle(fontSize: 15, color: Colors.white)),
                    onPressed: onpressed
                  ),
                );

}

Widget textFieldPadrao(String text, TextEditingController controller, {Icon icone}){
  return TextField(
    
    controller: controller,
    decoration: InputDecoration(
      icon: icone,
      hintText: text,
      contentPadding: EdgeInsets.all(13),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25)
      )
    ),
    
  );



}

Widget textFieldSenha(String text, TextEditingController controller,{Icon icone}){
  return TextField(
    
    controller: controller,
    obscureText: true,
    decoration: InputDecoration(
      icon: icone,
      hintText: text,
      contentPadding: EdgeInsets.all(13),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25)
      )
    ),
    
  );



}

Widget botaoSemFundo(String text, Function onpressed){
      return FlatButton(
        child: Text(text),
        onPressed: onpressed,
      );
}

Widget textFieldComentario(String text, TextEditingController controller){
  return TextField(
    
    maxLines: 6,
    controller: controller,
    decoration: InputDecoration(
      
      hintText: text,
      contentPadding: EdgeInsets.all(13),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(1)
      )
    ),
    
  );
}

Widget textFieldPost(String text, TextEditingController controller, Icon icon, int maxLines){
  return TextField(
    maxLines: maxLines,
    controller: controller,
    decoration: InputDecoration(
      icon: icon,
      hintText: text,
      contentPadding: EdgeInsets.all(13),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10)
      )
    ),
    
  );
}