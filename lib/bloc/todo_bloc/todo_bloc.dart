import 'package:bloc/bloc.dart';
import 'package:bloc_counter_app/bloc/todo_bloc/todo_event.dart';
import 'package:bloc_counter_app/bloc/todo_bloc/todo_state.dart';
class ToDoBloc extends Bloc<ToDoEvent,TodoState>{

  final List<String> todoList=[];

 ToDoBloc():super(TodoState()){
   on<AddToDoEvent>(_addTodoEvent);
   on<RemoveToDoEvent>(_removeTodoEvent);
 }

 void _addTodoEvent(AddToDoEvent event ,Emitter<TodoState> emit){
    todoList.add(event.task);
   emit(state.copyWith(todoList:List.from(todoList)));

 }
  void _removeTodoEvent(RemoveToDoEvent event ,Emitter<TodoState> emit){
    todoList.remove(event.task);
    emit(state.copyWith(todoList:List.from(todoList)));

  }
}