import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_api_call/models/post_model.dart';
import 'package:riverpod_api_call/providerstate/posts_state.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Consumer(builder: (context, ref, child) {
          PostState state = ref.watch(postsProvider);
          if (state is InitialPostState) {
            return Text("Press Floating Action Button to Fetch Data");
          } else
          if (state is PostLoadingPostsState) {
            return CircularProgressIndicator();
          }else
          if (state is ErrorPostsState) {
            return Text(state.message);
          }else
          if (state is PostLoadedPostsState) {
            return _buildListView(state);
          } else{
            return Text('No Data Found');
          }
          
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(postsProvider.notifier).fetchPosts(); 
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildListView(PostLoadedPostsState state) {
    return ListView.builder(
      itemCount: state.posts.length,
      itemBuilder: (context, index) {
        Posts posts = state.posts[index];
        return ListTile(
          leading: CircleAvatar(child: Text(posts.id.toString())),
          title: Text(posts.title),
          subtitle: Text(posts.body),
        );
      },
    );
  }
}
