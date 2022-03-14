import 'package:firebase_database/firebase_database.dart';

class EntryMsgDTO{

  DatabaseReference? entryMsgId;
  String message;
  double rating;

  EntryMsgDTO(this.message, this.rating);

  void setId(DatabaseReference id){
    entryMsgId = id;
  }

  Map<String, dynamic> toJson(){
    return {
      'message' : message,
      'rating': rating
    };
  }

  String getMessage() => message;
  double getRating() => rating;

}