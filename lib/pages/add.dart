import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_app/providers/todo_provider.dart';

class AddTodoPage extends ConsumerWidget {
  const AddTodoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController todoController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 87, 131, 153),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: todoController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter todo',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 87, 131, 153),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  ref.read(todoProvider.notifier).addTodo(todoController.text);
                  todoController.clear();
                  Navigator.of(context).pop();
                },
                child: Text('Add Todo'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
