
import 'package:apprevistas_aplicativo/pages/tela_comentarios/controller/carrega_comentarios.dart';
import 'package:apprevistas_aplicativo/pages/tela_comentarios/fragments/bloco_comentario.dart';
import 'package:apprevistas_aplicativo/pages/tela_comentarios/model/comentario.dart';
import 'package:flutter/material.dart';

class TelaComentarios extends StatefulWidget{
  final String idNoticia;
    TelaComentarios({Key key, @required this.idNoticia});
  
  @override
  _TelaComentariosState createState() => _TelaComentariosState();
  
  }
  
  class _TelaComentariosState extends State<TelaComentarios>{


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Comentários'),
      ),
      body:
       elementosTelaComentarios()
      );
          
  
  }

   elementosTelaComentarios(){

TextEditingController controllerComentario = TextEditingController();

    return ListView(
      children: <Widget>[
           FutureBuilder<List<Comentario>> (
        future: getComentario(widget.idNoticia),
          builder: (context, snapshot){
            if(snapshot.hasData){
              return listaDeComentarios(snapshot.data);
            }
            else return Center(child:CircularProgressIndicator());
          },
),

Card(
  child: Row(
    children: <Widget>[
      TextField(
        controller: controllerComentario,
        maxLines: 3,
      ),
      RaisedButton(
        child: Icon(Icons.send),
        onPressed: (){
          
        },
      )
    ],
  ),
)
      ],
    );
    
 

    


  }

  ListView listaDeComentarios(List<Comentario> comentarios){
  
    return ListView.builder(
      itemCount: comentarios.length,
      itemBuilder: (context, indice){
        
        return blocoComentario(comentarios[indice], context);
        
      },
    );
 
  }

  }
