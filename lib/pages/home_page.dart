import "package:flutter/material.dart";
import "package:flutter_animate/flutter_animate.dart";
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
                content: TextField(
                  controller: _textController,
                ),
                actions: [
                  MaterialButton(
                    onPressed: () {
                      if (_textController.text.isNotEmpty) {
                        //add note to database
                        context
                            .read<NoteDatabase>()
                            .addNote(_textController.text);

                        //clear text field
                        _textController.clear();
                      } else {
                        const ScaffoldMessenger(
                          child: Text('Please enter some text'),
                        );
                      }

                      Navigator.pop(context);
                    },
                    child: const Text("Create"),
                  ),
                ]));
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
      builder: (context) => Animate(
        effects: const [FadeEffect()],
        child: AlertDialog(
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
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
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
