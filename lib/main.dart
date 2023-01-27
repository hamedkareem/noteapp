import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app/createNote.dart';
import 'package:note_app/note_data.dart';
import 'package:note_app/showNotes.dart';
import 'package:note_app/task7.dart';
import 'package:provider/provider.dart';

main() {
  runApp(ChangeNotifierProvider<NoteData>(
    create: (context) => NoteData(),
    child: MaterialApp(
      home: Task7(),
    ),
  ));
}

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  bool isLoaded = false;

  @override
  Widget build(BuildContext context) {

    var provider = Provider.of<NoteData>(context, listen: true);

    if(!isLoaded){
      provider.loadData();
      isLoaded = true;
    }

    return Scaffold(

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateNote()));
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Note app"), // عبارة عن نص
        centerTitle: true,
        backgroundColor: Colors.green,
      ),

      body: ListView.builder(
        itemCount: provider.listOfNotes.length,
        itemBuilder: (BuildContext context, int index) {
          return Note(
            title: provider.listOfNotes[index].title,
            caption: provider.listOfNotes[index].caption,
            noteIndex: index,
          );
        },
      ),
    );
  }
}

class Note extends StatelessWidget {
  final int noteIndex;
  final String title;
  final String caption;

  const Note(
      {Key? key,
      required this.title,
      required this.caption,
      required this.noteIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.all(0),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowNotes(
              noteIndex: noteIndex,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[200],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const Divider(),
            Text(
              caption,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
