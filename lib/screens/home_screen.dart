import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_app_hive/boxes/boxes.dart';
import 'package:note_app_hive/models/notes_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hive Database Practice')),
      body: ValueListenableBuilder(
        valueListenable: Boxes.getData().listenable(),
        builder: (context, box, _) {
          var data = box.values.toList().cast<NotesModel>();
          return ListView.builder(
            itemCount: box.length,
            reverse: true,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              data[index].title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight(800),
                              ),
                            ),

                            Spacer(),

                            IconButton(
                              onPressed: () {
                                delete(data[index]);
                              },
                              icon: Icon(Icons.delete, color: Colors.redAccent),
                            ),
                            IconButton(
                              onPressed: () {
                                _editNote(data[index]);
                              },
                              icon: Icon(Icons.edit),
                            ),
                          ],
                        ),
                        Text(data[index].description),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showMyDialog,
        child: Text('Add'),
      ),
    );
  }

  /// Show AlertDialog
  Future<void> _showMyDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Note'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Title',
                ),
                controller: titleController,
              ),
              SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Descriptions',
                ),
                maxLines: 8,
                minLines: 2,
                controller: descriptionController,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final note = NotesModel(
                  title: titleController.text,
                  description: descriptionController.text,
                );

                final box = Boxes.getData();
                box.add(note);
                note.save();

                titleController.clear();
                descriptionController.clear();

                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  /// Delete Item
  void delete(NotesModel noteMode) async {
    await noteMode.delete();
  }

  /// Edit Note Dialog
  Future<void> _editNote(NotesModel noteModel) async {
    titleController.text = noteModel.title;
    descriptionController.text = noteModel.description;

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Eidt Note'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Title',
                ),
                controller: titleController,
              ),
              SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Descriptions',
                ),
                maxLines: 8,
                minLines: 2,
                controller: descriptionController,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                noteModel.title = titleController.text.toString();
                noteModel.description = descriptionController.text.toString();

                noteModel.save();

                titleController.clear();
                descriptionController.clear();

                Navigator.pop(context);
              },
              child: Text('Edit'),
            ),
          ],
        );
      },
    );
  }
}
