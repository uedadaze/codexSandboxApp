import 'package:flutter/material.dart';

import '../models/todo.dart';
import 'todo_form_view.dart';

class EditTodoView extends StatelessWidget {
  const EditTodoView({required this.todo, super.key});

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TODO編集')),
      body: TodoFormView(initialTodo: todo, buttonLabel: '更新'),
    );
  }
}
