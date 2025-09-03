import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_app/main.dart';
import 'package:to_do_app/models/todo.dart';
import 'package:to_do_app/providers/todo_provider.dart';
import 'package:to_do_app/pages/completed.dart';

void main() {
  testWidgets("Default todo list is empty", (WidgetTester tester) async {
    await tester.pumpWidget(ProviderScope(child: const MainApp()));

    // Verify that the todo list is empty
    expect(find.text('Add a todo using the button below'), findsOneWidget);
  });

  testWidgets("Completed todos show in completed page", (
    WidgetTester tester,
  ) async {
    TodoNotifier notifier = TodoNotifier(<Todo>[
      Todo(id: 1, content: 'Test', isCompleted: true),
    ]);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [todoProvider.overrideWith((ref) => notifier)],
        child: MaterialApp(home: CompletedTodoPage()),
      ),
    );
    expect(find.text('Test'), findsOneWidget);
  });

  testWidgets("Slide to delete todo", (WidgetTester tester) async {
    TodoNotifier notifier = TodoNotifier(<Todo>[
      Todo(id: 1, content: 'Test', isCompleted: false),
    ]);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [todoProvider.overrideWith((ref) => notifier)],
        child: MainApp(),
      ),
    );
    await tester.timedDrag(
      find.byKey(ValueKey("1")),
      const Offset(200, 0),
      const Duration(seconds: 2),
    );
    await tester.pumpAndSettle(); // Wait until slide animation finishes
    await tester.tap(find.byKey(ValueKey("1delete")));
    await tester.pump();
    expect(find.text('Add a todo using the button below'), findsOneWidget);
  });
}
