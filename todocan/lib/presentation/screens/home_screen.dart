import 'package:flutter/material.dart';

import '../pages/browse_page.dart';
import '../pages/history_page.dart';
import '../widgets/add_edit_todo_dialog.dart';
import '../widgets/app_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [BrowsePage(), HistoryPage()];

  void onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Future<void> _showAddTodoDialog() async {
    bool? isSubmitted = await showDialog(
      context: context,
      builder: (context) {
        return AddEditTodoDialog();
      },
    );
    if (!mounted) return;
    if (isSubmitted != null && isSubmitted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          animation: const AlwaysStoppedAnimation(1),
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white),
              const SizedBox(width: 10),
              Text("Todo added successfully!"),
            ],
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Theme.of(context).colorScheme.primary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          toolbarHeight: 60.0,
          title: const Text(
            "TodoCan",
            style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                // Show bottom modal sheet
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: ListView(
                        padding: EdgeInsets.all(18.0),
                        children: [
                          Text(
                            "Notifications",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "No notifications yet",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              icon: const Icon(Icons.notifications),
            ),
          ],
          foregroundColor: Colors.white,
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        drawer: AppDrawer(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
          child: _pages[_currentIndex],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                  icon: Icon(Icons.history),
                  label: "History",
                ),
              ],
              currentIndex: _currentIndex,
              onTap: onItemTapped,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white60,
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _showAddTodoDialog,
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          label: const Text("Add Todo"),
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }
}
