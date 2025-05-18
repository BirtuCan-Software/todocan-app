import 'package:flutter/material.dart';

import 'todo_list_item.dart';
import '../../models/todo.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key, required this.todos});

  final List<Todo> todos;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: todos.length,
      separatorBuilder: (context, index) => const SizedBox(height: 5),
      itemBuilder: (context, index) => TodoListItem(todo: todos[index]),
    );
  }
}
