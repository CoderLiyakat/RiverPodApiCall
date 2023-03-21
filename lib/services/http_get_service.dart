import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:riverpod_api_call/core/constants/api_constants.dart';
import 'package:riverpod_api_call/models/post_model.dart';

class HttpGetPost {
  Future<List<Posts>> getPosts() async {
    List<Posts> posts = [];
    try {
      Uri postsUri = Uri.parse(ApiConstants.BASE_URL + ApiConstants.END_POINT);
      http.Response response = await http.get(postsUri);
      if (response.statusCode == 200) {
        List<dynamic> postsList = jsonDecode(response.body);
        for (var postsListItem in postsList) {
          Posts post = Posts.fromMap(postsListItem);
          posts.add(post);
        }
      }
    } catch (e) {
      log(e.toString());
    }
    return posts;
  }
}
