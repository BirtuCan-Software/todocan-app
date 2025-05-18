import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/todo_repository.dart';
import '../services/todo_service.dart';

final todosProvider = FutureProvider((ref) async {
  final todoRepository = TodoRepository(TodoService());
  final todos = await todoRepository.getAllTodos();
  return todos;
});