import 'dart:io';

import 'package:character_keeper/providers/character_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class NotePage extends StatelessWidget {
  NotePage({super.key});

  dynamic searchNote = TextEditingController();

  @override
  Widget build(BuildContext context) {
    dynamic titleNote = TextEditingController();
    dynamic textNote = TextEditingController();

    String imageToAddPath = "";
    String imagePath = "";
    int currentIndex = 0;

    List notes = context.watch<Character_Provide>().displayNotes;

    Future<void> _showDialogAddNote() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Adding a Note'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  TextField(
                      style: TextStyle(color: Colors.black),
                      controller: titleNote,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          ),
                          hintText: "Title of the note",
                          hintStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.black),
                          ))),
                  SizedBox(height: 20),
                  Expanded(
                    child: TextField(
                        decoration: InputDecoration(
                          hintText: "Write your note here",
                          contentPadding: EdgeInsets.all(8.0),
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 10,
                        controller: textNote),
                  ),
                  imagePath == ""
                      ? Text("")
                      : Container(
                          child: Image.network(imagePath),
                        )
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  titleNote.text = "";
                  textNote.text = "";
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Done'),
                onPressed: () {
                  context
                      .read<Character_Provide>()
                      .addNote(titleNote.text, textNote.text, imageToAddPath);
                  context.read<Character_Provide>().searchNote(searchNote.text);
                  titleNote.text = "";
                  textNote.text = "";
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    Future<void> _showDialogNote() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Your Note'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  TextField(
                      style: TextStyle(color: Colors.black),
                      controller: titleNote,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.black),
                          ),
                          hintText: "Title of the note",
                          hintStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.black),
                          ))),
                  SizedBox(height: 20),
                  Expanded(
                    child: TextField(
                        decoration: InputDecoration(
                          hintText: "Write your note here",
                          contentPadding: EdgeInsets.all(8.0),
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 10,
                        controller: textNote),
                  ),
                  imagePath == ""
                      ? Text("")
                      : Container(
                          child: Image.network(imagePath),
                        )
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  titleNote.text = "";
                  textNote.text = "";
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Edit Note'),
                onPressed: () {
                  context
                      .read<Character_Provide>()
                      .updateNote(currentIndex, titleNote.text, textNote.text);
                  titleNote.text = "";
                  textNote.text = "";
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    Future<void> _showDialogNoteWithInitialValues(String initialTitle,
        String initialDescription, String initialImage, int index) async {
      titleNote.text = initialTitle;
      textNote.text = initialDescription;
      imagePath = initialImage;
      currentIndex = index;

      await _showDialogNote();

      imagePath = "";
    }

    void getImage(int mode) async {
      final ImagePicker _imagePicker = ImagePicker();
      final XFile? image;

      if (mode == 0)
        image = await _imagePicker.pickImage(source: ImageSource.camera);
      else
        image = await _imagePicker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        imageToAddPath = image.path;
        await _showDialogAddNote();
        imageToAddPath = "";
      }
    }

    return Container(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Center(
                child: Text(
              "Notes",
              style: Theme.of(context).textTheme.headline6,
            )),
            Expanded(
                child: Card(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    color: Theme.of(context).colorScheme.secondary,
                    child: Row(
                      children: [
                        Expanded(
                            child: Center(
                                child: Text("Note Title and Description",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold))))
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      onSubmitted: ((value) {
                        context.read<Character_Provide>().searchNote(value);
                        searchNote.text = value;
                      }),
                      controller: searchNote,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            top: 10.0, bottom: 10.0, right: 10.0, left: 18.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)),
                        hintText: "Search for an Note",
                      ),
                    ),
                  ),
                  (notes.length <= 0)
                      ? Container()
                      : Expanded(
                          child: Padding(
                          padding: EdgeInsets.all(8),
                          child: GridView.count(
                            crossAxisCount: 1,
                            mainAxisSpacing: 4,
                            childAspectRatio: 3.0,
                            children: List.generate(
                                notes.length,
                                (index) => Container(
                                      padding: EdgeInsets.all(4),
                                      color: index % 2 == 1
                                          ? Color.fromARGB(24, 71, 71, 71)
                                          : null,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Row(
                                                          children: [
                                                            notes[index].image !=
                                                                    ""
                                                                ? Icon(
                                                                    Icons.image)
                                                                : Text(""),
                                                            Text(
                                                              "${notes[index].title}",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16),
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ],
                                                        )),
                                                    Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        "${notes[index].description}",
                                                        maxLines: 4,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              onTap: () async {
                                                CircularProgressIndicator();
                                                await _showDialogNoteWithInitialValues(
                                                    notes[index].title,
                                                    notes[index].description,
                                                    notes[index].image,
                                                    index);
                                              },
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              IconButton(
                                                  icon: Icon(Icons.share),
                                                  onPressed: () {
                                                    Share.share(
                                                        notes[index].title +
                                                            '\n' +
                                                            notes[index]
                                                                .description);
                                                  }),
                                              IconButton(
                                                  icon: Icon(Icons.delete),
                                                  splashColor: Colors.red[200],
                                                  onPressed: () {
                                                    context
                                                        .read<
                                                            Character_Provide>()
                                                        .deleteNote(index);
                                                    context
                                                        .read<
                                                            Character_Provide>()
                                                        .searchNote(
                                                            searchNote.text);
                                                  }),
                                            ],
                                          )
                                        ],
                                      ),
                                    )),
                          ),
                        ))
                ],
              ),
            )),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      child: Text("Add a note"),
                      onPressed: () {
                        _showDialogAddNote();
                      }),
                ),
                ElevatedButton(
                    child: Icon(Icons.camera_alt),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                    ),
                    onPressed: () async {
                      getImage(0);
                    }),
                ElevatedButton(
                    child: Icon(Icons.image),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                    ),
                    onPressed: () async {
                      getImage(1);
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
