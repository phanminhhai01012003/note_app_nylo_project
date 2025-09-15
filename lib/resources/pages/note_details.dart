import 'package:flutter/material.dart';
import 'package:note_app_nylo_project/app/controllers/note_controller.dart';
import 'package:note_app_nylo_project/app/model/note.dart';
import 'package:nylo_framework/nylo_framework.dart';

class NoteDetails extends StatefulWidget {
  final int? noteKey;
  const NoteDetails({super.key, required this.noteKey});

  @override
  State<NoteDetails> createState() => _NoteDetailsState();
}

class _NoteDetailsState extends State<NoteDetails> {
  late NoteController _controller;
  Note? _note;
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _controller = NoteController();
    if (widget.noteKey != null) {
      _note = _controller.findNote(widget.noteKey!);
      if (_note != null) {
        _titleController.text = _note!.title;
        _contentController.text = _note!.content;
      }
    } else {
      _note = _controller.createNote();
    }
  }

  void _autoSave() {
    if (_note != null) {
      _controller.updateNote(
        _note!,
        title: _titleController.text.trim(),
        content: _contentController.text,
      );
    }
  }

  @override
  void dispose() {
    _autoSave();
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Note"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.delete,
              size: 30,
              color: Colors.red, 
            ),
            onPressed: () {
              _controller.deleteNote(_note!);
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            NyTextField(
              controller: _titleController,
              maxLength: 120,
              decoration: InputDecoration(
                hintText: "Title",
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
            Expanded(
              child: NyTextField(
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