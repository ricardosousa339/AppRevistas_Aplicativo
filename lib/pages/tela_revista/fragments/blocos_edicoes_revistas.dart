
import 'package:apprevistas_aplicativo/pages/tela_edicao/view/tela_edicao.dart';
import 'package:apprevistas_aplicativo/pages/tela_revista/model/edicao.dart';
import 'package:apprevistas_aplicativo/pages/tela_revista/model/revista.dart';
import 'package:flutter/material.dart';

pagina_das_edicoes_da_revista(Revista revista, List<List<Edicao>> edicoes,PageController pgcontroller){
return PageView.builder(
          controller: pgcontroller,
          itemCount: edicoes.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return GridView.count(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              crossAxisCount: 3,
              padding: EdgeInsets.all(0
              ),
              children: List.generate(edicoes[index].length, (posicao) {
                return GestureDetector(
                  child: Card(
                    
                      child: Text(
                    edicoes[index][posicao].nomePortugues,
                  )),
                  onTap: () {
                  }
                );
              }),
            );
          },

        
        );
}