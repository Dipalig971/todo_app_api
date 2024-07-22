import 'package:get/get.dart';
import 'package:todo_app_api/todo_app/modal/todo_modal.dart';

class TodoController extends GetxController{
  RxList todoList = <TodoModal>[].obs;

  void dataAdd(String name){
    todoList.add(TodoModal(name: name));
  }

  void dataComplete(int index){
    todoList[index].completed = !todoList[index].completed;
    todoList.refresh();
  }

  void dataUpdate(int index , String text){
    todoList[index].name = text;
    todoList.refresh();
  }

  void dataRemove(int index){
    todoList.removeAt(index);
  }

}