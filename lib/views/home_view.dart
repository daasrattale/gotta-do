import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/model/todo.dart';
import 'package:todo/src/widgets/add_todo_widget.dart';
import 'package:todo/src/widgets/item_todo_widget.dart';

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
                  return AddTodoWidget(addTodo: addTodo);
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
                          return ItemTodoWidget(
                              todo: state.todos[i],
                              index: i,
                              removeTodo: removeTodo,
                              alertTodo: alertTodo
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
            Icons.person_2_outlined,
            color: Colors.white,
            size: 24.0,
            semanticLabel: 'Text to announce in accessibility modes',
          ),
        ),
      ],
    );
  }

  String buildTodoTitle(String title, bool isComplete) {
    return '${title.toUpperCase()} (${isComplete ? "Done" : "Pending"})';
  }
}
