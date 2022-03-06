import 'package:firebase_database/firebase_database.dart';

class DiaryEntry {
  DatabaseReference? _entryId;
  String _date;
  String _message;

  DiaryEntry(this._date,  this._message);

  void setId(DatabaseReference id){
    _entryId = id;
  }

  Map<String, dynamic> toJson(){
    return {
      'date': _date,
      'message': _message
    };
  }

  String getDate() => _date;
  String getMessage() => _message;


}
