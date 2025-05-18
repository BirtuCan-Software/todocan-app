import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/app_router.dart';

void main() {
  runApp(ProviderScope(child: TodoCan()));
}

class TodoCan extends StatelessWidget {
  const TodoCan({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      title: "TodoCan",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          // seedColor: const Color.fromARGB(255, 243, 128, 33),
          seedColor: const Color.fromARGB(255, 54, 33, 243),
        ),
        brightness: Brightness.light,
        useMaterial3: true,
      ),
    );
  }
}
