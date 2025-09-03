import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_app/pages/add.dart';
import 'package:to_do_app/pages/completed.dart';
import 'package:to_do_app/providers/todo_provider.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List todos = ref.watch(todoProvider);
    List activeTodos = todos.where((todo) => !todo.isCompleted).toList();
    return Scaffold(
      appBar: AppBar(title: Text('Todo App')),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ListView.builder(
          itemCount: activeTodos.length + 1,
          itemBuilder: (context, index) {
            if (index == activeTodos.length) {
              if (activeTodos.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(top: 300),
                  child: Text(
                    'Add a todo using the button below',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10),
                  ),
                );
              } else {
                return Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CompletedTodoPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Completed Todos',
                      style: TextStyle(fontSize: 13, color: Colors.blue),
                    ),
                  ),
                );
              }
            } else {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Slidable(
                  key: ValueKey(activeTodos[index].id.toString()),
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        key: ValueKey("${activeTodos[index].id}delete"),
                        onPressed: (context) {
                          ref
                              .read(todoProvider.notifier)
                              .removeTodo(activeTodos[index].id);
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ],
                  ),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          ref
                              .read(todoProvider.notifier)
                              .toggleTodoCompletion(activeTodos[index].id);
                        },
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        icon: Icons.check,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ],
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(
                        255,
                        227,
                        228,
                        227,
                      ), // background moves too
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text(
                        todos[index].content,
                        style: TextStyle(
                          fontSize: 18,
                          color: const Color.fromARGB(255, 75, 71, 71),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => const AddTodoPage()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
