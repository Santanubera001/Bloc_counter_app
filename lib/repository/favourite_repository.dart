
import 'dart:core';

import 'package:bloc_counter_app/model/favourite_item_model.dart';

class FavouriteRepository{
  Future<List<FavouriteItemModel>> fetchItem() async{
    await Future.delayed(Duration(seconds: 3));
    return List.of(generateList(10));
  }
  List<FavouriteItemModel>generateList(int length)
  {
    return List.generate(length, (index)=>FavouriteItemModel(id: index.toString(), value:'item $index'));
  }
}