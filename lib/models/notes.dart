import 'package:flutter_notepad_app_sqflite/repository/notes_repository.dart';

class Note{

  int? id;
  String title;
  String description;
  DateTime createdAt;

  Note({
    this.id, //we dont need to pass id when a new note is created
    required this.title,
    required this.description,
    required this.createdAt,
  });

   // Convert a Note into a Map. The keys must correspond to the names of the columns in the database.
   Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'title' : title,
      'description': description,
      'createdAt' : createdAt.toIso8601String(), // Use toIso8601String for DateTime,
    };
   }

   // Convert a Map into a Note.
   static Note fromMap (Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'], 
      description: map['description'], 
      createdAt: DateTime.parse(map['createdAt']) );
      
      
    
   }


  


}