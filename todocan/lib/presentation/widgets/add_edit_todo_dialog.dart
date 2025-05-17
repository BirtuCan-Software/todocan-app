import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddEditTodoDialog extends StatefulWidget {
  const AddEditTodoDialog({super.key, this.todo, this.isEditMode = false});

  final String? todo; // TODO: Replace with a Todo model
  final bool isEditMode;

  @override
  State<AddEditTodoDialog> createState() => _AddEditTodoDialogState();
}

class _AddEditTodoDialogState extends State<AddEditTodoDialog> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController(
    text: "Initial",
  );
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  int _canLevel = 0;

  void _handleSubmit() {
    String title = _titleController.text;
    String description = _descriptionController.text;
    int duration = int.parse(_durationController.text);

    print("Operation: ${widget.isEditMode ? "Edit" : "Add"}");
    print("Title: $title");
    print("Description: $description");
    print("Duration: $duration");
    print("Can Level: $_canLevel");

    _titleController.clear();
    _descriptionController.clear();
    _durationController.clear();
    setState(() {
      _canLevel = 0;
    });

    Navigator.of(context).pop(true);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    InputDecoration styledInputDecoration({
      required String labelText,
      String? hintText,
    }) {
      return InputDecoration(
        labelText: labelText,
        hintText: hintText,
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSurfaceVariant.withAlpha(150),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: 1.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: 2.0,
          ),
        ),
        alignLabelWithHint: true,
      );
    }

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      title: Text(
        widget.isEditMode ? "Edit Todo" : "Add Todo",
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _titleController,
                  cursorColor: Theme.of(context).colorScheme.primary,
                  autofocus: true,
                  decoration: styledInputDecoration(
                    labelText: "Title",
                    hintText: "What do you want to do?",
                  ),
                  clipBehavior: Clip.antiAlias,
                  autocorrect: true,
                  enableSuggestions: true,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _durationController,
                  cursorColor: Theme.of(context).colorScheme.primary,
                  decoration: styledInputDecoration(
                    labelText: "Duration (min)",
                    hintText: "How long will it take?",
                  ),
                  clipBehavior: Clip.antiAlias,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a duration';
                    }
                    final int? duration = int.tryParse(value);
                    if (duration == null) {
                      return 'Please enter a valid number';
                    }
                    if (duration <= 0) {
                      return 'Duration must be positive';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _descriptionController,
                  cursorColor: Theme.of(context).colorScheme.primary,
                  decoration: styledInputDecoration(
                    labelText: "Description (Optional)",
                    hintText: "What is it about?",
                  ),
                  maxLines: 3,
                  clipBehavior: Clip.antiAlias,
                  autocorrect: true,
                  enableSuggestions: true,
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                ),
                const SizedBox(height: 10),
                FormField<int>(
                  initialValue: _canLevel,
                  validator: (value) {
                    if (value == null || value == 0) {
                      return 'Please select a can level';
                    }
                    return null;
                  },
                  builder: (FormFieldState<int> field) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Can Level:",
                              style: TextStyle(
                                color:
                                    field.hasError
                                        ? Theme.of(context).colorScheme.error
                                        : Theme.of(
                                          context,
                                        ).colorScheme.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Row(
                              children: List.generate(5, (index) {
                                final int starValue = index + 1;
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 3,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _canLevel = starValue;
                                      });
                                      field.didChange(starValue);
                                    },
                                    child: Icon(
                                      _canLevel >= starValue
                                          ? Icons.diamond
                                          : Icons.diamond_outlined,
                                      color:
                                          _canLevel >= starValue
                                              ? Theme.of(
                                                context,
                                              ).colorScheme.primary
                                              : (field.hasError
                                                  ? Theme.of(
                                                    context,
                                                  ).colorScheme.error
                                                  : Theme.of(
                                                    context,
                                                  ).colorScheme.outline),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                        if (field.hasError)
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              field.errorText!,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                                fontSize:
                                    Theme.of(
                                      context,
                                    ).textTheme.bodySmall?.fontSize ??
                                    12.0,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          style: ButtonStyle(
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            ),
          ),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _handleSubmit();
            }
          },
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
              Theme.of(context).colorScheme.primary,
            ),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            ),
            foregroundColor: WidgetStateProperty.all(
              Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          child: Text(widget.isEditMode ? "Save" : "Add"),
        ),
      ],
    );
  }
}
