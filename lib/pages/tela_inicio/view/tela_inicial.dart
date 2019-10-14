import 'dart:ui' as prefix0;

import 'package:apprevistas_aplicativo/pages/tela_inicio/controller/carrega_noticias.dart';
import 'package:apprevistas_aplicativo/pages/tela_inicio/fragments/bloco_noticia.dart';
import 'package:apprevistas_aplicativo/pages/tela_inicio/fragments/cores.dart';
import 'package:apprevistas_aplicativo/pages/tela_inicio/model/noticia.dart';
import 'package:apprevistas_aplicativo/pages/tela_revista/model/artigo.dart';
import 'package:apprevistas_aplicativo/pages/tela_revista/model/edicao.dart';
import 'package:apprevistas_aplicativo/pages/tela_revista/model/revista.dart';
import 'package:apprevistas_aplicativo/pages/tela_revista/view/tela_edicoes.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

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
  int _indicePaginaInferior;

  //Lista de noticias
  List<Noticia> noticias = new List();

  //Indice da noticia sendo carregada no momento
  int _numeroDeNoticias;

  //Controlador de carregamento das paginas, para que carregue uma quantidade de noticias por vez
  PageController _noticiasController = new PageController();

//Lista de paginas acessiveis na tela inicial (Noticias e Revistas)
  List<Column> paginasInicio = new List();


  //Variável com o nome da página atual
  String _paginaAtual = 'Notícias';

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

    //A pagina que comeca aberta e a primeira, a de noticias
    _indicePaginaInferior = 0;
    _numeroDeNoticias = 100;

/*
  _noticiasController.addListener((){
    if (_noticiasController.position.pixels == _noticiasController.position.maxScrollExtent) {
      _indice_Noticia++;
    }
  });
  */
    super.initState();
  }

//Detecta qual pagina foi selecionada e muda pra ela (revistas ou notícias)
  _onItemTapped(int index) {
    setState(() {
      _indicePaginaInferior = index;
      index == 0 ? _paginaAtual = 'Notícias' : _paginaAtual = 'Revistas';
    });
  }

  @override
  void dispose() {
    _noticiasController.dispose();
    super.dispose();
  }

//Parte principal e barra de navegação inferior

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: corPrincipal,
        title: Text(_paginaAtual != null ? _paginaAtual : 'Início'),
      ),
      drawer: new Drawer(
        
      ),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: corPrincipal,
          currentIndex: _indicePaginaInferior,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.view_agenda),
              
              title: Text('Notícias')
              
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.library_books), 
                title: Text('Revistas'))
          ],
          onTap: _onItemTapped,
        ),
        body: Container(
      decoration: new BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors:[corPrincipal , corSecundaria])),
      child:
        _indicePaginaInferior == 0 ? paginaNoticias() : paginaRevistas()
        ));
  }

//Colocar pra carregar mais automaticamente
//https://medium.com/@KarthikPonnam/flutter-loadmore-in-listview-23820612907d
// Retorna todo o corpo da lista de notícias
  ListView paginaNoticias() {
    return  ListView.builder(
          itemCount: _numeroDeNoticias,
          controller: _noticiasController,
          itemBuilder: (BuildContext context, int index) {
            return FutureBuilder<Noticia>(
                future: getNoticia(index),
                builder: (context, snapshot) {
                  if (index == 0) {
                    return Center();
                  }
                  if (snapshot.hasData) {
                    noticias.add(snapshot.data);
                    return cardBlocoNoticia(snapshot.data, context);
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return Center(
                      widthFactor: 3.0,
                      heightFactor: 3.0,
                      child: CircularProgressIndicator());
                });
          }
    );
  }

  //Retorna todo o corpo da página que aparece quando se clica pra trocar de Notícias pra Revistas

  Column paginaRevistas() {
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
              child: GestureDetector(
                  onTap: () {

                    Revista revista =  new Revista(urlDaCapa: 'https://sistemas.uft.edu.br/periodicos/public/journals/20/journalThumbnail_pt_BR.png',nomeDaRevista:'Observatório',edicoes: [new Edicao(issn: '1221', nome: 'N. 01',artigos: [new Artigo(ano:'2010',titulo: 'Artigo bla')])]);

 Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TelaEdicoes(revista: revista)));

                    print(it);
                  },
                  child: Image.network(
                    it,
                  )));
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
