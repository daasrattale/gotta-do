import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/src/model/todo.dart';

import '../src/bloc/todo/todo_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  addTodo(Todo todo) {
    context.read<TodoBloc>().add(
          AddTodo(todo),
        );
  }

  removeTodo(Todo todo) {
    context.read<TodoBloc>().add(
          RemoveTodo(todo),
        );
  }

  alertTodo(int index) {
    context.read<TodoBloc>().add(AlterTodo(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  TextEditingController titleController =
                      TextEditingController();
                  TextEditingController descriptionController =
                      TextEditingController();

                  return addTodoDialog(
                      context, titleController, descriptionController);
                });
          },
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: const Icon(
            CupertinoIcons.add,
            color: Colors.black,
          ),
        ),
        appBar: appBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              BlocBuilder<TodoBloc, TodoState>(
                builder: (context, state) {
                  if (state.status == TodoStatus.success) {
                    return ListView.builder(
                        itemCount: state.todos.length,
                        itemBuilder: (context, int i) {
                          return Card(
                            color: Theme.of(context).colorScheme.background,
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Slidable(
                                key: const ValueKey(0),
                                startActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (_) {
                                        removeTodo(state.todos[i]);
                                      },
                                      backgroundColor: const Color(0xFFFE4A49),
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                    title: Padding(
                                      padding: const EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                        buildTodoTitle(state.todos[i].title.toUpperCase(), state.todos[i].isComplete),
                                        style: TextStyle(
                                            color: Theme.of(context).colorScheme.secondary,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    subtitle: Text(
                                      state.todos[i].description,
                                      style: TextStyle(
                                          color: Colors.white70,
                                          decoration: state.todos[i].isComplete? TextDecoration.lineThrough : null,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    trailing: Checkbox(
                                        value: state.todos[i].isComplete,
                                        activeColor: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        onChanged: (value) {
                                          alertTodo(i);
                                        }))),
                          );
                        });
                  } else if (state.status == TodoStatus.initial) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ));
  }

  AlertDialog addTodoDialog(
      BuildContext context,
      TextEditingController titleController,
      TextEditingController descriptionController) {
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
              addTodo(
                Todo(
                    title: titleController.text,
                    description: descriptionController.text),
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

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleSpacing: 0,
      title: const Text(
        'GottaDo',
        style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
      ),
      leading: const Icon(
        CupertinoIcons.chevron_back,
        size: 24.0,
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.settings,
            color: Colors.white,
            size: 24.0,
            semanticLabel: 'Text to announce in accessibility modes',
          ),
        ),
      ],
    );
  }


  String buildTodoTitle(String title, bool isComplete){
    return '${title.toUpperCase()} (${isComplete ? "Done" : "Pending"})';
  }
}


