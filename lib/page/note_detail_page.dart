import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_companion/db/notes_database.dart';
import 'package:personal_companion/model/note.dart';
import 'package:personal_companion/page/edit_note_page.dart';

class NoteDetailPage extends StatefulWidget {
  const NoteDetailPage({
    Key? key,
    required this.noteId,
  }) : super(key: key);

  final int noteId;

  @override
  _NoteDetailPageState createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  bool isLoading = false;
  late Note note;

  @override
  void initState() {
    super.initState();

    refreshNote();
  }

  Future refreshNote() async {
    setState(() => isLoading = true);

    note = await NotesDatabase.instance.readNote(widget.noteId);

    setState(() => isLoading = false);
  }

  Widget editButton() => IconButton(
      icon: const Icon(Icons.edit_outlined),
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddEditNotePage(note: note),
        ));

        refreshNote();
      });

  Widget deleteButton() => IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () async {
          await NotesDatabase.instance.delete(widget.noteId);

          Navigator.of(context).pop();
        },
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [editButton(), deleteButton()],
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(12),
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  children: [
                    Text(
                      note.title,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          //fontWeight: FontWeight.bold,
                          fontFamily: "GoogleBold"),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      DateFormat.yMMMd().format(note.createdTime),
                      style: const TextStyle(
                          color: Colors.black,
                          fontFamily: "GoogleRegular",
                          fontSize: 15),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      note.description,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: "GoogleRegular"),
                    )
                  ],
                ),
              ),
      );
}
