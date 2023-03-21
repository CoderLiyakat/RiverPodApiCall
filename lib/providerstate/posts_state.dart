import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_api_call/models/post_model.dart';
import 'package:riverpod_api_call/services/http_get_service.dart';

final postsProvider = StateNotifierProvider<PostsNotifer, PostState>(
  (ref) => PostsNotifer(),
);

@immutable
abstract class PostState {}

class InitialPostState extends PostState {}

class PostLoadingPostsState extends PostState {}

class PostLoadedPostsState extends PostState {
  PostLoadedPostsState({required this.posts});

  final List<Posts> posts;
}

class ErrorPostsState extends PostState {
  ErrorPostsState({
    required this.message,
  });

  final String message;
}

class PostsNotifer extends StateNotifier<PostState> {
  PostsNotifer() : super(InitialPostState());
  final HttpGetPost _httpGetPost = HttpGetPost();

  fetchPosts() async {
    try {
      state = PostLoadingPostsState();
      _httpGetPost.getPosts();
      List<Posts> posts = await _httpGetPost.getPosts();
      state = PostLoadedPostsState(posts: posts);
    } catch (e) {
      state = ErrorPostsState(message: e.toString());
    }
  }
}
