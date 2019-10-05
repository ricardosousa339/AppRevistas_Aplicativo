
import 'package:apprevistas_aplicativo/controller/carrega_noticias.dart';
import 'package:apprevistas_aplicativo/model/noticia.dart';
import 'package:apprevistas_aplicativo/view/fragments/bloco_noticia.dart';
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
  int _indiceNoticia;

  //Controlador de carregamento das paginas, para que carregue uma quantidade de noticias por vez
  PageController _noticiasController = new PageController();

//Lista de paginas acessiveis na tela inicial (Noticias e Revistas)
  List<Column> paginasInicio = new List();

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
          title: Text('Início'),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _indicePaginaInferior,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.view_agenda),
              title: Text('Notícias'),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.library_books), title: Text('Revistas'))
          ],
          onTap: _onItemTapped,
        ),
        body: _indicePaginaInferior == 0
            ? paginaNoticias()
            : paginaRevistas());
  }





//Colocar pra carregar mais automaticamente
//https://medium.com/@KarthikPonnam/flutter-loadmore-in-listview-23820612907d
// Retorna todo o corpo da lista de notícias
  ListView paginaNoticias() {
    return ListView.builder(
        itemCount: 100,
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
                return Center( widthFactor: 2.0, heightFactor: 2.0, child: CircularProgressIndicator());
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
              child: 
              
              GestureDetector(
  onTap: () {
    print(it);
  },
  child:Image.network(it,)));

              
              
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
