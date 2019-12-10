import 'dart:convert';
import 'dart:io';

import 'package:apprevistas_aplicativo/pages/tela_artigo/view/tela_artigos_favoritos.dart';
import 'package:apprevistas_aplicativo/pages/tela_busca_artigo/view/tela_busca_artigo.dart';
import 'package:apprevistas_aplicativo/pages/tela_inicio/view/postar_noticia.dart';
import 'package:apprevistas_aplicativo/pages/tela_login/model/usuario.dart';
import 'package:apprevistas_aplicativo/pages/tela_login/view/tela_login.dart';
import 'package:apprevistas_aplicativo/pages/tela_revista/controller/carrega_revistas.dart';
import 'package:http/http.dart' as http;

import 'package:apprevistas_aplicativo/pages/tela_inicio/controller/carrega_noticias.dart';
import 'package:apprevistas_aplicativo/pages/tela_inicio/fragments/bloco_noticia.dart';
import 'package:apprevistas_aplicativo/pages/tela_inicio/fragments/cores.dart';
import 'package:apprevistas_aplicativo/pages/tela_inicio/model/noticia.dart';
import 'package:apprevistas_aplicativo/pages/tela_revista/model/revista.dart';
import 'package:apprevistas_aplicativo/pages/tela_revista/view/tela_revista.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../urls.dart';

class TelaInicial extends StatefulWidget {
  TelaInicial({
    Key key,
    this.flag,
    this.keyy,
    this.user,
  }) : super(key: key);
  final String flag;
  String keyy;
  Usuario user;

  @override
  _TelaInicialState createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  bool exibirInfoLogin = false;

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

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String _key;

//Lista de revistas
  List revistas = new List();
  List<Revista> objetosRevistas;

  @override
  void initState() {
    verificaLogin();
    getRevista();
    //Obter os dados do usuario logado

    //A pagina que comeca aberta e a primeira, a de noticias
    _indicePaginaInferior = 0;

    //widget.user.id = "0";

    /*
      _noticiasController.addListener((){
        if (_noticiasController.position.pixels == _noticiasController.position.maxScrollExtent) {
          _indice_Noticia++;
        }
      });
      ricardosousa339@gmail.com
      12345678
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
        //key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: corPrincipal,
          title: Text(_paginaAtual != null ? _paginaAtual : 'Início'),
        ),
        drawer: drawerTelaInicial(),
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
              : FutureBuilder(
                  future: carregaRevistas(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Revista>> snapshot) {
                    if (snapshot.hasData) {
                      return revistasPagina(snapshot.data);
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _indicePaginaInferior == 0 &&
                widget.user != null &&
                widget.user.eAdministrador
            ? FloatingActionButton(
                backgroundColor: corTerciaria,
                child: Icon(Icons.edit),
                onPressed: () {
                  if (widget.user == null) {
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PostarNoticia(
                                  keyy: widget.keyy,
                                  revistas: objetosRevistas,
                                  idUsuario: widget.user.id,
                                  user: widget.user,
                                )));
                  }
                },
              )
            : _indicePaginaInferior == 1
                ? FloatingActionButton(
                    child: Icon(Icons.search),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TelaBuscaArtigo(
                                  keyy: widget.keyy,
                                  idUsuario: widget.user != null
                                      ? widget.user.id
                                      : null)));
                    },
                  )
                : Text(''));
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
          } else {
            return Center(child: CircularProgressIndicator());
          }
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
  }

  GridView revistasPagina(List<Revista> revistas) {
    return GridView.count(
      scrollDirection: Axis.vertical,
      crossAxisCount: 1,
      childAspectRatio: 16 / 10,
      children: List.generate(revistas.length, (indice) {
        return Card(
            margin: EdgeInsets.all(10),
            child: GestureDetector(
                child: Card(
                    child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    Positioned.fill(
                      child: Image.network(revistas[indice].imagem,
                          fit: BoxFit.fitWidth),
                    ),
                    Container(
                      color: Colors.black26,
                      //padding: EdgeInsets.fromLTRB(5, 100, 5, 5),
                      child: Text(
                        revistas[indice].nomeRevistaPortugues,
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                )),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TelaRevista(
                                keyy: widget.keyy,
                                nomeRevista:
                                    revistas[indice].nomeRevistaPortugues,
                                idRevista: (revistas[indice].id.toString()),
                                idUsuario: widget.user != null
                                    ? widget.user.idServer
                                    : null,
                              )));
                }));

        //
      }),
    );
  }
  //Retorna todo o corpo da página que aparece quando se clica pra trocar de Notícias pra Revistas

  Column paginaRevistas(List<Revista> revistas) {
    instance = new CarouselSlider(
      aspectRatio: 16 / 9,
      initialPage: 0,
      autoPlayCurve: Curves.easeInOut,
      autoPlayDuration: new Duration(seconds: 1),
      items: revistas == null
          ? null
          : revistas.map(
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
                                        keyy: widget.keyy,
                                        nomeRevista: it.nomeRevistaPortugues,
                                        idRevista: (it.id.toString()),
                                        idUsuario: widget.user != null
                                            ? widget.user.idServer
                                            : null,
                                      )));
                        },
                        child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(color: Colors.grey),
                            child: Container(
                              child: Image.network(it.imagem),
                            ))));
              },
            ).toList(),
      //height: 300,
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

  //As noticias usam id, o identificador do banco de dados
  //Pra adicionar um artigo aos favoritos, usa o id do banco de dados
  //Pra listar os favoritos usa o idServer, mais interno do django

  ListView listaNoticias(List<Noticia> noticias) {
    return ListView.builder(
      itemCount: noticias.length,
      itemBuilder: (context, indice) {
        if (widget.user != null) {
          return cardBlocoNoticia(
              noticias[indice], context, widget.user.id, widget.keyy);
        } else {
          return cardBlocoNoticia(noticias[indice], context, null, null);
        }
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
  Drawer drawerTelaInicial() {
    if (widget.user != null) {
      return new Drawer(
        child: widget.user != null
            ? ListView(
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountName: Text(widget.user.primeiroNome +
                        " " +
                        widget.user.segundoNome),
                    accountEmail: Text(widget.user.email),
                    currentAccountPicture: GestureDetector(
                        child: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).platform == TargetPlatform.iOS
                                  ? Colors.blue
                                  : Colors.white,
                          child: Text(
                            widget.user.primeiroNome[0] +
                                widget.user.segundoNome[0],
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
                  GestureDetector(
                    child: ListTile(
                      title: Text('Artigos favoritos'),
                      onTap: () {
                        //TODO: Levar pra lista de artigos favoritos

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TelaArtigosFavoritos(
                                      keyy: widget.keyy,
                                      idDoUsuario: widget.user.id,
                                      idUsuarioServer: widget.user.idServer,
                                      revistas: objetosRevistas,
                                    )));
                      },
                    ),
                  ),
                  GestureDetector(
                    child: ListTile(
                      title: Text('Sair da conta'),
                      onTap: () {
                          apagaSharedPreferences();

                        setState(() {
                          widget.user = null;
                          widget.keyy = null;
                          http.post(raizApi + '/rest-auth/logout/');
                        });
                      },
                    ),
                  )
                ],
              )
            : null,
      );
    } else {
      return Drawer(
        child: ListView(
          children: <Widget>[
            GestureDetector(
                child: ListTile(
                  title: Text('Fazer login'),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return LoginScreen();
                      });
                })
          ],
        ),
      );
    }
  }

  Future verificaLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('key') != null) {
      setState(() {
        Usuario usuario = Usuario();
        widget.keyy = prefs.getString('key');
        usuario.primeiroNome = prefs.getString('primeiroNome');
        usuario.segundoNome = prefs.getString('segundoNome');
        usuario.email = prefs.getString('email');
        usuario.id = prefs.getString(
          'id',
        );
        usuario.idServer = prefs.getString('idServer');
        usuario.urlDaFotoDePerfil = prefs.getString('urlDaFotoDePerfil');
        usuario.eAdministrador = prefs.getBool('eAdministrador');
        widget.user = usuario;
      });
    }
  }

  Future apagaSharedPreferences()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
preferences.clear();
  }
}
