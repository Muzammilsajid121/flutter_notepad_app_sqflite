import 'package:flutter/material.dart';
import 'package:flutter_notepad_app_sqflite/models/notes.dart';

class NoteItem extends StatelessWidget {
  final Note note;
  const NoteItem({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.all(8.0),

      child:   ListTile(
        leading:  Text('Dec 02 2023',  style: Theme.of(context).textTheme.bodySmall,) ,
        title:  Text(note.title, style: Theme.of(context).textTheme.bodyLarge,maxLines: 1, overflow: TextOverflow.ellipsis,),
        subtitle:  Text(note.description, style: Theme.of(context).textTheme.bodyMedium,maxLines: 1,overflow: TextOverflow.ellipsis,),
        trailing:  Text('Date time', style: Theme.of(context).textTheme.bodySmall,),
      
        tileColor: Colors.red[50],
        
      ),
    );
  }
}