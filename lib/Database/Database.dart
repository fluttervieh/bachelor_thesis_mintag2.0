import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'package:mintag_application/Database/ModelClasses/DiaryEntryDTO.dart';
import 'package:mintag_application/Database/ModelClasses/UserAccountDTO.dart';
import 'ModelClasses/DiaryEntry.dart';

final databaseReference = FirebaseDatabase.instance.ref();



DatabaseReference persistUserAccout(UserAccountDTO userAccountDTO){

  var ref = databaseReference.child('accounts/').push();
  //String? key = ref.key;
  userAccountDTO.setId(ref);
  ref.set(userAccountDTO.toJson());
  return ref;
}

DatabaseReference addDiaryEntry(String dataBaseId, DiaryEntryDTO entry){
  var ref = databaseReference.child('accounts/' + dataBaseId + "/diary/entries/").push();
  ref.set(entry.toJson());
  return ref;
}

//this one is just for test purposes
DatabaseReference saveEntry(DiaryEntry entry){
  //print("[------" + databaseReference.path);
  var id = databaseReference.child('entries/').push();
  id.set(entry.toJson());
  return id;
}