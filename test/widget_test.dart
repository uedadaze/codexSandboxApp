import 'package:codex_sandbox_app/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows empty todo message initially', (tester) async {
    await tester.pumpWidget(const TodoApp());

    expect(find.text('TODOがありません'), findsOneWidget);
    expect(find.text('TODO一覧'), findsOneWidget);
  });
}
