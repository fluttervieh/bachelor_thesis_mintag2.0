import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';

class EntryMsgDTO{

  String? entryMsgId;
  String message;
  double rating;
  bool isTextField;
  bool isFavorite;

  EntryMsgDTO(this.message, this.rating, this.isTextField, this.isFavorite);

  void setId(String? id){
    entryMsgId = id;
  }

 

  Map<String, dynamic> toJson(){
    return {
      'message' : message,
      'rating': rating,
      'isTextField': isTextField,
      'isFavorite' : isFavorite,
    };
  }

  String getMessage() => message;
  double getRating() => rating;

  void setTextField(bool isTextField)=>this.isTextField = isTextField;
  void setRating(double rating)=> this.rating = rating;


}