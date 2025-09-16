import 'package:hive/hive.dart';
import 'package:note_app_nylo_project/app/model/note.dart';

class NoteService {
  Box<Note> get _notesBox => Hive.box<Note>('notesBox');

  List<Note> getNotes({String query = ""}) {
    final allNotes = _notesBox.values.toList();
    if (query.isEmpty) return allNotes;
    return allNotes.where((n) =>
      n.title.toLowerCase().contains(query.toLowerCase()) ||
      n.content.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }

  Note createNote({
    String title = "",
    String content = ""
  }) {
    final note = Note(
      title: title,
      content: content,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    _notesBox.add(note);
    return note;
  }

  void updateNote(Note note, {String? title, String? content}) {
    note.title = title ?? note.title;
    note.content = content ?? note.content;
    note.updatedAt = DateTime.now();
    note.save();
  }

  void deleteNote(Note note) {
    note.delete();
  }

  Note? findNote(int key) {
    return _notesBox.get(key);
  }
}
