import 'package:api_integration/models/posts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  Future<List<Post>?> getPosts() async {
    var clt = http.Client();

    var uri = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    var response = await clt.get(uri);

    if (response.statusCode == 200) {
      var json = response.body;

      return postFromJson(json);
    }
  }
}
