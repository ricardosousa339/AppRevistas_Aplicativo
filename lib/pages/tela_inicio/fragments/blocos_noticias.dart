//Grupo de todos os blocos de noticias
import 'package:apprevistas_aplicativo/pages/tela_inicio/model/noticia.dart';
import 'package:flutter/material.dart';

import 'bloco_noticia.dart';

ListView blocosDeNoticias(List<Noticia> noticias, BuildContext context) {
    List<Card> cards = [];

    for (var not in noticias) {
      cards.add(cardBlocoNoticia(not,context));
    }

    return ListView(children: cards);
  }