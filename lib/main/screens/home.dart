import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled_project/main.dart';
import 'package:untitled_project/main/constants/colors.dart';
import 'package:untitled_project/main/model/data_model.dart';
import 'package:untitled_project/main/screens/pages/trash_bin.dart';

import '../model/data/handler.dart';
import 'pages/note_input.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // check for List Data
  bool isList() {
    if (noteBox.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  void updateList() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    isList() == false;
    //noteBox.clear();
    //noteBox.deleteFromDisk();
    //noteBox.flush();
  }

  @override
  Widget build(BuildContext context) {
    getCardColor(int index) {
      if (index >= 0 && index < cardColors.length) {
        return cardColors[index];
      } else {
        return Colors.blue.shade200;
      }
    }

    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      appBar: AppBar(
        title: const Text('Notes'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TextButton(
              onPressed: () {
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TrashBin(
                        updateCallback: updateList,
                      ),
                    ),
                  );
                });
              },
              child: const Text('Trash Bin'),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: isList()
                  ? ListView.builder(
                      itemCount: noteBox.length,
                      itemBuilder: (context, index) {
                        Note noteData = noteBox.getAt(index);
                        String noteKey = noteBox.keyAt(index);
                        return Dismissible(
                          key: Key(noteKey),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            setState(() {
                              Note deletedNote = noteBox.getAt(index);
                              String deletedNoteTitle = deletedNote.noteTitle;
                              String deletedNoteContent =
                                  deletedNote.noteContent;
                              if (deleteList.contains(deletedNote)) {
                                return;
                              } else {
                                deleteList.add(deletedNote);
                                noteBox.deleteAt(index);
                              }

                              if (favoriteList.contains(deletedNote)) {
                                favoriteList.remove(deletedNote);
                              } else {
                                return;
                              }
                              noteData.isDeleted = !noteData.isDeleted;

                              //deleteList.add(deletedNote);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text('Note Deleted'),
                                  action: SnackBarAction(
                                    label: 'Undo',
                                    onPressed: () {
                                      setState(() {
                                        if (deleteList.contains(deletedNote)) {
                                          noteBox.put(
                                            'key_$deletedNoteTitle',
                                            Note(
                                                noteTitle: deletedNoteTitle,
                                                noteContent: deletedNoteContent,
                                                noteCreatedAt:
                                                    DateTime.timestamp(),
                                                isLiked: false,
                                                isDeleted: false),
                                          );
                                          deleteList.remove(deletedNote);
                                        } else {
                                          return;
                                        }

                                        noteData.isDeleted =
                                            !noteData.isDeleted;
                                      });
                                    },
                                  ),
                                ),
                              );
                            });
                          },
                          background: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.delete,
                                  color: Colors.red.shade400,
                                ),
                                Text(
                                  'Delete',
                                  style: TextStyle(
                                    color: Colors.red.shade400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          child: Card(
                            color: getCardColor(index),
                            child: ListTile(
                              title: Text(
                                noteData.noteTitle,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  height: 1.5,
                                ),
                              ),
                              subtitle: Text(
                                '${noteData.noteContent} \n Created: ${noteData.noteCreatedAt}',
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  setState(() {
                                    Note favoriteNote = noteBox.getAt(index);
                                    if (favoriteList.contains(favoriteNote)) {
                                      favoriteList.remove(favoriteNote);
                                    } else {
                                      favoriteList.add(favoriteNote);
                                    }
                                    noteData.isLiked = !noteData.isLiked;
                                    // Toast Message
                                    Fluttertoast.showToast(
                                      msg: noteData.isLiked
                                          ? 'Added to favorites'
                                          : 'Removed from favorites',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor:
                                          Colors.black.withOpacity(0.5),
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                  });
                                },
                                icon: Icon(
                                  Icons.star,
                                  color: noteData.isLiked
                                      ? Colors.yellow
                                      : Colors.grey.withOpacity(0.5),
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => NoteInput(
                                        updateCallback: updateList,
                                        boolVal: 'true',
                                        initialTitle: noteData.noteTitle,
                                        initialContent: noteData.noteContent,
                                        noteKey: noteKey,
                                      ),
                                    ),
                                  );
                                });
                              },
                            ),
                          ),
                        );
                      })
                  : Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          color: Colors.white,
                          child: const Padding(
                            padding: EdgeInsets.all(20),
                            child: Text('No Notes Present'),
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => NoteInput(
                  updateCallback: updateList,
                  initialTitle: '',
                  initialContent: '',
                  boolVal: 'false',
                ),
              ),
            );
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
