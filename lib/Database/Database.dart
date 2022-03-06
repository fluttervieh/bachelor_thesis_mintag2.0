import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'ModelClasses/DiaryEntry.dart';

final databaseReference = FirebaseDatabase.instance.ref();


DatabaseReference saveEntry(DiaryEntry entry){
  print("[------" + databaseReference.path);
  var id = databaseReference.child('entries/').push();
  id.set(entry.toJson());
  return id;
}