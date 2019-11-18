
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
      body: elementosTelaComentarios()
      );
          
  
  }

   elementosTelaComentarios(){

    return 




FutureBuilder<List<Comentario>> (
        future: getComentario(widget.idNoticia),
          builder: (context, snapshot){
            if(snapshot.hasData){
              return listaDeComentarios(snapshot.data);
            }
            else return Center(child:CircularProgressIndicator());
          },
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
