import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:note_app_nylo_project/app/controllers/note_controller.dart';
import 'package:note_app_nylo_project/app/model/note.dart';
import 'package:note_app_nylo_project/resources/widget/note_card.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final NoteController _controller = NoteController();
  String _searchQuery = "";
  bool _isGrid = false;

  @override
  Widget build(BuildContext context) {
    final notesBox = Hive.box<Note>('notesBox');

    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(_isGrid ? Icons.list : Icons.grid_view),
            onPressed: () => setState(() => _isGrid = !_isGrid),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search notes...",
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.w700
                ),
                prefixIcon: Icon(Icons.search, size: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.black)
                ),
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: notesBox.listenable(),
              builder: (context, box, child) {
                final notes = _controller.getNotes(query: _searchQuery);
                if (notes.isEmpty) {
                  return Center(child: Text("No notes yet"));
                }
                return _isGrid
                    ? GridView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, 
                          childAspectRatio: 0.78
                        ),
                        itemCount: notes.length,
                        itemBuilder: (context, i) => NoteCard(note: notes[i], isGrid: true),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: notes.length,
                        itemBuilder: (context, i) => NoteCard(note: notes[i], isGrid: false),
                      );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        shape: CircleBorder(),
        onPressed: () {
          Navigator.pushNamed(context, "/note_details", arguments: null);
        },
        child: Icon(Icons.add, size: 25,),
      ),
    );
  }
}