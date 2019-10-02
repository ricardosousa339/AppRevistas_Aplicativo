import 'dart:convert';

import 'package:apprevistas_aplicativo/conteudo/noticia.dart';
import 'package:apprevistas_aplicativo/telas/tela_noticia.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class TelaInicial extends StatefulWidget {
  TelaInicial({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _TelaInicialState createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {


  //Armazena as urls das fotos das capas
  List<String> capas = new List();

  //Instancia pra galeria de fotos com as capas
  CarouselSlider instance;

  //Indice da barra de navegacao inferior
  int _indice_pagina_inferior;

  //Lista de noticias
  List<Noticia> noticias = new List();

  //Indice da noticia sendo carregada no momento
  int _indice_Noticia;

  //Controlador de carregamento das paginas, para que carregue uma quantidade de noticias por vez
  PageController _noticiasController = new PageController();


//Lista de paginas acessiveis na tela inicial (Noticias e Revistas)
List<Column> paginas_inicio = new List();
  @override
  void initState() {


    // Informações de teste inseridas
    capas.add(
        'https://sistemas.uft.edu.br/periodicos/public/journals/20/journalThumbnail_pt_BR.png');
    capas.add(
        'https://sistemas.uft.edu.br/periodicos/public/journals/26/journalThumbnail_pt_BR.png');
    capas.add(
        'https://sistemas.uft.edu.br/periodicos/public/journals/35/journalThumbnail_pt_BR.png');
    capas.add(
        'https://sistemas.uft.edu.br/periodicos/public/journals/33/journalThumbnail_pt_BR.jpg');
    capas.add(
        'https://sistemas.uft.edu.br/periodicos/public/journals/38/journalThumbnail_pt_BR.png');

    noticias.add(Noticia(titulo: 'Pesquisadores da UFT desenvolvem teste rápido para diagnosticar o Zika Vírus',conteudo: 'Um projeto desenvolvido por pesquisadores da Universidade Federal do Tocantins possibilitará o desenvolvimento de kits de diagnóstico para detecção do Zika vírus via análise do DNA, com um valor reduzido se comparado aos valores atuais do exame para detecção da doença'));
    noticias.add(Noticia(titulo: 'Pesquisadores da UFT desenvolvem teste rápido para diagnosticar o Zika Vírus',conteudo: 'Um projeto desenvolvido por pesquisadores da Universidade Federal do Tocantins possibilitará o desenvolvimento de kits de diagnóstico para detecção do Zika vírus via análise do DNA, com um valor reduzido se comparado aos valores atuais do exame para detecção da doença'));
    noticias.add(Noticia(titulo: 'Pesquisadores da UFT desenvolvem teste rápido para diagnosticar o Zika Vírus',conteudo: 'Um projeto desenvolvido por pesquisadores da Universidade Federal do Tocantins possibilitará o desenvolvimento de kits de diagnóstico para detecção do Zika vírus via análise do DNA, com um valor reduzido se comparado aos valores atuais do exame para detecção da doença'));
    noticias.add(Noticia(titulo: 'Pesquisadores da UFT desenvolvem teste rápido para diagnosticar o Zika Vírus',conteudo: 'Um projeto desenvolvido por pesquisadores da Universidade Federal do Tocantins possibilitará o desenvolvimento de kits de diagnóstico para detecção do Zika vírus via análise do DNA, com um valor reduzido se comparado aos valores atuais do exame para detecção da doença'));
    noticias.add(Noticia(titulo: 'Pesquisadores da UFT desenvolvem teste rápido para diagnosticar o Zika Vírus',conteudo: 'Um projeto desenvolvido por pesquisadores da Universidade Federal do Tocantins possibilitará o desenvolvimento de kits de diagnóstico para detecção do Zika vírus via análise do DNA, com um valor reduzido se comparado aos valores atuais do exame para detecção da doença'));
    noticias.add(Noticia(titulo: 'Pesquisadores da UFT desenvolvem teste rápido para diagnosticar o Zika Vírus',conteudo: 'Um projeto desenvolvido por pesquisadores da Universidade Federal do Tocantins possibilitará o desenvolvimento de kits de diagnóstico para detecção do Zika vírus via análise do DNA, com um valor reduzido se comparado aos valores atuais do exame para detecção da doença'));
    noticias.add(Noticia(titulo: 'Pesquisadores da UFT desenvolvem teste rápido para diagnosticar o Zika Vírus',conteudo: 'Um projeto desenvolvido por pesquisadores da Universidade Federal do Tocantins possibilitará o desenvolvimento de kits de diagnóstico para detecção do Zika vírus via análise do DNA, com um valor reduzido se comparado aos valores atuais do exame para detecção da doença'));
    noticias.add(Noticia(titulo: 'Pesquisadores da UFT desenvolvem teste rápido para diagnosticar o Zika Vírus',conteudo: 'Um projeto desenvolvido por pesquisadores da Universidade Federal do Tocantins possibilitará o desenvolvimento de kits de diagnóstico para detecção do Zika vírus via análise do DNA, com um valor reduzido se comparado aos valores atuais do exame para detecção da doença'));
    noticias.add(Noticia(titulo: 'Pesquisadores da UFT desenvolvem teste rápido para diagnosticar o Zika Vírus',conteudo: 'Um projeto desenvolvido por pesquisadores da Universidade Federal do Tocantins possibilitará o desenvolvimento de kits de diagnóstico para detecção do Zika vírus via análise do DNA, com um valor reduzido se comparado aos valores atuais do exame para detecção da doença'));
    noticias.add(Noticia(titulo: 'Pesquisadores da UFT desenvolvem teste rápido para diagnosticar o Zika Vírus',conteudo: 'Um projeto desenvolvido por pesquisadores da Universidade Federal do Tocantins possibilitará o desenvolvimento de kits de diagnóstico para detecção do Zika vírus via análise do DNA, com um valor reduzido se comparado aos valores atuais do exame para detecção da doença'));
    noticias.add(Noticia(titulo: 'Pesquisadores da UFT desenvolvem teste rápido para diagnosticar o Zika Vírus',conteudo: 'Um projeto desenvolvido por pesquisadores da Universidade Federal do Tocantins possibilitará o desenvolvimento de kits de diagnóstico para detecção do Zika vírus via análise do DNA, com um valor reduzido se comparado aos valores atuais do exame para detecção da doença'));
    noticias.add(Noticia(titulo: 'Pesquisadores da UFT desenvolvem teste rápido para diagnosticar o Zika Vírus',conteudo: 'Um projeto desenvolvido por pesquisadores da Universidade Federal do Tocantins possibilitará o desenvolvimento de kits de diagnóstico para detecção do Zika vírus via análise do DNA, com um valor reduzido se comparado aos valores atuais do exame para detecção da doença'));

//Indice comeca em 1 apenas por que a api usada comeca do 1
        _indice_Noticia = 1;
        //A pagina que comeca aberta e a primeira, a de noticias
        _indice_pagina_inferior = 0;

    //fetchMore(10);

    super.initState();
  }

//Detecta qual pagina foi selecionada e muda pra ela (revistas ou notícias)
  _onItemTapped(int index){
    setState(() {
      _indice_pagina_inferior = index; 
    });
  }

//Parte principal e barra de navegação inferior

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Início'),
        ),
        bottomNavigationBar:
            BottomNavigationBar(
              
              currentIndex: _indice_pagina_inferior,
              items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.view_agenda), title: Text('Notícias'),
                            
              ),
          BottomNavigationBarItem(
              icon: Icon(Icons.library_books), title: Text('Revistas'))
        ],
        onTap: _onItemTapped,
        ),
        body: _indice_pagina_inferior == 0 ? pagina_noticias() : pagina_revistas()
    );
  }

//Padronização do bloco de notícias

  Card bloco_noticia(Noticia noticia) {
    return Card(
      
      margin: EdgeInsets.fromLTRB(10,10,10,5),
      elevation: 4.0,
    
      child: ListTile(
        onTap: (){
          Navigator.push(context, 
          MaterialPageRoute(
            builder: (context) => TelaNoticia(noticia: noticia)
          ));
        },
        contentPadding: EdgeInsets.all(18),
        title: Text(noticia.titulo,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
        ),
        subtitle: Text(noticia.id.toString()+' '+noticia.conteudo, overflow: TextOverflow.ellipsis, maxLines: 3,),
      ),
    );
  }



//Função temporária que faz a requisição de uma notícia genérica
//TODO: Checar essa funcao
   fetch(int indice) async {
    final response = await http
        .get(' ');// + indice.toString());

    Noticia p;

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.

Iterable l = json.decode(response.body);
List<Noticia> posts = l.map((i)=> Noticia.fromJson(i)).toList();

     // p = Noticia.fromJson(json.decode(response.body));
      setState(() {
        noticias = posts.sublist(90);
        _indice_Noticia++;
      });
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }


   fetchMore(int intervalo) {
    for (int i = _indice_Noticia; i < _indice_Noticia + intervalo; i++) {
      fetch(i);
    }
  }

// Retorna todo o corpo da lista de notícias
  Column pagina_noticias() {
    return Column(children: <Widget>[
      Flexible(
        flex: 8,
        child: ListView.builder(
          
          itemCount: noticias.length,
          controller: _noticiasController,
          itemBuilder: (BuildContext context, int index) {
            return bloco_noticia(noticias[index]);
          },
        ),
      ),
    ]);
  }

  //Retorna todo o corpo da página que aparece quando se clica pra trocar de Notícias pra Revistas

  Column pagina_revistas() {
    instance = new CarouselSlider(
      autoPlay: true,
      autoPlayCurve: Curves.easeInOut,
      autoPlayDuration: new Duration(seconds: 1),
      items: capas.map(
        (it) {
          return new Container(
              width: MediaQuery.of(context).size.width,
              margin: new EdgeInsets.symmetric(horizontal: 5.0),
              //decoration: new BoxDecoration(color: Colors.white),
              child: Image.network(it));
        },
      ).toList(),
      height: MediaQuery.of(context).size.height,
    );
    return Column(
      children: <Widget>[
        Flexible(
          flex: 6,
          child: instance,
        )
      ],
    );
  }
}
