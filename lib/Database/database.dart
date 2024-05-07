import 'dart:developer' as l;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  final db = FirebaseFirestore.instance;

  void addUser(String user) {
    db.collection("Users").add({"user": user}).then((documentSnapshot) =>
        print("Added Data with ID: ${documentSnapshot.id}"));
  }

  Future<bool> checkIfUserRegistered(String user) async {
    final result =
        await db.collection("Users").where("user", isEqualTo: user).get();

    if (result.docs.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<String> linkUsers(String user1, String user2) async {
    List checked = await checkForPair(user1, user2);
    if (!checked[0]) {
      DocumentReference documentSnapshot = await db.collection("Chat").add({
        "pair": [user1, user2],
        "chats": [],
        "primaryColor": Colors.greenAccent.shade700.value.toString(),
        "secondaryColor": Colors.white.value.toString(),
        "primaryColorText": Colors.white.value.toString(),
        "secondaryColorText": Colors.black87.value.toString(),
      });
      return documentSnapshot.id;
    } else {
      return checked[1];
    }

    // checkForPair(user1, user2).then((value)  {
    //   if (!value[0]) {
    //     db.collection("Chat").add({
    //       "pair": [user1, user2],
    //       "chats": []
    //     }).then((documentSnapshot) => documentSnapshot.id);
    //   } else {
    //     return value[1];
    //   }
    //   return null;
    // });
  }

  Future<List> checkForPair(String user1, String user2) async {
    try {
      final result =
          await db.collection("Chat").where("pair", arrayContains: user1).get();

      if (result.docs.isEmpty) {
        return [false];
      } else {
        for (var snapshot in result.docs) {
          if (snapshot.data()['pair'].contains(user2)) {
            return [true, snapshot.id];
          }
        }
        return [false];
      }
    } catch (e) {
      return [false];
    }
  }

  Stream<dynamic> getChats(String docId) {
    return db.collection('Chat').doc(docId).snapshots();
  }

  void addChats(String docId, Map<String, String> newChat) async {
    final result = await db.collection('Chat').doc(docId).get();
    db.collection('Chat').doc(docId).update({
      "chats": [...result.data()!['chats'], newChat]
    });
  }

  void changeColor(String type, String docId, dynamic color) {
    db.collection('Chat').doc(docId).update({type: color});
  }
}
