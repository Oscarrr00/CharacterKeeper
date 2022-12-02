import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
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
            backgroundColor: Theme.of(context).colorScheme.secondary,
            title: const Text('Adding a Note'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  TextField(
                      controller: titleNote,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Title of the note",
                      )),
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
                child: Text('Cancel',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primaryContainer)),
                onPressed: () {
                  titleNote.text = "";
                  textNote.text = "";
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Done',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primaryContainer)),
                onPressed: () async {
                  await context
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
            backgroundColor: Theme.of(context).colorScheme.secondary,
            title: const Text('Your Note'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  TextField(
                      controller: titleNote,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Title of the note",
                      )),
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
                          padding: EdgeInsets.only(top: 10),
                          child: Image.network(imagePath),
                        )
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primaryContainer)),
                onPressed: () {
                  titleNote.text = "";
                  textNote.text = "";
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Edit Note',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primaryContainer)),
                onPressed: () {
                  try {
                    context.read<Character_Provide>().updateNote(
                        currentIndex, titleNote.text, textNote.text);
                    titleNote.text = "";
                    textNote.text = "";
                    Navigator.of(context).pop();
                  } catch (e) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(e.toString())));
                    Navigator.of(context).pop();
                  }
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

    Future getImage(int mode) async {
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
            SizedBox(height: 20),
            Expanded(
                child: Container(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            child: Center(
                                child: Text("NOTE TITLE AND DESCRIPTION",
                                    style:
                                        Theme.of(context).textTheme.headline3)))
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
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(
                                width: 2,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer),
                          )),
                    ),
                  ),
                  SizedBox(height: 8),
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
                                (index) => Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Container(
                                        padding: EdgeInsets.all(11),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Row(
                                                            children: [
                                                              notes[index].image !=
                                                                      ""
                                                                  ? Icon(Icons
                                                                      .image)
                                                                  : Text(""),
                                                              Text(
                                                                "${notes[index].title}",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        16),
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ],
                                                          )),
                                                      Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "${notes[index].description}",
                                                          maxLines: 3,
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
                                                    splashRadius: 1,
                                                    onPressed: () async {
                                                      if (notes[index].image ==
                                                          "") {
                                                        Share.share(notes[index]
                                                                .title +
                                                            '\n' +
                                                            notes[index]
                                                                .description);
                                                      } else {
                                                        final response =
                                                            await http.get(
                                                                Uri.parse(notes[
                                                                        index]
                                                                    .image));

                                                        final documentDirectory =
                                                            await getApplicationDocumentsDirectory();

                                                        final file = File(join(
                                                            documentDirectory
                                                                .path,
                                                            'imagetest.png'));

                                                        file.writeAsBytesSync(
                                                            response.bodyBytes);
                                                        XFile fileT = new XFile(
                                                            file.path);

                                                        Share.shareXFiles(
                                                            [fileT],
                                                            text: notes[index]
                                                                    .title +
                                                                '\n' +
                                                                notes[index]
                                                                    .description);
                                                      }
                                                    }),
                                                IconButton(
                                                    icon: Icon(Icons.delete),
                                                    splashRadius: 1,
                                                    onPressed: () async {
                                                      await context
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                      child: Text("Add a note"),
                      onPressed: () {
                        _showDialogAddNote();
                      }),
                ),
                ElevatedButton(
                    child: Icon(Icons.camera_alt),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer,
                    ),
                    onPressed: () async {
                      await getImage(0);
                    }),
                ElevatedButton(
                    child: Icon(Icons.image),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer,
                    ),
                    onPressed: () async {
                      await getImage(1);
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
