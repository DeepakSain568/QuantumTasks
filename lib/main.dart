import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolistapp/To_do.dart';
import 'package:todolistapp/Todo_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ChangeNotifierProvider(
          create: (context) => ToDo(),
          builder: (context, child) => To_do(),
        ));
  }
}
