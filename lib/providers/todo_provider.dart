import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_app/models/todo.dart';

final todoProvider = StateNotifierProvider<TodoNotifier, List<Todo>>((ref) {
  return TodoNotifier();
});

class TodoNotifier extends StateNotifier<List<Todo>> {
  TodoNotifier() : super([]);

  void addTodo(String content) {
    final newTodo = Todo(
      id: state.isNotEmpty ? state.last.id + 1 : 1,
      content: content,
      isCompleted: false,
    );
    state = [...state, newTodo];
  }

  void removeTodo(int id) {
    state = state.where((todo) => todo.id != id).toList();
  }

  void toggleTodoCompletion(int id) {
    state = state.map((todo) {
      if (todo.id == id) {
        return Todo(
          id: todo.id,
          content: todo.content,
          isCompleted: !todo.isCompleted,
        );
      }
      return todo;
    }).toList();
  }
}
