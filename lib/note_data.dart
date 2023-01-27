import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Note {
  String title;
  String caption;

  Note({required this.title, required this.caption});

  Map<String, dynamic> toJson (){
    return {
      'title': title,
      'caption': caption,
    };
  }
}


class NoteData extends ChangeNotifier{

  List<Note> listOfNotes = [];

  void addNote(Note note){
    listOfNotes.add(note);
    notifyListeners();
  }

  void editNote(Note note, int index){
    listOfNotes[index] = note;
    notifyListeners();
  }

  saveData() async {

    SharedPreferences pref = await SharedPreferences.getInstance();

    List<String> tempList = [];

    for(int i = 0; i < listOfNotes.length; i++){
      tempList.add(  jsonEncode(listOfNotes[i])  );
    }

    pref.remove('noteList');
    pref.setStringList('noteList', tempList);

  }

  loadData() async {

    SharedPreferences pref = await SharedPreferences.getInstance();
    print("I'm here");

    if ( pref.getStringList('noteList') != null ){

      List<String> tempList = pref.getStringList('noteList')!;

      for( int i = 0; i < tempList.length; i++ ){

        Map<String, dynamic> temp = jsonDecode(tempList[i]);
        print(temp);

        addNote(
          Note(
            title: temp['title'],
            caption: temp['caption'],
          )
        );

      }

    }

  }

}

