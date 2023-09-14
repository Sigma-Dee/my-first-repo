import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:untitled_project/main/entry_point.dart';
import 'package:untitled_project/main/model/data_model.dart';

late Box noteBox;

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  noteBox = await Hive.openBox<Note>('noteBox');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Notes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const EntryPoint(),
    );
  }
}
