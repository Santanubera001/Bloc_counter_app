

import 'package:bloc_counter_app/model/post_model.dart';
import 'package:equatable/equatable.dart';

import '../../utlis/enums.dart';

class PostState extends Equatable{

  final PostStatus postStatus;
  final List<PostModel> postList;
  final String massage;
  final List<PostModel> tempPostList;
  final String searchMassage;

  PostState copyWith({PostStatus? postStatus,List<PostModel>? postList,String? massage,List<PostModel>? tempPostList,String? searchMassage}){
    return PostState(
        postList:postList??this.postList ,
      postStatus: postStatus??this.postStatus ,
      massage:massage??this.massage,
      tempPostList:tempPostList?? this.tempPostList , searchMassage:searchMassage??this.searchMassage

    );
  }
  const PostState({this.postStatus=PostStatus.loading,
    this.searchMassage='',
    this.postList=const<PostModel>[],
    this.massage='',
    this.tempPostList=const<PostModel>[]});
  @override
  List<Object?> get props =>[postStatus,postList,massage,tempPostList,searchMassage];

}