import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_app/providers/todo_provider.dart';

void main() {
  late ProviderContainer container;
  late TodoNotifier notifier;

  setUp(() {
    container = ProviderContainer();
    notifier = container.read(todoProvider.notifier);
  });

  tearDown(() {
    container.dispose();
  });

  test('todo list starts empty', () {
    expect(notifier.debugState, []);
  });

  test('add todo', () {
    notifier.addTodo('New Todo');
    expect(notifier.debugState[0].content, 'New Todo');
  });

  test('remove todo', () {
    notifier.addTodo('New Todo');
    expect(notifier.debugState[0].content, 'New Todo');
    notifier.removeTodo(1);
    expect(notifier.debugState, []);
  });

  test('toggle todo completion', () {
    notifier.addTodo('New Todo');
    expect(notifier.debugState[0].isCompleted, false);
    notifier.toggleTodoCompletion(1);
    expect(notifier.debugState[0].isCompleted, true);
  });
}
