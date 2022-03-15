import 'package:firebase_database/firebase_database.dart';
import 'package:mintag_application/Database/ModelClasses/DiaryDTO.dart';

class UserAccountDTO {

  DatabaseReference? databaseId;
  String userId;
  DiaryDTO diary;

  UserAccountDTO(this.diary, this.userId);

  void setId(DatabaseReference id){
    databaseId = id;
  }

  Map<String, dynamic> toJson(){
    return {
      'userId': userId,
      'diary': diary.toJson()
    };
  }
  



}