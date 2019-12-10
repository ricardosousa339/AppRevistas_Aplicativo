
import 'package:apprevistas_aplicativo/pages/tela_edicao/view/bloco_artigo.dart';
import 'package:apprevistas_aplicativo/pages/tela_revista/model/artigo.dart';
import 'package:apprevistas_aplicativo/urls.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class TelaBuscaArtigo extends StatefulWidget{
  String keyy;
  String idUsuario;

  TelaBuscaArtigo({this.keyy,this.idUsuario});

  _TelaBuscaArtigoState createState() => _TelaBuscaArtigoState();
}

class _TelaBuscaArtigoState extends State<TelaBuscaArtigo>{

// controls the text label we use as a search bar
  final TextEditingController _filter = new TextEditingController();
  final dio = new Dio(); // for http requests
  String _searchText = "";
  List names = new List(); // names we get from API
  List filteredNames = new List(); // names filtered by search text
  Icon _searchIcon = new Icon(Icons.search); 
  Widget _appBarTitle = new Text( 'Busca de artigos' );
  bool estaCarregando = false;

@override
  void initState() {
   // estaCarregando = true;
   //_getNames("");
    super.initState();
  }

@override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: _buildBar(context),
      body: Container(child: _buildList(),)
    );
    
  }

  void _getNames(String busca) async {
    setState(() {
    estaCarregando = true;
      
    });
  final response = await dio.get(raizApi+'/api/artigos'+'?search'+busca);
  List tempList = new List();
  for (int i = 0; i < response.data.length; i++) {
    tempList.add(response.data[i]);
  }
  
  setState(() {
    names = tempList;
    filteredNames = names;
    estaCarregando = false;
  });
}

void _searchPressed() {
  setState(() {
    
    if (this._searchIcon.icon == Icons.search) {
      this._searchIcon = new Icon(Icons.close);
      this._appBarTitle = new TextField(
        controller: _filter,
        decoration: new InputDecoration(
          prefixIcon: new Icon(Icons.search),
          hintText: 'Buscar...'
        ),
      );
    } else {
      this._searchIcon = new Icon(Icons.search);
      this._appBarTitle = new Text('Pesquisa de artigo');
      filteredNames = names;
      _filter.clear();
    }
    }
  );
}
 Widget _buildBar(BuildContext context) {
    return new AppBar(
      centerTitle: true,
      title: _appBarTitle,
      leading: new IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,

      ),
    );
  }

_TelaBuscaArtigoState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = names;
        });
      } else {
        estaCarregando = true;
        setState(() {
          
           _getNames(_filter.text);
          _searchText = _filter.text;

        });
        
      }
    });
  }
  Widget _buildList() {

    
    
  if (!(_searchText.isEmpty)) {
    List tempList = new List();
    for (int i = 0; i < filteredNames.length; i++) {
      if (filteredNames[i]['titulo_portugues'].toLowerCase().contains(_searchText.toLowerCase())) {
        tempList.add(filteredNames[i]);
      }
    }
    filteredNames = tempList;
  }
  if(filteredNames.length == 0 && estaCarregando){
    return Center(child: CircularProgressIndicator(),);
  }
  return ListView.builder(
    itemCount: names == null ? 0 : filteredNames.length,
    itemBuilder: (BuildContext context, int index) {
     
     
     return cardBlocoArtigo('Artigo', Artigo.fromJson(filteredNames[index]), context, widget.keyy, widget.idUsuario, false);
      return new 
      
      
      Column(children: <Widget>[
ListTile(
        title: Text(filteredNames[index]['titulo_portugues']),
        onTap: () => print(filteredNames[index]['titulo_portugues']),
      ),
      Divider()
      ],);
      
    },
  );
}

}