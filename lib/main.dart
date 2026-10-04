import 'package:bloc_counter_app/bloc/counter_bloc/counter_bloc.dart';
import 'package:bloc_counter_app/bloc/favourite_app_bloc/favourite_bloc.dart';
import 'package:bloc_counter_app/bloc/image_picker_bloc/image_picker_bloc.dart';
import 'package:bloc_counter_app/bloc/posts/posts_bloc.dart';
import 'package:bloc_counter_app/bloc/switch_example_bloc/switch_bloc.dart';
import 'package:bloc_counter_app/bloc/todo_bloc/todo_bloc.dart';
import 'package:bloc_counter_app/repository/favourite_repository.dart';
import 'package:bloc_counter_app/ui/login/login_screen.dart';
import 'package:bloc_counter_app/utlis/image_picker_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CounterBloc()),
        BlocProvider(create: (_) => SwitchBloc()),
        BlocProvider(create: (_) => ImagePickerBloc(ImagePickerUtils())),
        BlocProvider(create: (_)=>ToDoBloc()),
        BlocProvider(create: (_)=>FavouriteBloc(FavouriteRepository())),
        BlocProvider(create: (_)=>PostBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        themeMode: ThemeMode.dark,
        theme: ThemeData(
         brightness: Brightness.dark       ),
        home:LoginScreen(),
      ),
    );
  }
}
