import 'package:bloc_counter_app/bloc/favourite_app_bloc/favourite_bloc.dart';
import 'package:bloc_counter_app/bloc/favourite_app_bloc/favourite_event.dart';
import 'package:bloc_counter_app/bloc/favourite_app_bloc/favourite_state.dart';
import 'package:bloc_counter_app/model/favourite_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteAppScreen extends StatefulWidget {
  const FavouriteAppScreen({super.key});

  @override
  State<FavouriteAppScreen> createState() => _FavouriteAppScreenState();
}

class _FavouriteAppScreenState extends State<FavouriteAppScreen> {
  @override
  void initState() {
    super.initState();

    context.read<FavouriteBloc>().add(FetchFavouriteList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                 centerTitle: true,
                 actions: [
                      BlocBuilder<FavouriteBloc,FavouriteState>(
                        builder: (context,state){
                          return Visibility(
                            visible: state.temFavouriteItemList.isNotEmpty?true:false,
                            child: IconButton(onPressed: (){
                              context.read<FavouriteBloc>().add(DeleteItem());
                            }, icon:Icon(Icons.delete,color: Colors.red)),
                          );
                        },
                      )
                 ],
                 title: Text("Favourite App")
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocBuilder<FavouriteBloc, FavouriteState>(
          builder: (context, state) {
            switch (state.listStatus) {
              case ListStatus.loading:
                return CircularProgressIndicator();
              case ListStatus.success:
                return ListView.builder(
                  itemCount: state.favouriteItemList.length,
                  itemBuilder: (context, index) {
                    final item = state.favouriteItemList[index];
                    return Card(
                      child: ListTile(
                        leading: Checkbox(
                          value: state.temFavouriteItemList.contains(item)
                              ? true
                              : false,
                          onChanged: (value) {
                            if (value!) {
                              context.read<FavouriteBloc>().add(
                                SelectItem(item: item),
                              );
                            } else {
                              context.read<FavouriteBloc>().add(
                                UnSelectItem(item: item),
                              );
                            }
                          },
                        ),
                        title: Text(item.value.toString()),
                        trailing: IconButton(
                          onPressed: () {
                            FavouriteItemModel itemModel = FavouriteItemModel(
                              id: item.id,
                              value: item.value,
                              isFavourite: item.isFavourite ? false : true,
                            );
                            context.read<FavouriteBloc>().add(
                              FavouriteItem(item: itemModel),
                            );
                          },

                          icon: Icon(
                            item.isFavourite
                                ? Icons.favorite
                                : Icons.favorite_border_outlined,
                          ),
                        ),
                      ),
                    );
                  },
                );
              case ListStatus.failure:
                return Text("Something Went wrong");
            }
          },
        ),
      ),
    );
  }
}
