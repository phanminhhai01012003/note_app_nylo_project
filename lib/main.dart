import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:note_app_nylo_project/app/model/note.dart';
import 'package:note_app_nylo_project/resources/pages/note_details.dart';
import 'package:note_app_nylo_project/resources/pages/note_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox<Note>('notesBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nylo Notes App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      initialRoute: "/note_page",
      routes: {
        "/note_page": (context) => NotePage(),
        "/note_details": (context) {
          final key = ModalRoute.of(context)!.settings.arguments as Note?;
          return NoteDetails(note: key);
        },
      },
    );
  }
}