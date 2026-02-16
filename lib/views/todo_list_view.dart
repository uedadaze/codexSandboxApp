import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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

  void _deleteTodo(int index) {
    setState(() {
      _todos.removeAt(index);
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
                final detailPreview = todo.description.isEmpty ? '' : todo.description.split('\n').first;
                return Slidable(
                  key: ValueKey(todo.createdAt.toIso8601String()),
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (_) => _deleteTodo(index),
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: '削除',
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(todo.title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (detailPreview.isNotEmpty)
                          Text(
                            detailPreview,
                            style: Theme.of(context).textTheme.bodySmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        Text('締切: ${todo.deadline.year}/${todo.deadline.month}/${todo.deadline.day}'),
                      ],
                    ),
                    onTap: () => _openEditView(index),
                  ),
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
