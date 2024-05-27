import 'package:flutter/material.dart';
import 'package:flutter_notepad_app_sqflite/models/notes.dart';
import 'package:flutter_notepad_app_sqflite/repository/notes_repository.dart';
import 'package:flutter_notepad_app_sqflite/view/add_new_note.dart';
import 'package:flutter_notepad_app_sqflite/widgets/note_item.dart';
import 'package:flutter_notepad_app_sqflite/widgets/snackbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Note>> notesFuture;

  @override
  void initState() {
    super.initState();
    notesFuture = NotesRepository().getNotes();
  }

  Future<void> refreshNotes() async {
    setState(() {
      notesFuture = NotesRepository().getNotes();
      // NotesRepository().getNotes();
    });
  }

  Future<void> deleteNote(Note note) async {
    await NotesRepository.deleteNotes(note.id!);
    refreshNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Notes", style: Theme.of(context).textTheme.titleMedium),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Note>>(
        future: notesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(child: Text('No notes available'));
          }
          return Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: ListView(
              children: snapshot.data!.map((note) {
                return Dismissible(
                  key: Key(note.id.toString()),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    deleteNote(note);
                    ScaffoldMessenger.of(context).showSnackBar(customSnackbar('Note Deleted Successfully'));
                  },
                  background: Container(
                    color: const Color.fromARGB(255, 248, 185, 180),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: NoteItem(note: note),
                );
              }).toList(),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddNewNote()),
          );
          if (result == true) {
            refreshNotes();
          }
        },
        foregroundColor: Colors.red,
        backgroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
