
import 'package:bloc/bloc.dart';
import 'package:bloc_counter_app/bloc/posts/posts_event.dart';
import 'package:bloc_counter_app/bloc/posts/posts_state.dart';
import 'package:bloc_counter_app/model/post_model.dart';
import 'package:bloc_counter_app/repository/post_repository.dart';
import 'package:bloc_counter_app/utlis/enums.dart';

class PostBloc extends Bloc<PostEvent, PostState> {

  List<PostModel> tempPostList=[];
  PostRepository postRepository = PostRepository();
  PostBloc() : super(const PostState()) {
    on<PostFetched>(fetchPostApi);
    on<FilterItem>(_filterList);
  }

  void fetchPostApi(PostFetched event, Emitter<PostState> emit) async{
   await postRepository.fetchPost().then((value) {
      emit(state.copyWith(
          postStatus: PostStatus.success,
          massage: 'success',
          postList: value
      ));
    }).onError((error, stackTrace) {
      emit(state.copyWith(
          postStatus: PostStatus.failure,
          massage: error.toString()));
    });
  }

  void _filterList(FilterItem event, Emitter<PostState> emit) {
    if(event.startSearch.isEmpty)
      {
        emit(state.copyWith(tempPostList:[],searchMassage: ""));
      }
    else{
      tempPostList = state.postList.where((element)=>element.email.toString().toLowerCase().contains(event.startSearch)).toList();

      if(tempPostList.isEmpty)
        {
          emit(state.copyWith(tempPostList: tempPostList,searchMassage: "No data found"));
        }
      else{
        emit(state.copyWith(tempPostList: tempPostList,searchMassage: ''));
      }
    }

  }
}




