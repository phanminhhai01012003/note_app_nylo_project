// lib/resources/widgets/note_card.dart
import 'package:flutter/material.dart';
import 'package:note_app_nylo_project/app/model/note.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final bool isGrid;
  NoteCard({required this.note, required this.isGrid});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, "/note_details", arguments: note.key),
      child: Card(
        surfaceTintColor: Colors.white,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.all(8),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: isGrid ? 30 : 16, 
                  fontWeight: FontWeight.bold
                )
              ),
              SizedBox(height: 8),
              Text(
                note.content,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: isGrid ? 25 : 14, 
                  fontWeight: FontWeight.w700
                )
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  "${note.updatedAt.toLocal()}".split('.')[0],
                  style: TextStyle(
                    fontSize: isGrid ? 20 : 10, 
                    color: Colors.grey,
                    fontWeight: FontWeight.w400
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
