import 'package:flutter/material.dart';

import 'todo_form_view.dart';

class AddTodoView extends StatelessWidget {
  const AddTodoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TODO追加')),
      body: const TodoFormView(buttonLabel: '追加'),
    );
  }
}
