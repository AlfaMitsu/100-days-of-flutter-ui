import 'package:flutter/material.dart';

import 'src/featutres/todo/presentation/views/task_dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor:
            const Color(0xFF2B3E77), // Adjust the background color to match
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
              color: Colors.white), // Set the default text color to white
        ),
      ),
      home: TaskDashboard(),
    );
  }
}
