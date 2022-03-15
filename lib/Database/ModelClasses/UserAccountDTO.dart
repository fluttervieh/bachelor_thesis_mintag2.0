import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:mintag_application/Database/ModelClasses/DiaryDTO.dart';

class UserAccountDTO {

  String? databaseId;
  String userId;
  DiaryDTO diary;

  UserAccountDTO(this.diary, this.userId);

  void setId(DatabaseReference ref){
    databaseId = ref.key;
  }

  Map<String, dynamic> toJson(){
    return {
      'databaseId': databaseId,
      'userId': userId,
      'diary': diary.toJson()
    };
  }
  



}