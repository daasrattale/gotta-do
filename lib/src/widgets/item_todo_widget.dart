import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/src/model/todo.dart';

class ItemTodoWidget extends StatefulWidget {

  final Todo todo;
  final int index;
  final ValueChanged<Todo> removeTodo;
  final ValueChanged<int> alertTodo;

  const ItemTodoWidget({
    Key? key,
    required this.todo,
    required this.index,
    required this.removeTodo,
    required this.alertTodo
  }):super(key: key);

  @override
  State<ItemTodoWidget> createState() => _ItemTodoWidgetState();
}

class _ItemTodoWidgetState extends State<ItemTodoWidget> {


  String buildTodoTitle(String title, bool isComplete) {
    return '${title.toUpperCase()} (${isComplete ? "Done" : "Pending"})';
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.background,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Slidable(
          key: const ValueKey(0),
          startActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (_) {
                  widget.removeTodo(widget.todo);
                },
                backgroundColor: const Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                borderRadius: BorderRadius.circular(10),
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: ListTile(
              title: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  buildTodoTitle(widget.todo.title.toUpperCase(), widget.todo.isComplete),
                  style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              subtitle: Text(
                widget.todo.description,
                style: TextStyle(color: Colors.white70, decoration: widget.todo.isComplete ? TextDecoration.lineThrough : null, fontWeight: FontWeight.normal),
              ),
              trailing: Checkbox(
                  value: widget.todo.isComplete,
                  activeColor: Theme.of(context).colorScheme.secondary,
                  onChanged: (value) {
                    widget.alertTodo(widget.index);
                  }))),
    );
  }
}
