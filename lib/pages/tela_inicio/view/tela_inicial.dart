

import 'package:apprevistas_aplicativo/pages/tela_inicio/controller/carrega_noticias.dart';
import 'package:apprevistas_aplicativo/pages/tela_inicio/fragments/bloco_noticia.dart';
import 'package:apprevistas_aplicativo/pages/tela_inicio/fragments/cores.dart';
import 'package:apprevistas_aplicativo/pages/tela_inicio/fragments/modal_login.dart';
import 'package:apprevistas_aplicativo/pages/tela_inicio/model/noticia.dart';
import 'package:apprevistas_aplicativo/pages/tela_revista/model/artigo.dart';
import 'package:apprevistas_aplicativo/pages/tela_revista/model/edicao.dart';
import 'package:apprevistas_aplicativo/pages/tela_revista/model/revista.dart';
import 'package:apprevistas_aplicativo/pages/tela_revista/view/tela_revista.dart';
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
          child: ListView(
            
            children: <Widget>[
              UserAccountsDrawerHeader(
  accountName: Text("Ricardo Henrique"),
  accountEmail: Text("ricardosousa339@gmail.com"),
  currentAccountPicture: 
  
  
  
  GestureDetector(child: CircleAvatar(
    backgroundColor:
        Theme.of(context).platform == TargetPlatform.iOS
            ? Colors.blue
            : Colors.white,
    child: Text(
      "RH",
      style: TextStyle(fontSize: 40.0),
    ),
  ),
  onTap:(){ 
    
    Navigator.of(context).pop();
    showDialog(
    context: context,
    builder: (BuildContext context){
      return telaDeLogin();
    }
  );}
  ),
  
  onDetailsPressed: (){
    
  },
),
              
              ListTile(
                title: Text('Revista Observatório'),
                trailing: Icon(Icons.star),
              ),
              ListTile(
                title: Text('Revista Desafios'),
                trailing: Icon(Icons.star),
              ),
              ListTile(
                title: Text('Revista Aturá'),
              ),
              ListTile(
                title: Text('Revista Brasileira de Educação do Campo'),
              ),
              ListTile(
                title: Text('Arquivos Brasileiros de Educação Física'),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: corPrincipal,
          currentIndex: _indicePaginaInferior,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.view_agenda), title: Text('Notícias')),
            BottomNavigationBarItem(
                icon: Icon(Icons.library_books), title: Text('Revistas'))
          ],
          onTap: _onItemTapped,
        ),
        body: Container(
            decoration: new BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [corPrincipal, corSecundaria])),
            child: _indicePaginaInferior == 0
                ? paginaNoticias()
                : paginaRevistas()));
                
  }

//Colocar pra carregar mais automaticamente
//https://medium.com/@KarthikPonnam/flutter-loadmore-in-listview-23820612907d
// Retorna todo o corpo da lista de notícias
  ListView paginaNoticias() {
    return ListView.builder(
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
        });
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
                    Revista revista = new Revista(
                       nomeDaRevista: 'Observatório',
                        edicoes: [
                          new Edicao(ano: 2015, issn: '1221', nome: 'Vol. 01 N. 01', artigos: [
                            new Artigo(ano: '2010', titulo: 'EXTENSÃO EM JORNALISMO E COMUNICAÇÃO: diálogos por e entre saberes', autores: ['Duílio Fabbri Júnior', 'Fabiano Ormaneze', 'Sandra de Deus', 'Nelson Russo de Moraes', 'Francisco Gilson Rebouças Porto Junior'], descricao: "Adjdj aammsms amammsns mamamssnm amsn", dia:'12',mes:'2',),
                             new Artigo(ano: '2010', titulo: 'EUFONIA: RADIOJORNALISMO EDUCATIVO NO SEMIÁRIDO', autores: ['Duílio Fabbri Júnior', 'Fabiano Ormaneze', 'Sandra de Deus', 'Nelson Russo de Moraes', 'Francisco Gilson Rebouças Porto Junior'], descricao: "Adjdj aammsms amammsns mamamssnm amsn", dia:'12',mes:'2',),
                          ],urlDaCapa: 'images/cover_issue_112_pt_BR.png'),
                          new Edicao(ano: 2015, issn: '1222', nome: 'Vol. 01 N.02', urlDaCapa: 'images/cover_issue_113_pt_BR.png', artigos: [                        new Artigo(ano: '2010', titulo: 'EXTENSÃO EM JORNALISMO E COMUNICAÇÃO: diálogos por e entre saberes', autores: ['Duílio Fabbri Júnior', 'Fabiano Ormaneze', 'Sandra de Deus', 'Nelson Russo de Moraes', 'Francisco Gilson Rebouças Porto Junior'], descricao: "Adjdj aammsms amammsns mamamssnm amsn", dia:'12',mes:'2',),
                             new Artigo(ano: '2010', titulo: 'EUFONIA: RADIOJORNALISMO EDUCATIVO NO SEMIÁRIDO', autores: ['Duílio Fabbri Júnior', 'Fabiano Ormaneze', 'Sandra de Deus', 'Nelson Russo de Moraes', 'Francisco Gilson Rebouças Porto Junior'], descricao: "Adjdj aammsms amammsns mamamssnm amsn", dia:'12',mes:'2',),
    ]),
                          new Edicao(ano: 2015, issn: '1223', nome: 'Vol. 01 N.03', urlDaCapa: 'images/cover_issue_123_pt_BR.png', artigos: [                        new Artigo(ano: '2010', titulo: 'EXTENSÃO EM JORNALISMO E COMUNICAÇÃO: diálogos por e entre saberes', autores: ['Duílio Fabbri Júnior', 'Fabiano Ormaneze', 'Sandra de Deus', 'Nelson Russo de Moraes', 'Francisco Gilson Rebouças Porto Junior'], descricao: "Adjdj aammsms amammsns mamamssnm amsn", dia:'12',mes:'2',),
                             new Artigo(ano: '2010', titulo: 'EUFONIA: RADIOJORNALISMO EDUCATIVO NO SEMIÁRIDO', autores: ['Duílio Fabbri Júnior', 'Fabiano Ormaneze', 'Sandra de Deus', 'Nelson Russo de Moraes', 'Francisco Gilson Rebouças Porto Junior'], descricao: "Adjdj aammsms amammsns mamamssnm amsn", dia:'12',mes:'2',),
    ]),
                          new Edicao(ano: 2016, issn: '1224', nome: 'Vol. 02 N.01', urlDaCapa: 'images/cover_issue_114_pt_BR.png', artigos: [                        new Artigo(ano: '2010', titulo: 'EXTENSÃO EM JORNALISMO E COMUNICAÇÃO: diálogos por e entre saberes', autores: ['Duílio Fabbri Júnior', 'Fabiano Ormaneze', 'Sandra de Deus', 'Nelson Russo de Moraes', 'Francisco Gilson Rebouças Porto Junior'], descricao: "Adjdj aammsms amammsns mamamssnm amsn", dia:'12',mes:'2',),
                             new Artigo(ano: '2010', titulo: 'EUFONIA: RADIOJORNALISMO EDUCATIVO NO SEMIÁRIDO', autores: ['Duílio Fabbri Júnior', 'Fabiano Ormaneze', 'Sandra de Deus', 'Nelson Russo de Moraes', 'Francisco Gilson Rebouças Porto Junior'], descricao: "Adjdj aammsms amammsns mamamssnm amsn", dia:'12',mes:'2',),
    ]),
                          new Edicao(ano: 2016, issn: '1225', nome: 'Vol. 02 N.02', urlDaCapa: 'images/cover_issue_145_pt_BR.png',artigos: [                        new Artigo(ano: '2010', titulo: 'EXTENSÃO EM JORNALISMO E COMUNICAÇÃO: diálogos por e entre saberes', autores: ['Duílio Fabbri Júnior', 'Fabiano Ormaneze', 'Sandra de Deus', 'Nelson Russo de Moraes', 'Francisco Gilson Rebouças Porto Junior'], descricao: "Adjdj aammsms amammsns mamamssnm amsn", dia:'12',mes:'2',),
                             new Artigo(ano: '2010', titulo: 'EUFONIA: RADIOJORNALISMO EDUCATIVO NO SEMIÁRIDO', autores: ['Duílio Fabbri Júnior', 'Fabiano Ormaneze', 'Sandra de Deus', 'Nelson Russo de Moraes', 'Francisco Gilson Rebouças Porto Junior'], descricao: "Adjdj aammsms amammsns mamamssnm amsn", dia:'12',mes:'2',),
    ]),
                          new Edicao(ano: 2016, issn: '1226', nome: 'Vol. 02 N.03', urlDaCapa: 'images/cover_issue_141_pt_BR.png', artigos: [                        new Artigo(ano: '2010', titulo: 'EXTENSÃO EM JORNALISMO E COMUNICAÇÃO: diálogos por e entre saberes', autores: ['Duílio Fabbri Júnior', 'Fabiano Ormaneze', 'Sandra de Deus', 'Nelson Russo de Moraes', 'Francisco Gilson Rebouças Porto Junior'], descricao: "Adjdj aammsms amammsns mamamssnm amsn", dia:'12',mes:'2',),
                             new Artigo(ano: '2010', titulo: 'EUFONIA: RADIOJORNALISMO EDUCATIVO NO SEMIÁRIDO', autores: ['Duílio Fabbri Júnior', 'Fabiano Ormaneze', 'Sandra de Deus', 'Nelson Russo de Moraes', 'Francisco Gilson Rebouças Porto Junior'], descricao: "Adjdj aammsms amammsns mamamssnm amsn", dia:'12',mes:'2',),
    ]),
                          new Edicao(ano: 2016, issn: '1227', nome: 'Vol. 02 N.04', urlDaCapa: 'images/cover_issue_157_pt_BR.png', artigos: [                        new Artigo(ano: '2010', titulo: 'EXTENSÃO EM JORNALISMO E COMUNICAÇÃO: diálogos por e entre saberes', autores: ['Duílio Fabbri Júnior', 'Fabiano Ormaneze', 'Sandra de Deus', 'Nelson Russo de Moraes', 'Francisco Gilson Rebouças Porto Junior'], descricao: "Adjdj aammsms amammsns mamamssnm amsn", dia:'12',mes:'2',),
                             new Artigo(ano: '2010', titulo: 'EUFONIA: RADIOJORNALISMO EDUCATIVO NO SEMIÁRIDO', autores: ['Duílio Fabbri Júnior', 'Fabiano Ormaneze', 'Sandra de Deus', 'Nelson Russo de Moraes', 'Francisco Gilson Rebouças Porto Junior'], descricao: "Adjdj aammsms amammsns mamamssnm amsn", dia:'12',mes:'2',),
    ]),
                          new Edicao(ano: 2016, issn: '1228', nome: 'Vol. 02 N.05', urlDaCapa: 'images/cover_issue_142_pt_BR.png', artigos: [                        new Artigo(ano: '2010', titulo: 'EXTENSÃO EM JORNALISMO E COMUNICAÇÃO: diálogos por e entre saberes', autores: ['Duílio Fabbri Júnior', 'Fabiano Ormaneze', 'Sandra de Deus', 'Nelson Russo de Moraes', 'Francisco Gilson Rebouças Porto Junior'], descricao: "Adjdj aammsms amammsns mamamssnm amsn", dia:'12',mes:'2',),
                             new Artigo(ano: '2010', titulo: 'EUFONIA: RADIOJORNALISMO EDUCATIVO NO SEMIÁRIDO', autores: ['Duílio Fabbri Júnior', 'Fabiano Ormaneze', 'Sandra de Deus', 'Nelson Russo de Moraes', 'Francisco Gilson Rebouças Porto Junior'], descricao: "Adjdj aammsms amammsns mamamssnm amsn", dia:'12',mes:'2',),
    ]),
                          new Edicao(ano: 2017, issn: '1229', nome: 'Vol. 03 N.01', urlDaCapa: 'images/cover_issue_175_pt_BR.png'),
                          new Edicao(ano: 2017, issn: '1230', nome: 'Vol. 03 N.02', urlDaCapa: 'images/cover_issue_178_pt_BR.png'),
                          new Edicao(ano: 2017, issn: '1231', nome: 'Vol. 03 N.03', urlDaCapa: 'images/cover_issue_199_pt_BR.png'),
                          new Edicao(ano: 2017, issn: '1232', nome: 'Vol. 03 N.04', urlDaCapa: 'images/cover_issue_179_pt_BR.png'),
                          new Edicao(ano: 2017, issn: '1233', nome: 'Vol. 03 N.05', urlDaCapa: 'images/cover_issue_180_pt_BR.png'),
                          new Edicao(ano: 2017, issn: '1234', nome: 'Vol. 03 N.06', urlDaCapa: 'images/cover_issue_181_pt_BR.png'),
                          new Edicao(ano: 2018, issn: '1235', nome: 'Vol. 04 N.01', urlDaCapa: 'images/cover_issue_206_pt_BR.png'),
                          new Edicao(ano: 2018, issn: '1236', nome: 'Vol. 04 N.02', urlDaCapa: 'images/cover_issue_219_pt_BR.png'),
                          new Edicao(ano: 2018, issn: '1237', nome: 'Vol. 04 N.03', urlDaCapa: 'images/cover_issue_227_pt_BR.png'),
                          new Edicao(ano: 2018, issn: '1238', nome: 'Vol. 04 N.04', urlDaCapa: 'images/cover_issue_218_pt_BR.png'),
                          new Edicao(ano: 2018, issn: '1239', nome: 'Vol. 04 N.05', urlDaCapa: 'images/cover_issue_213_pt_BR.png'),
                          new Edicao(ano: 2018, issn: '1240', nome: 'Vol. 04 N.06', urlDaCapa: 'images/cover_issue_280_pt_BR.png'),
                          new Edicao(ano: 2019, issn: '1241', nome: 'Vol. 05 N.01', urlDaCapa: 'images/cover_issue_241_pt_BR.png'),
                          new Edicao(ano: 2019, issn: '1242', nome: 'Vol. 05 N.02', urlDaCapa: 'images/cover_issue_339_pt_BR.png'),
                          new Edicao(ano: 2019, issn: '1243', nome: 'Vol. 05 N.03', urlDaCapa: 'images/cover_issue_237_pt_BR.png'),
                          new Edicao(ano: 2019, issn: '1244', nome: 'Vol. 05 N.04', urlDaCapa: 'images/cover_issue_341_pt_BR.png'),
                          
                          

                        ]);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TelaRevista(revista: revista)));

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
