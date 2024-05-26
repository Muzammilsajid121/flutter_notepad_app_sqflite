import 'package:flutter/material.dart';
import 'package:flutter_notepad_app_sqflite/models/notes.dart';
import 'package:flutter_notepad_app_sqflite/repository/notes_repository.dart';
import 'package:flutter_notepad_app_sqflite/widgets/snackbar.dart';

class AddNewNote extends StatefulWidget {
  final Note? note;
  const AddNewNote({super.key, this.note});

  @override
  State<AddNewNote> createState() => _AddNewNoteState();
}

class _AddNewNoteState extends State<AddNewNote> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note?.title ?? '');
    descriptionController = TextEditingController(text: widget.note?.description ?? '');
  }

  Future<void> saveNote() async {
    final note = Note(
      id: widget.note?.id,
      title: titleController.text,
      description: descriptionController.text,
      createdAt: widget.note?.createdAt ?? DateTime.now(),
    );

    if (widget.note == null) {
      await NotesRepository.insert(note: note);
    } else {
      await NotesRepository.update(note: note);
    }

    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(content: Text('Note saved successfully!')),
    // );
    ScaffoldMessenger.of(context).showSnackBar(customSnackbar('Note Saved Successfully'));


    Navigator.pop(context, true); // Pass true to indicate a note was added or updated
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? "Add New Note" : "Edit Note", style: Theme.of(context).textTheme.titleMedium),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Enter Title',
                labelStyle: Theme.of(context).textTheme.bodyMedium,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),
            
            Expanded(
              child: TextField(
                maxLines: 50,
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Enter Description',
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                alignLabelWithHint: true, // Align label with the top of the TextField

                ),
              ),
            ),
            const SizedBox(height: 6,),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: saveNote,
         style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 253, 183, 178)),
         child: const Text('Save Note'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
