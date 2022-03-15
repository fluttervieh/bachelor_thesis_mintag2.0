import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

class EntryMsgDTO{

  String? entryMsgId;
  String message;
  double rating;

  EntryMsgDTO(this.message, this.rating){
    const uuid = Uuid();
    entryMsgId = uuid.v1();
  }

 

  Map<String, dynamic> toJson(){
    return {
      'entryMsgId': entryMsgId,
      'message' : message,
      'rating': rating
    };
  }

  String getMessage() => message;
  double getRating() => rating;

}