import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:obsidian/modelos/note.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase extends ChangeNotifier {
  static late Isar isar;

  // Incializa la base de datos
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [NoteSchema],
      directory: dir.path,
    );
  }

  // list of notes
  final List<Note> currentNotes = [];

  // creacion de la nota en db
  Future<void> addNote(String text) async {
    // crea el objeto nota
    final newNote = Note()..text = text;

    // inserta la nota en la base de datos
    await isar.writeTxn(() => isar.notes.put(newNote));

    fetchNotes();
  }

  // leer notas
  Future<void> fetchNotes() async {
    List<Note> fetchedNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchedNotes);
    notifyListeners();
  }

  // actualizar notas
  Future<void> updateNote(int id, String text) async {
    final existingNote = await isar.notes.get(id);
    if (existingNote != null) {
      existingNote.text = text;
      await isar.writeTxn(() => isar.notes.put(existingNote));
      fetchNotes();
    }
  }

  // borrar notas
  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    fetchNotes();
  }
}
