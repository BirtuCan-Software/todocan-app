import '../models/todo.dart';
import '../services/todo_service.dart';

class TodoRepository {
  TodoRepository(this.todoService);

  final TodoService todoService;

  Future<List<Todo>> getAllTodos() async {
    try {
      final List<dynamic> todos = await todoService.getAllTodos();
      return todos.map((todo) => Todo.fromMap(todo)).toList();
    } catch (e) {
      throw Exception('Failed to load todos: $e');
    }
  }

  Future<void> addTodo(Todo todo) async {
    try {
      await todoService.addTodo(todo.toMap());
    } catch (e) {
      throw Exception('Failed to add todo: $e');
    }
  }

  Future<void> updateTodo(Todo todo) async {
    try {
      await todoService.updateTodo(todo.toMap());
    } catch (e) {
      throw Exception('Failed to update todo: $e');
    }
  }

  Future<void> deleteTodo(String id) async {
    try {
      await todoService.deleteTodo(id);
    } catch (e) {
      throw Exception('Failed to delete todo: $e');
    }
  }
}
