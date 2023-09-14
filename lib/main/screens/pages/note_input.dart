import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../main.dart';
import '../../model/data_model.dart';

class NoteInput extends StatefulWidget {
  const NoteInput({
    super.key,
    required this.updateCallback,
    this.boolVal,
    required this.initialTitle,
    required this.initialContent,
    this.noteKey,
  });

  final VoidCallback updateCallback;
  final String? boolVal;
  final String initialTitle;
  final String initialContent;
  final String? noteKey;

  @override
  State<NoteInput> createState() => _NoteInputState();
}

class _NoteInputState extends State<NoteInput> {
  // Text Editing Controllers
  var titleController = TextEditingController();
  var contentController = TextEditingController();
  // Edit Mode Trigger
  late bool isEditMode;
  String? bVal;
  // Initialize State
  @override
  void initState() {
    super.initState();
    // String to Boolean value
    bVal = widget.boolVal?.toString();
    if (bVal == 'true') {
      isEditMode = true;
    } else {
      isEditMode = false;
    }
    // Text Editor Controllers
    if (isEditMode == true) {
      titleController.text = widget.initialTitle;
      contentController.text = widget.initialContent;
    } else {
      return;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      appBar: AppBar(
        title: Text(isEditMode ? 'Edit' : 'Create Notes'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                noteBox.put(
                  widget.noteKey ?? 'key_${titleController.text}',
                  Note(
                    noteTitle: titleController.text,
                    noteContent: contentController.text,
                    noteCreatedAt: DateTime.timestamp(),
                    isLiked: false,
                    isDeleted: false,
                  ),
                );
                widget.updateCallback();
                Navigator.pop(context);
              });

              // Toast Message
              Fluttertoast.showToast(
                msg: isEditMode ? 'Changes Saved' : 'Saved',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.black.withOpacity(0.5),
                textColor: Colors.white,
                fontSize: 16.0,
              );
            },
            child: Text(isEditMode ? 'Change' : 'Save'),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Title',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: contentController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Add your Note Here',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
