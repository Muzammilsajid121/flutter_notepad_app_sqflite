import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_notepad_app_sqflite/models/notes.dart';
import 'package:flutter_notepad_app_sqflite/repository/notes_repository.dart';

class AddNewNote extends StatelessWidget {
  const AddNewNote({super.key});

  @override
  Widget build(BuildContext context) {

    // final title = TextEditingController();
    // final description = TextEditingController();

    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    
    return  Scaffold(
      appBar: AppBar(
        title: Text("ADD NEW NOTE",  style: Theme.of(context).textTheme.bodyLarge,),
        centerTitle: true,
      ),

      //TEXT FIELDS
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            //TITLE CONTROLLER
              TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                       labelText: 'Enter Title', labelStyle: Theme.of(context).textTheme.bodyMedium,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)
                          ),
                          // borderSide: BorderSide(
                          // color: Colors.blue, // Border color
                          // width: 2.0, // Border width
                          // ),
                          
                      // hintText: "Enter Tasbih Name"),
                  ),),
        
        const SizedBox(height: 20,),
        
            //DECRIPTION CONTROLLER
                    Expanded(
                      child: TextField(
                        maxLines: 50,
                          controller: descriptionController,
                            decoration: InputDecoration(
                         labelText: 'Enter Description', labelStyle: Theme.of(context).textTheme.bodyMedium,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)
                            ),
                          ),),
                    ),

             // SUBMIT BUTTON
            ElevatedButton(
              onPressed: () async {
                await insertNote(
                  titleController: titleController,
                  descriptionController: descriptionController,
                  
                );
                print("data inserted");
                // Clear the text fields after inserting the note
                titleController.clear();
                descriptionController.clear();
                // Show a confirmation message or navigate back
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Note added successfully!')),
                );
                // Navigate back to home screen
                Navigator.pop(context, true); // Pass true to indicate a new note was added

              },
              child:const  Text('Add Note'),
            ),
              



          ],
        ),
      ),

    );
  }

    //Insert Note Func

  // Insert Note Func
  Future<void> insertNote({
    required TextEditingController titleController,
    required TextEditingController descriptionController,
  }) async {
    final note = Note(
      title: titleController.text,
      description: descriptionController.text,
      createdAt: DateTime.now(), // Assuming createdAt is a DateTime
    );

    await NotesRepository.insert(note: note);
      print("data is inserted");

  }

  
}