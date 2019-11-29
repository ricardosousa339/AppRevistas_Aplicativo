 Future<dynamic> postaComentario(String conteudo, ) async {
    /* try {
      Options options = Options(
       contentType: 'application/json'
      );

      Response response = await dio.post('/api/usuarios/',
          data: {"email:": email,"username": email, "password": password, "first_name":nome, "last_name":sobrenome}, options: options);
///

    Usuario user = Usuario(
        email: email,
        primeiroNome: nome,
        segundoNome: sobrenome,
        password: password);

    return http.post(raizApi + '/api/usuarios/',
        body: json.encode(user.toJson(user)),
        headers: {
          "Content-Type": "application/json"
        }).then((http.Response response) {
      print(response.body);
    });

    final response = await http.post(raizApi + '/api/usuarios/',
        body: json.encode({
          'username': email,
          'email': email,
          'password': password,
          'first_name': nome,
          'second_name': sobrenome
          //headers: {HttpHeaders.authorizationHeader: "Token ${widget.key}"},
        }));

    if (response.statusCode == 200 || response.statusCode == 201) {
      var responseJson = json.decode(response.body);
      return responseJson;
    } else if (response.statusCode == 401) {
      throw Exception("Incorrect Email/Password");
    } else {
      print(response.statusCode);

      throw Exception('Authentication Error');
    }
    */ 
  }