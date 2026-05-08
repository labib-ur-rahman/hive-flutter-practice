import 'package:hive/hive.dart';
import 'package:note_app_hive/models/notes_model.dart';

class Boxes{
  static Box<NotesModel> getData() => Hive.box<NotesModel>('notes');
}
