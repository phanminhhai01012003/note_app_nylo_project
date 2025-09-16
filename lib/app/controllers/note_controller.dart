import 'package:note_app_nylo_project/app/model/note.dart';
import 'package:note_app_nylo_project/app/services/note_services.dart';
import 'package:nylo_framework/nylo_framework.dart';

class NoteController extends NyController {
  final NoteService notesService = NoteService();

  List<Note> getNotes({String query = ""}) => notesService.getNotes(query: query);

  Note createNote(String title, String content) => notesService.createNote(
    title: title,
    content: content
  );

  void updateNote(Note note, {String? title, String? content}) =>
      notesService.updateNote(note, title: title, content: content);

  void deleteNote(Note note) => notesService.deleteNote(note);

  Note? findNote(int key) => notesService.findNote(key);
}
