import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_api/todo_app/controller/todo_controller.dart';

class HomeScreen extends StatelessWidget {
  final TodoController todoController = Get.put(TodoController());
  final TextEditingController taskController = TextEditingController();

  HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0D0714),
      appBar: AppBar(
        backgroundColor: const Color(0xff0D0714),
        title: const Text('Todo List', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskController,
                    decoration: InputDecoration(
                      hintText: 'Add a new task',
                      hintStyle: const TextStyle(color: Colors.white),
                      // filled: true,
                      fillColor: Colors.white24,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(
                          color: Color(0xff4F3C67), // Set your border color here
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(
                          color: Color(0xff4F3C67), // Set your border color here
                          width: 2.0,
                        ),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    if (taskController.text.isNotEmpty) {
                      todoController.dataAdd(taskController.text);
                      taskController.clear();
                    }
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xff4F3C67),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            Obx(() => Text(
              'Tasks to do - ${todoController.todoList.length}',
              style: const TextStyle(color: Colors.white, fontSize: 18),
            )),
            Expanded(
              child: Obx(() => ListView.builder(
                itemCount: todoController.todoList.length,
                itemBuilder: (context, index) {
                  final todo = todoController.todoList[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xff15101C), // Background color of ListTile
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text(
                        todo.name,
                        style: TextStyle(
                          color: Colors.white,
                          decoration: todo.completed
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      trailing: Wrap(
                        spacing: 12,
                        children: [
                          IconButton(
                            icon: Icon(
                              todo.completed
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              todoController.dataComplete(index);
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              todoController.dataRemove(index);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )),
            ),
          ],
        ),
      ),
    );
  }
}
