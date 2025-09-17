import 'package:flutter/material.dart';
import 'package:note_app_nylo_project/app/controllers/note_controller.dart';
import 'package:note_app_nylo_project/app/model/note.dart';
import 'package:nylo_framework/nylo_framework.dart';

class NoteDetails extends StatefulWidget {
  final Note? note;
  const NoteDetails({super.key, required this.note});

  @override
  State<NoteDetails> createState() => _NoteDetailsState();
}

class _NoteDetailsState extends State<NoteDetails> {
  late NoteController _controller;
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _controller = NoteController();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
    }
  }

  void _autoSave() {
    if (widget.note != null) {
      _controller.updateNote(
        widget.note!,
        title: _titleController.text,
        content: _contentController.text,
      );
      Navigator.pop(context);
    } else {
      _controller.createNote(
        _titleController.text,
        _contentController.text
      );
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(8),
          child: IconButton(
            onPressed: (){
              if (_titleController.text.isNotEmpty){
                _autoSave();
              } else {
                Navigator.pop(context);
              }
            }, 
            icon: Icon(Icons.arrow_back_ios, size: 30)
          ),
        ),
        title: Text("Note"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.delete,
              size: 30,
              color: Colors.red, 
            ),
            onPressed: () {
              _controller.deleteNote(widget.note!);
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              maxLength: 120,
              decoration: InputDecoration(
                hintText: "Title",
                counterText: "",
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.normal
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.black)
                ),
              ),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: TextField(
                controller: _contentController,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  hintText: "Content",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.normal
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.black)
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}