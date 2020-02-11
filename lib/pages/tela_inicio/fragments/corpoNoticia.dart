
import 'package:apprevistas_aplicativo/pages/tela_inicio/fragments/textoCorpoNoticia.dart';
import 'package:apprevistas_aplicativo/pages/tela_inicio/fragments/textoTituloNoticia.dart';
import 'package:flutter/material.dart';

ListTile corpoNoticia(widget) {
    return ListTile(
        title: textoTituloNoticia(widget.noticia.titulo),
        subtitle: textoCorpoNoticia(widget.noticia.conteudo));
  }