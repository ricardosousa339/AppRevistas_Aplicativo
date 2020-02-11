import 'package:apprevistas_aplicativo/constantes.dart';
import 'package:apprevistas_aplicativo/pages/tela_comentarios/controller/carrega_comentarios.dart';
import 'package:apprevistas_aplicativo/pages/tela_comentarios/controller/posta_comentario.dart';
import 'package:apprevistas_aplicativo/pages/tela_comentarios/fragments/bloco_comentario.dart';
import 'package:apprevistas_aplicativo/pages/tela_comentarios/model/comentario.dart';
import 'package:apprevistas_aplicativo/pages/tela_inicio/fragments/cores.dart';
import 'package:apprevistas_aplicativo/pages/tela_login/view/solicita_login.dart';
import 'package:apprevistas_aplicativo/widgets_pers.dart';
import 'package:flutter/material.dart';

class TelaComentarios extends StatefulWidget {
  final String idNoticia;
  final String idDoUsuario;


  //Atencao: Essa 'keyy' e a key que o servidor necessita para permitir o envio de dados. 
  //A 'key' normal e um parametro do flutter que nao utilizamos
  final String keyy;
  TelaComentarios({Key key, @required this.idNoticia, @required this.keyy, @required this.idDoUsuario});
  
  @override
  _TelaComentariosState createState() => _TelaComentariosState();
}

class _TelaComentariosState extends State<TelaComentarios> {



  static final Key _campoTextoKey = new GlobalKey<FormState>();
  Key k1 = new GlobalKey();
TextEditingController controllerComentario;
@override
  void initState() {
   controllerComentario = TextEditingController();
    super.initState();
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: corPrincipal,
          title: Text('Comentários'),
        ),
        backgroundColor: Colors.white,
        body: elementosTelaComentarios());
  }

  elementosTelaComentarios() {

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      children: <Widget>[
        FutureBuilder<List<Comentario>>(
          future: getComentario(widget.idNoticia),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return listaDeComentarios(snapshot.data);
            } else
              return Center(child: CircularProgressIndicator());
          },
        ),
        Form(
          //key: _campoTextoKey,
         child: Column(
            children: <Widget>[
              Card(
          child:              
          textFieldComentario('Comentário...', controllerComentario),),
          Padding(padding: EdgeInsets.all(5),
          child: 
           botaoPadrao('Comentar', ()async{
             if(widget.idDoUsuario != null && widget.idNoticia != null){
             await postaComentario(widget.idNoticia, widget.idDoUsuario, controllerComentario.text, widget.keyy);
             setState(() {
               controllerComentario.text='';
             });
             }
             else{
               solicitaLogin(context, Constantes.FLAG_COMENTARIOS,idNoticia: widget.idNoticia, );
             }

              }))
             
            ],
          ),
        )
      ]
    );
  }

  ListView listaDeComentarios(List<Comentario> comentarios) {
    return ListView.builder(
      
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: comentarios.length,
      itemBuilder: (context, indice) {
        return Column(
          children: <Widget>[
blocoComentario(comentarios[indice], context),
Divider(color: Colors.black54,)
          ],
        );
      },
    );
  }
}
