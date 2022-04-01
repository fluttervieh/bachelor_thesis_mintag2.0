import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

class EntryMsgDTO{

  String? entryMsgId;
  String message;
  double rating;
  bool isTextField;

  EntryMsgDTO(this.message, this.rating, this.isTextField);

  void setId(String? id){
    entryMsgId = id;
  }

 

  Map<String, dynamic> toJson(){
    return {
      'message' : message,
      'rating': rating,
      'isTextField': isTextField,
    };
  }

  String getMessage() => message;
  double getRating() => rating;

  void setTextField(bool isTextField)=>this.isTextField = isTextField;
  void setRating(double rating)=> this.rating = rating;


}