import 'package:firebase_database/firebase_database.dart';
import 'package:mintag_application/Database/ModelClasses/DiaryDTO.dart';
import 'package:mintag_application/Database/ModelClasses/DiaryEntryDTO.dart';
import 'package:mintag_application/Database/ModelClasses/UserAccountDTO.dart';
import 'ModelClasses/DiaryEntry.dart';
import 'package:flutter/material.dart';

final databaseReference = FirebaseDatabase.instance.ref();



DatabaseReference persistUserAccout(UserAccountDTO userAccountDTO){

  var ref = databaseReference.child('accounts/').push();
  userAccountDTO.setId(ref);
  ref.set(userAccountDTO.toJson());
  return ref;
}

DatabaseReference addDiaryEntry(String dataBaseId, DiaryEntryDTO entry){
  var ref = databaseReference.child('accounts/' + dataBaseId + "/diary/entries/").push();
  ref.set(entry.toJson());
  return ref;
}

Query getAllEntries(String databaseId){
  
  databaseReference.child('accounts/' + databaseId + "/diary/entries/").onChildAdded.forEach((element) => {
     print(element.snapshot.value.toString())
  });
  return databaseReference;
}

DatabaseReference getDiaryReference(String dataBaseId){
  DatabaseReference diaryRef = databaseReference.child('accounts/' + dataBaseId + '/');
  return diaryRef;
  
}

//this one is just for test purposes
DatabaseReference saveEntry(DiaryEntry entry){
  //print("[------" + databaseReference.path);
  var id = databaseReference.child('entries/').push();
  id.set(entry.toJson());
  return id;
}