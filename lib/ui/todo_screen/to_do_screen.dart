import 'package:bloc_counter_app/bloc/todo_bloc/todo_bloc.dart';
import 'package:bloc_counter_app/bloc/todo_bloc/todo_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/todo_bloc/todo_state.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo App"),
      ),
      body: BlocBuilder<ToDoBloc,TodoState>(
        builder: (context, state) {
          if(state.todoList.isEmpty){
            return Center(child: Text("No ToDo Screen"),);
          }
          else if(state.todoList.isNotEmpty)
            {
              return ListView.builder(
                  itemCount:state.todoList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(state.todoList[index],),
                      trailing: IconButton(onPressed: () {
                        context.read<ToDoBloc>().add(RemoveToDoEvent(task:state.todoList[index]));
                      }, icon: Icon(Icons.delete)),
                    );
                  });
            }
          else{
            return SizedBox();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
         for( int i=0;i<5;i++)
           {
             context.read<ToDoBloc>().add(AddToDoEvent(task: 'SantanuBera : '+i.toString()));
           }
        }, child: Icon(Icons.add),
      ),
    );
  }
}
