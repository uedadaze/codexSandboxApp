import 'package:flutter/material.dart';

import '../models/todo.dart';

class TodoFormView extends StatefulWidget {
  const TodoFormView({
    required this.buttonLabel,
    this.initialTodo,
    super.key,
  });

  final Todo? initialTodo;
  final String buttonLabel;

  @override
  State<TodoFormView> createState() => _TodoFormViewState();
}

class _TodoFormViewState extends State<TodoFormView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late DateTime _deadline;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTodo?.title ?? '');
    _descriptionController = TextEditingController(
      text: widget.initialTodo?.description ?? '',
    );
    _deadline = widget.initialTodo?.deadline ?? DateTime.now();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickDeadline() async {
    final selected = await showDatePicker(
      context: context,
      initialDate: _deadline,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selected != null) {
      setState(() {
        _deadline = selected;
      });
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final base = widget.initialTodo;
    final todo = Todo(
      title: _titleController.text,
      createdAt: base?.createdAt ?? DateTime.now(),
      deadline: _deadline,
      description: _descriptionController.text,
    );

    Navigator.of(context).pop(todo);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'タイトル'),
              validator: (value) =>
                  (value == null || value.trim().isEmpty) ? 'タイトルを入力してください' : null,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '締切: ${_deadline.year}/${_deadline.month}/${_deadline.day}',
                  ),
                ),
                TextButton(
                  onPressed: _pickDeadline,
                  child: const Text('締切を選択'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: '詳細'),
              maxLines: 4,
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: _submit,
              child: Text(widget.buttonLabel),
            ),
          ],
        ),
      ),
    );
  }
}
