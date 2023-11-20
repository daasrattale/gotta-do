import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo/src/bloc/simple_bloc_observer.dart';
import 'package:todo/src/bloc/todo/todo_bloc.dart';
import 'package:todo/views/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  Bloc.observer = SimpleBlocObserver();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Todo App',
      theme: ThemeData(
        useMaterial3: false,
        colorScheme: const ColorScheme.light(
            background: Colors.white12,
            onBackground: Colors.white,
            primary: Color(0xff4169e1),
            onPrimary: Colors.white,
            secondary: Colors.blueAccent,
            onSecondary: Colors.white
        ),
      ),
      home: BlocProvider<TodoBloc>(
        create: (context) => TodoBloc()..add(
            TodoStarted()
        ),
        child: const HomeView(),
      ),
    );
  }
}