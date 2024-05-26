import 'package:flutter/material.dart';
import 'package:flutter_notepad_app_sqflite/models/notes.dart';
import 'package:flutter_notepad_app_sqflite/view/add_new_note.dart';
import 'package:intl/intl.dart';

class NoteItem extends StatelessWidget {
  final Note note;

  const NoteItem({super.key, required this.note});

  @override
  Widget build(BuildContext context) {

  final DateFormat formatter = DateFormat('MMM dd, yyyy');
  final String formattedDate = formatter.format(note.createdAt);

    return  Padding(
      padding:  EdgeInsets.all(8.0),

      child:   InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: ((context) => AddNewNote(note: note,))));
        },



        child: ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          leading:   Text(formattedDate,  style: Theme.of(context).textTheme.bodySmall, ) ,
          title:     Text(note.title, style: Theme.of(context).textTheme.bodyLarge,maxLines: 1, overflow: TextOverflow.ellipsis,),
          subtitle:  Text(note.description, style: Theme.of(context).textTheme.bodyMedium,maxLines: 1,overflow: TextOverflow.ellipsis,),
          trailing:  Text(DateFormat.Hm().format(note.createdAt), style: Theme.of(context).textTheme.bodySmall,),
        
          tileColor: Colors.red[50],
          
        ),
      ),
    );
  }
}