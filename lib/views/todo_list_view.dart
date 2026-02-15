import 'package:flutter/material.dart';

import '../models/todo.dart';
import 'add_todo_view.dart';
import 'edit_todo_view.dart';

class TodoListView extends StatefulWidget {
  const TodoListView({super.key});

  @override
  State<TodoListView> createState() => _TodoListViewState();
}

class _TodoListViewState extends State<TodoListView> {
  final List<Todo> _todos = [];

  Future<void> _openAddView() async {
    final newTodo = await Navigator.of(context).push<Todo>(
      MaterialPageRoute(builder: (_) => const AddTodoView()),
    );

    if (newTodo == null) {
      return;
    }

    setState(() {
      _todos.add(newTodo);
    });
  }

  Future<void> _openEditView(int index) async {
    final updatedTodo = await Navigator.of(context).push<Todo>(
      MaterialPageRoute(builder: (_) => EditTodoView(todo: _todos[index])),
    );

    if (updatedTodo == null) {
      return;
    }

    setState(() {
      _todos[index] = updatedTodo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TODO一覧')),
      body: _todos.isEmpty
          ? const Center(child: Text('TODOがありません'))
          : ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                final todo = _todos[index];
                return ListTile(
                  title: Text(todo.title),
                  subtitle: Text('締切: ${todo.deadline.year}/${todo.deadline.month}/${todo.deadline.day}'),
                  onTap: () => _openEditView(index),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddView,
        child: const Icon(Icons.add),
      ),
    );
  }
}
