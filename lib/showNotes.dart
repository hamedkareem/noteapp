import 'package:flutter/material.dart';
import 'package:note_app/editNote.dart';
import 'package:note_app/note_data.dart';
import 'package:provider/provider.dart';

class ShowNotes extends StatelessWidget {
  final int noteIndex;
  ShowNotes({Key? key, required this.noteIndex}) : super(key: key);

  TextEditingController titleController = TextEditingController();
  TextEditingController captionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NoteData>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Show note"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditNote(index: noteIndex),
                ),
              );
            },
            icon: const Icon(Icons.edit),
          )
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 10),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.all(5),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                provider.listOfNotes[noteIndex].title,
                style: const TextStyle(fontSize: 20),
              )),
          const SizedBox(height: 10),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              padding: const EdgeInsets.all(5),
              height: MediaQuery.of(context).size.height * 0.7,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                provider.listOfNotes[noteIndex].caption,
                style: const TextStyle(fontSize: 20),
              )),
        ],
      ),
    );
  }
}
