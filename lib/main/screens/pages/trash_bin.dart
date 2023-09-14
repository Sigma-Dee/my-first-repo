import 'package:flutter/material.dart';
import 'package:untitled_project/main/model/data/handler.dart';

import '../../../main.dart';
import '../../constants/colors.dart';
import '../../model/data_model.dart';

class TrashBin extends StatefulWidget {
  const TrashBin({
    super.key,
    required this.updateCallback,
  });

  final VoidCallback updateCallback;

  @override
  State<TrashBin> createState() => _TrashBinState();
}

class _TrashBinState extends State<TrashBin> {
  bool isDel() {
    if (deleteList.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  @override
  void initState() {
    super.initState();
    isDel() == false;
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

    getLikeButtonColor(int index) {
      if (index >= 0 && index < likeButtonColors.length) {
        return likeButtonColors[index];
      } else {
        return Colors.yellow.shade200;
      }
    }

    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      appBar: AppBar(
        title: const Text('Trash Bin'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            tooltip: 'Restore',
            icon: const Icon(
              Icons.restore,
              color: Colors.green,
            ),
          ),
          IconButton(
            onPressed: () {},
            tooltip: 'Empty Trash',
            icon: const Icon(
              Icons.recycling,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: isDel()
                  ? ListView.builder(
                      itemCount: deleteList.length,
                      itemBuilder: (context, index) {
                        Note deletedNote = deleteList[index];
                        return Card(
                          color: getCardColor(index),
                          child: ListTile(
                            title: Text(
                              deletedNote.noteTitle,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                height: 1.5,
                              ),
                            ),
                            subtitle: Text(
                              '${deletedNote.noteContent} \n Created: ${deletedNote.noteCreatedAt}',
                            ),
                            trailing: TextButton(
                              onPressed: () {
                                setState(() {
                                  String deletedNoteTitle =
                                      deletedNote.noteTitle;
                                  String deletedNoteContent =
                                      deletedNote.noteContent;
                                  if (deleteList.contains(deletedNote)) {
                                    noteBox.put(
                                      'key_$deletedNoteTitle',
                                      Note(
                                          noteTitle: deletedNoteTitle,
                                          noteContent: deletedNoteContent,
                                          noteCreatedAt: DateTime.timestamp(),
                                          isLiked: false,
                                          isDeleted: false),
                                    );
                                    deleteList.remove(deletedNote);
                                  } else {
                                    return;
                                  }
                                  widget.updateCallback();
                                });
                              },
                              child: Text(
                                'Restore',
                                style: TextStyle(
                                  color: getLikeButtonColor(index),
                                ),
                              ),
                            ),
                            onTap: () {},
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
                            child: Text('Trash Bin Empty'),
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
