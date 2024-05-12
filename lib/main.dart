import 'package:flutter/material.dart';
import 'package:obsidian/modelos/note_database.dart';
import 'package:obsidian/pages/notes_page.dart';
import 'package:obsidian/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NoteDatabase.initialize();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => NoteDatabase()),
      ChangeNotifierProvider(create: (context) => ThemeProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const NotesPage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
