import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

class EntryMsgDTO{

  String? entryMsgId;
  String message;
  double rating;

  EntryMsgDTO(this.message, this.rating);

  void setId(DatabaseReference id){
    entryMsgId = id.key;
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