import 'dart:convert';
import 'dart:io';

import 'package:apprevistas_aplicativo/pages/tela_inicio/view/postar_noticia.dart';
import 'package:apprevistas_aplicativo/pages/tela_login/controller/get_usuario.dart';
import 'package:apprevistas_aplicativo/pages/tela_login/model/usuario.dart';
import 'package:apprevistas_aplicativo/pages/tela_login/view/tela_login.dart';
import 'package:http/http.dart' as http;

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
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../urls.dart';
import 'dart:ui' as ui;

class TelaInicial extends StatefulWidget {

  TelaInicial({Key key, this.flag,  this.keyy, this.user, }) : super(key: key);
  final String flag;
  final String keyy;
   Usuario user;

  @override
  _TelaInicialState createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  bool estaLogado = false;

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

String _key;

//Lista de revistas
  List revistas = new List();
  List<Revista> objetosRevistas;
  @override
  void initState() {

    //Obter os dados do usuario logado
   
    //A pagina que comeca aberta e a primeira, a de noticias
    _indicePaginaInferior = 0;
    _numeroDeNoticias = 100;

/*
  _noticiasController.addListener((){
    if (_noticiasController.position.pixels == _noticiasController.position.maxScrollExtent) {
      _indice_Noticia++;
    }
  });
  ricardosousa339@gmail.com
  12345678
  */
    getRevista();

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
        child: widget.user != null ? ListView(
          children: <Widget>[
            
            UserAccountsDrawerHeader(
              accountName:  Text(widget.user.primeiroNome+" "+widget.user.segundoNome) ,
              accountEmail: Text(widget.user.email) ,
              currentAccountPicture: GestureDetector(
                  child: CircleAvatar(
                    backgroundColor:
                        Theme.of(context).platform == TargetPlatform.iOS
                            ? Colors.blue
                            : Colors.white,
                    child: Text(
                      widget.user.primeiroNome[0]+widget.user.segundoNome[0],
                      style: TextStyle(fontSize: 40.0),
                    ),
                   
                  ),
                  
                  onTap: () {
                    Navigator.of(context).pop();
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return LoginScreen();
                        });
                  }),
              onDetailsPressed: () {},
            ),
          ],
        ) : null,
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
          child:
              _indicePaginaInferior == 0 ? paginaNoticias() : paginaRevistas()),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _indicePaginaInferior == 0
          ? FloatingActionButton(
              backgroundColor: corTerciaria,
              child: Icon(Icons.edit),
              onPressed: () {
                if (widget.user == null) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      // retorna um objeto do tipo Dialog
                      return AlertDialog(
                        title: new Text("Você não está logado!"),
                        content: new Text("Faça login para executar essa ação"),
                        actions: <Widget>[
                          // define os botões na base do dialogo
                          new FlatButton(
                            child: new Text("Login"),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            },
                          ),
                          FlatButton(
                              child: new Text("Voltar"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              })
                        ],
                      );
                    },
                  );
                }
                else{
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PostarNoticia(
                          keyy:widget.keyy,
                              revistas: objetosRevistas,
                              idUsuario: widget.user.id,
                            )));
              }},
            )
          : Center(),
    );
  }

//Colocar pra carregar mais automaticamente
//https://medium.com/@KarthikPonnam/flutter-loadmore-in-listview-23820612907d
// Retorna todo o corpo da lista de notícias
  FutureBuilder paginaNoticias() {
    return FutureBuilder<List<Noticia>>(
        future: getNoticia(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return listaNoticias(snapshot.data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(child: CircularProgressIndicator());
        });
  }

//Carrega as revistas e salva na lista

  getRevista() async {
    String uri = raizApi + '/api/revistas';

    var response = await http
        .get(Uri.encodeFull(uri), headers: {"Accept": "application/json"});

    var data = json.decode(utf8.decode(response.bodyBytes));
    var rest = data as List;
    //print('rest'+rest.toString());
    objetosRevistas =
        rest.map<Revista>((json) => Revista.fromJson(json)).toList();

    setState(() {
      var extractData = json.decode(utf8.decode(response.bodyBytes));
      revistas = extractData;

      print(revistas);
      print(extractData);
    });
  }

  //Retorna todo o corpo da página que aparece quando se clica pra trocar de Notícias pra Revistas

  Column paginaRevistas() {
    instance = new CarouselSlider(
      initialPage: 0,
      autoPlayCurve: Curves.easeInOut,
      autoPlayDuration: new Duration(seconds: 1),
      items: revistas.map(
        (it) {
          return new Container(
              width: MediaQuery.of(context).size.width,
              margin: new EdgeInsets.symmetric(horizontal: 5.0),
              //decoration: new BoxDecoration(color: Colors.white),
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TelaRevista(
                                  nomeRevista: it["nome_revista_portugues"],
                                  idRevista: (it["id"].toString()),
                                )));
                  },
                  child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Colors.grey),
                      child: Text(
                        it["nome_revista_portugues"].toString(),
                        style: TextStyle(fontSize: 75, color: Colors.white),
                      ))));
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

  ListView listaNoticias(List<Noticia> noticias) {
    return ListView.builder(
      itemCount: noticias.length,
      itemBuilder: (context, indice) {
        return cardBlocoNoticia(noticias[indice], context);
      },
    );
  }
 

/*
  checaSeUsuarioEstaLogado() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');

    if (email != null) {
      estaLogado = true;
    }
  }
  */
//ricardosousa339@gmail.com
//12345678
  carregaUsuario () async {
      //this.widget.user = await getUsuario(widget.user.email);
      
    
  }
}
