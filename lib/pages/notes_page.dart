import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:obsidian/components/drawer.dart';
import 'package:obsidian/modelos/note.dart';
import 'package:obsidian/modelos/note_database.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final textController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    readNotes();
  }

  void createNote() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(
                controller: textController,
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    context.read<NoteDatabase>().addNote(textController.text);
                    textController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text('Save'),
                )
              ],
            ));
  }

  void readNotes() {
    context.watch<NoteDatabase>().fetchNotes();
  }

  void updateNote(Note note) {
    textController.text = note.text;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Update'),
              content: TextField(
                controller: textController,
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    //update note in db
                    context
                        .read<NoteDatabase>()
                        .updateNote(note.id, textController.text);
                    textController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text('Update'),
                )
              ],
            ));
  }

  void deleteNote(int id) {
    context.read<NoteDatabase>().deleteNote(id);
  }

  @override
  Widget build(BuildContext context) {
    final noteDatabase = context.watch<NoteDatabase>();

    List<Note> currentNotes = noteDatabase.currentNotes;

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNote,
          child: const Icon(Icons.add),
        ),
        drawer: MyDrawer(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabecera
            Padding(
              padding: const EdgeInsets.only(left: 48.0),
              child: Text(
                'To Do List',
                style: GoogleFonts.dmSerifText(
                  fontSize: 40,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),

            // List of notes
            Expanded(
              child: ListView.builder(
                itemCount: currentNotes.length,
                itemBuilder: (context, index) {
                  final note = currentNotes[index];

                  return ListTile(
                    title: Text(note.text),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => updateNote(note),
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () => deleteNote(note.id),
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
