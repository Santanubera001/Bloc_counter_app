import 'package:bloc_counter_app/bloc/favourite_app_bloc/favourite_event.dart';
import 'package:bloc_counter_app/bloc/favourite_app_bloc/favourite_state.dart';
import 'package:bloc_counter_app/model/favourite_item_model.dart';
import 'package:bloc_counter_app/repository/favourite_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  List<FavouriteItemModel> favouriteList = [];
  List<FavouriteItemModel> temFavouriteList = [];

  FavouriteRepository favouriteRepository;
  FavouriteBloc(this.favouriteRepository) : super(FavouriteState()) {
    on<FetchFavouriteList>(_fetchList);
    on<FavouriteItem>(_addFavouriteItem);
    on<SelectItem>(_selectedItem);
    on<UnSelectItem>(_unSelectedItem);
    on<DeleteItem>(_deleteItem);
  }

  void _fetchList(
    FetchFavouriteList event,
    Emitter<FavouriteState> emit,
  ) async {
    favouriteList = await favouriteRepository.fetchItem();
    emit(
      state.copyWith(
        favouriteItemList: List.from(favouriteList),
        listStatus: ListStatus.success,
      ),
    );
  }

  void _addFavouriteItem(
    FavouriteItem event,
    Emitter<FavouriteState> emit,
  ) async {
    final index = favouriteList.indexWhere(
      (element) => element.id == event.item.id,
    );
    if(event.item.isFavourite){
      if(temFavouriteList.contains(favouriteList[index])){
        temFavouriteList.remove(favouriteList[index]);
        temFavouriteList.add(event.item);
      }
    }
    else{
      if(temFavouriteList.contains(favouriteList[index])){
        temFavouriteList.remove(favouriteList[index]);
        temFavouriteList.add(event.item);
      }
    }
    favouriteList[index] = event.item;
    emit(state.copyWith(favouriteItemList: List.from(favouriteList),temFavouriteItemList: List.from(temFavouriteList)));
  }

  void _selectedItem(SelectItem event, Emitter<FavouriteState> emit) async {
    temFavouriteList.add(event.item);
    emit(state.copyWith(temFavouriteItemList: List.from(temFavouriteList)));
  }

  void _unSelectedItem(UnSelectItem event, Emitter<FavouriteState> emit) async {
    temFavouriteList.remove(event.item);
    emit(state.copyWith(temFavouriteItemList: List.from(temFavouriteList)));
  }

  void _deleteItem(DeleteItem event, Emitter<FavouriteState> emit) async {
    for (int i = 0; i < temFavouriteList.length; i++) {
      favouriteList.remove(temFavouriteList[i]);
    }
    temFavouriteList.clear();
    emit(
      state.copyWith(
        favouriteItemList: List.from(favouriteList),
        temFavouriteItemList: List.from(temFavouriteList),
      ),
    );
  }
}
