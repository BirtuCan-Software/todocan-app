import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/todo.dart';
import '../repositories/todo_repository.dart';
import '../services/todo_service.dart';

// final todosProvider = FutureProvider((ref) async {
//   final todoRepository = TodoRepository(TodoService());
//   final todos = await todoRepository.getAllTodos();
//   return todos;
// });

class TodoNotifier extends AutoDisposeAsyncNotifier<List<Todo>> {
  @override
  Future<List<Todo>> build() async {
    // fake delay for 2 sec
    // await Future.delayed(const Duration(seconds: 2));
    final todoRepository = TodoRepository(TodoService());
    return await todoRepository.getAllTodos();
  }

  Future<void> addTodo(Todo todo) async {
    final todoRepository = TodoRepository(TodoService());
    await todoRepository.addTodo(todo);
    ref.invalidateSelf();
  }

  Future<void> updateTodo(Todo todo) async {
    final todoRepository = TodoRepository(TodoService());
    await todoRepository.updateTodo(todo);
    ref.invalidateSelf();
  }

  Future<void> deleteTodo(String id) async {
    final todoRepository = TodoRepository(TodoService());
    await todoRepository.deleteTodo(id);
    ref.invalidateSelf();
  }
}

final todosProvider =
    AsyncNotifierProvider.autoDispose<TodoNotifier, List<Todo>>(
      () => TodoNotifier(),
    );
