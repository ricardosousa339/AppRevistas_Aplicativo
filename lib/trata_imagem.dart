  
  /*
  
  import 'dart:async';

import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';

 Future<List<int>> comprimeImagem(List<int> list) async {
    var result = await FlutterImageCompress.compressWithList(
      list,
      minHeight: 1000,
      minWidth: 1000,
      quality: 96,
      rotate: 0,
    );
    print(list.length);
    print(result.length);
    return result;
  }
   Future<File> comprimeImagemComoArquivo(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path, targetPath,
        quality: 88,
        rotate: 0,
        minHeight: 1000,
        minWidth: 1000
      );

    print(file.lengthSync());
    print(result.lengthSync());

    return result;
  }

  
  
  */