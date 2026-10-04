import 'package:bloc_counter_app/model/favourite_item_model.dart';
import 'package:equatable/equatable.dart';


enum ListStatus{loading,success,failure}

class FavouriteState extends Equatable {

  final List<FavouriteItemModel> favouriteItemList;
  final List<FavouriteItemModel> temFavouriteItemList;
  final ListStatus listStatus;
  const FavouriteState({this.favouriteItemList = const [],this.temFavouriteItemList = const [],this.listStatus=ListStatus.loading});

  FavouriteState copyWith({List<FavouriteItemModel>? favouriteItemList,List<FavouriteItemModel>? temFavouriteItemList,ListStatus? listStatus}){
    return FavouriteState(
      favouriteItemList:favouriteItemList??this.favouriteItemList,
      temFavouriteItemList: temFavouriteItemList??this.temFavouriteItemList,
      listStatus: listStatus??this.listStatus
    );
}

  @override
  List<Object?> get props => [favouriteItemList,listStatus,temFavouriteItemList];
}
