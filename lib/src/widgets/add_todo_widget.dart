import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/src/model/todo.dart';

class AddTodoWidget extends StatefulWidget {

  final ValueChanged<Todo> addTodo;

  const AddTodoWidget({
    Key? key,
    required this.addTodo,
  }):super(key: key);

  @override
  State<AddTodoWidget> createState() => _AddTodoWidgetState();
}

class _AddTodoWidgetState extends State<AddTodoWidget> {

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add a new Task'),
      actionsPadding: const EdgeInsets.all(20.0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextField(
              controller: titleController,
              autocorrect: true,
              cursorColor: Theme.of(context).colorScheme.secondary,
              decoration: const InputDecoration(
                hintText: 'Task Title',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.grey),
                ),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextField(
              maxLines: null,
              keyboardType: TextInputType.multiline,
              autocorrect: true,
              controller: descriptionController,
              cursorColor: Theme.of(context).colorScheme.secondary,
              decoration: const InputDecoration(
                hintText: 'Task Description',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.grey),
                ),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              widget.addTodo(
                Todo(title: titleController.text, description: descriptionController.text),
              );
              titleController.text = '';
              descriptionController.text = '';
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Theme.of(context).colorScheme.secondary,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              foregroundColor: Theme.of(context).colorScheme.secondary,
            ),
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.plus,
                      size: 16,
                    ),
                    Text("New task")
                  ],
                )))
      ],
    );
  }
}
