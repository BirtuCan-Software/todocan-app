import 'package:flutter/material.dart';
import '../../models/todo.dart';
import 'add_edit_todo_dialog.dart';

class TodoListItem extends StatefulWidget {
  const TodoListItem({super.key, required this.todo});

  final Todo todo;

  @override
  State<TodoListItem> createState() => _TodoListItemState();
}

class _TodoListItemState extends State<TodoListItem> {
  Future<void> _showTodoEditDialog() async {
    bool? isSaved = await showDialog(
      context: context,
      builder: (context) {
        return AddEditTodoDialog(todo: "Todo object here", isEditMode: true);
      },
    );
    if (!mounted) return;
    if (isSaved != null && isSaved) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Todo updated successfully!"),
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
    return Dismissible(
      key: Key(widget.todo.id.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: Icon(
          Icons.delete,
          color: Theme.of(context).colorScheme.onPrimary,
          size: 30,
        ),
      ),
      onDismissed: (direction) {
        // Handle the deletion of the todo item
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Todo deleted successfully!"),
            duration: Duration(seconds: 2),
            backgroundColor: Theme.of(context).colorScheme.primary,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border(
            left: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 5,
            ),
          ),
        ),
        child: ListTile(
          onLongPress: _showTodoEditDialog,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  widget.todo.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              InkWell(
                onTap: () {
                  // Add your action here
                },
                child: Icon(
                  Icons.check_box_outline_blank,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
          subtitle: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.todo.description,
                style: TextStyle(
                  fontSize: 10,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                maxLines: 2,
              ),
              Text(
                "Duration: ${widget.todo.durationInMinutes} min",
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Can Level:", style: TextStyle(fontSize: 12)),
                  const SizedBox(width: 5),
                  Row(
                    children: [
                      for (int i = 0; i < widget.todo.canLevel; i++)
                        Icon(
                          Icons.diamond_outlined,
                          size: 12,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          tileColor: Theme.of(context).colorScheme.primaryContainer,
        ),
      ),
    );
  }
}
