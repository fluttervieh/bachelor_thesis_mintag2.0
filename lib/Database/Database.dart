import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'package:mintag_application/Database/ModelClasses/UserAccountDTO.dart';
import 'ModelClasses/DiaryEntry.dart';

final databaseReference = FirebaseDatabase.instance.ref();



DatabaseReference persistUserAccout(UserAccountDTO userAccountDTO){

  var id = databaseReference.child('accounts/').push();
  id.set(userAccountDTO.toJson());
  return id;
}

//this one is just for test purposes
DatabaseReference saveEntry(DiaryEntry entry){
  //print("[------" + databaseReference.path);
  var id = databaseReference.child('entries/').push();
  id.set(entry.toJson());
  return id;
}