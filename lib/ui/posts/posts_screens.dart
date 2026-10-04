import 'package:bloc_counter_app/bloc/posts/posts_bloc.dart';
import 'package:bloc_counter_app/bloc/posts/posts_event.dart';
import 'package:bloc_counter_app/bloc/posts/posts_state.dart';
import 'package:bloc_counter_app/utlis/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsScreens extends StatefulWidget {
  const PostsScreens({super.key});

  @override
  State<PostsScreens> createState() => _PostsScreensState();
}

class _PostsScreensState extends State<PostsScreens> {
  @override
  void initState() {
    super.initState();
    context.read<PostBloc>().add(PostFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Posts Screen")),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          switch (state.postStatus) {
            case PostStatus.loading:
              return Center(child: CircularProgressIndicator());
            case PostStatus.success:
              return Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      hintText:"Enter the Email here",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50)
                      )
                    ),
                    onChanged: (filterKey){
                      context.read<PostBloc>().add(FilterItem(filterKey));
                    },
                  ),
                  Expanded(
                    child: state.searchMassage.isNotEmpty?Center(child: Text(state.searchMassage.toString())): ListView.builder(
                      itemCount: state.tempPostList.isEmpty? state.postList.length:state.tempPostList.length,
                      itemBuilder: (context, index) {
                       if(state.tempPostList.isNotEmpty)
                         {
                           final item = state.tempPostList[index];
                           return Card(
                             child: ListTile(
                               title: Text(item.email.toString()),
                               subtitle: Text(item.body.toString()),
                             ),
                           );
                         }
                       else{
                         final item = state.postList[index];
                         return Card(
                           child: ListTile(
                             title: Text(item.email.toString()),
                             subtitle: Text(item.body.toString()),
                           ),
                         );
                       }
                      },
                    ),
                  ),
                ],
              );
            case PostStatus.failure:
              return Center(child: Text(state.massage.toString()));
          }
        },
      ),
    );
  }
}
