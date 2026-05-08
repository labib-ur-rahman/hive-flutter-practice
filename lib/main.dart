import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app_hive/models/notes_model.dart';
import 'package:note_app_hive/screens/home_screen.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  Hive.registerAdapter(NotesModelAdapter());

  Hive.openBox<NotesModel>('notes');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Hive Practice',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),

      home: HomeScreen(),
    );
  }
}
