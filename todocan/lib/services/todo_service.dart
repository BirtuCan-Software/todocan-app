import 'dart:convert';

import 'package:http/http.dart' as http;
import '../core/constants.dart';

class TodoService {
  final String apiUrl = "$apiBaseUrl/todos/";

  Future<List<dynamic>> getAllTodos() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to fetch todos');
      }
    } catch (e) {
      throw Exception('Failed to fetch todos: $e');
    }
  }

  Future<void> addTodo(Map<String, dynamic> todo) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(todo),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to add todo');
      }
    } catch (e) {
      throw Exception('Failed to add todo: $e');
    }
  }

  Future<void> updateTodo(Map<String, dynamic> todo) async {
    try {
      final response = await http.patch(
        Uri.parse('$apiUrl${todo['id']}/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(todo),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update todo');
      }
    } catch (e) {
      throw Exception('Failed to update todo: $e');
    }
  }

  Future<void> deleteTodo(String id) async {
    final response = await http.delete(Uri.parse('$apiUrl$id/'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete todo');
    }
  }
}
