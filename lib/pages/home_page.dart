import "package:flutter/material.dart";
import "package:notes_app/components/drawer.dart";
import "package:notes_app/components/note_tile.dart";
import "package:notes_app/models/note.dart";
import "package:notes_app/models/note_database.dart";
import "package:provider/provider.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //on app startup, read all notes
    readNote();
  }

  void createNote() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog.adaptive(
          content: Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 0),
            child: TextField(
              showCursor: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.primary,
                disabledBorder: InputBorder.none,
              ),
              controller: _textController,
            ),
          ),
          actions: [
            MaterialButton(
              color: Theme.of(context).colorScheme.primary,
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              onPressed: () {
                if (_textController.text.isNotEmpty) {
                  //add note to database
                  context.read<NoteDatabase>().addNote(_textController.text);

                  //clear text field
                  _textController.clear();
                } else {
                  const ScaffoldMessenger(
                    child: Text('Please enter some text'),
                  );
                }

                Navigator.pop(context);
              },
              child: Text("Create"),
            ),
          ]),
    );
  }

  void readNote() {
    context.read<NoteDatabase>().fetchNotes();
  }

  void updatenote(Note note) {
    _textController.text = note.text;
    showDialog(
      context: context,
      builder: (context) => MaterialButton(onPressed: () {
        if (_textController.text.isNotEmpty) {
          //update note in database
          context.read<NoteDatabase>().updateNote(
                note.id,
                _textController.text,
              );

          //clear text field
          _textController.clear();
        } else {
          const ScaffoldMessenger(
            child: Text('Please enter some text'),
          );
        }
        Navigator.pop(context);
      }),
    );
  }

  void updateNote(Note note) {
    //per-fill the current note text
    _textController.text = note.text;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: const Text('Update Note'),
        content: TextField(
          decoration: const InputDecoration(
            hintText: 'Enter your note',
          ),
          controller: _textController,
        ),
        actions: [
          //update button
          MaterialButton(
            onPressed: () {
              //update note in database
              if (_textController.text.isNotEmpty) {
                //update note in database
                context.read<NoteDatabase>().updateNote(
                      note.id,
                      _textController.text,
                    );

                //clear text field
                _textController.clear();
              } else {
                const ScaffoldMessenger(
                  child: Text('Please enter some text'),
                );
              }

              //close dialog
              Navigator.pop(context);
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void deletenote(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        elevation: 5,
        backgroundColor: Theme.of(context).colorScheme.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: const Text('Delete Note'),
        content: const Text('Are you sure you want to delete this note?'),
        actions: [
          //cancel button
          MaterialButton(
            onPressed: () {
              //close dialog
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          //delete button
          MaterialButton(
            onPressed: () {
              //delete note from database
              context.read<NoteDatabase>().deleteNote(id);

              //close dialog
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final notedatabase = context.watch<NoteDatabase>();

    List<Note> currentNotes = notedatabase.currentNotes;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        title: const Text(
          'Notes',
          style: TextStyle(
              fontFamily: 'Poppins', fontSize: 25, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
        elevation: 5,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: const Icon(Icons.add),
      ),
      drawer: const CustomDrawer(),
      body: ListView.builder(
          itemCount: currentNotes.length,
          itemBuilder: (context, index) {
            final note = currentNotes[index];
            return NoteTile(
              text: note.text,
              onEditPressed: () {
                updateNote(
                  note,
                );
              },
              onDeletePressed: () {
                deletenote(
                  note.id,
                );
              },
            );
          }),
    );
  }
}
