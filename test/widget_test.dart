import 'package:codex_sandbox_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows empty todo message initially', (tester) async {
    await tester.pumpWidget(const TodoApp());

    expect(find.text('TODOがありません'), findsOneWidget);
    expect(find.text('TODO一覧'), findsOneWidget);
  });

  testWidgets('shows first detail line under title in todo list', (tester) async {
    await tester.pumpWidget(const TodoApp());
    await _addTodo(tester, title: '買い物', description: '牛乳を買う\nパンも買う');

    expect(find.text('買い物'), findsOneWidget);
    expect(find.text('牛乳を買う'), findsOneWidget);
    expect(find.text('パンも買う'), findsNothing);
  });

  testWidgets('deletes todo from slidable delete action', (tester) async {
    await tester.pumpWidget(const TodoApp());
    await _addTodo(tester, title: '削除対象', description: '詳細');

    await tester.drag(find.text('削除対象'), const Offset(-300, 0));
    await tester.pumpAndSettle();

    await tester.tap(find.text('削除'));
    await tester.pumpAndSettle();

    expect(find.text('削除対象'), findsNothing);
    expect(find.text('TODOがありません'), findsOneWidget);
  });
}

Future<void> _addTodo(
  WidgetTester tester, {
  required String title,
  required String description,
}) async {
  await tester.tap(find.byIcon(Icons.add));
  await tester.pumpAndSettle();

  await tester.enterText(find.widgetWithText(TextFormField, 'タイトル'), title);
  await tester.enterText(find.widgetWithText(TextFormField, '詳細'), description);
  await tester.tap(find.text('追加'));
  await tester.pumpAndSettle();
}
