import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled_project/main/constants/colors.dart';
import 'package:untitled_project/main/model/data_model.dart';

import '../model/data/handler.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  bool isFav() {
    if (favoriteList.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  @override
  void initState() {
    super.initState();
    isFav() == false;
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
        title: const Text('Favorites'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: isFav()
                  ? ListView.builder(
                      itemCount: favoriteList.length,
                      itemBuilder: (context, index) {
                        Note favoriteNote = favoriteList[index];
                        return Card(
                          color: getCardColor(index),
                          child: ListTile(
                            title: Text(
                              favoriteNote.noteTitle,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                height: 1.5,
                              ),
                            ),
                            subtitle: Text(
                                '${favoriteNote.noteContent} \n Created: ${favoriteNote.noteCreatedAt}'),
                            trailing: IconButton(
                              onPressed: () {
                                setState(() {
                                  favoriteList.remove(favoriteNote);
                                  favoriteNote.isLiked = !favoriteNote.isLiked;
                                  // Toast Message
                                  Fluttertoast.showToast(
                                    msg: 'Removed from favorites',
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
                                color: getLikeButtonColor(index),
                              ),
                            ),
                            onTap: () {},
                          ),
                        );
                      },
                    )
                  : Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          color: Colors.white,
                          child: const Padding(
                            padding: EdgeInsets.all(20),
                            child: Text('No Favorites Yet'),
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
