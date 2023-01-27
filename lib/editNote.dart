import 'package:flutter/material.dart';
import 'package:note_app/note_data.dart';
import 'package:provider/provider.dart';

class EditNote extends StatelessWidget {
  final int index;
  EditNote({Key? key, required this.index}) : super(key: key);

  TextEditingController titleController = TextEditingController();
  TextEditingController captionController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    var provider = Provider.of<NoteData>(context, listen: true);

    titleController.text = provider.listOfNotes[index].title;
    captionController.text = provider.listOfNotes[index].caption;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit note"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            onPressed: () {

              Note newNote = Note(
                  title: titleController.text.isEmpty? "": titleController.text,
                  caption: captionController.text
              );

              provider.editNote(newNote, index);

              Navigator.pop(context);

            },
            icon: const Icon(Icons.check),
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
            child: TextField(
              controller: titleController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Note title",
                prefixIcon: Icon(Icons.title),
              ),
            ),
          ),
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
            child: TextField(
              controller: captionController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Note caption",
                prefixIcon: Icon(Icons.note),
              ),
              maxLines: null,
            ),
          ),
        ],
      ),
    );
  }
}
