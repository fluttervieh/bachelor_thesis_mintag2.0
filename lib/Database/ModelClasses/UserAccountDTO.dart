import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:mintag_application/Database/ModelClasses/DiaryDTO.dart';

class UserAccountDTO {

  String? databaseId;
  String userName;
  DiaryDTO diary;

  UserAccountDTO(this.diary, this.userName);

  void setId(DatabaseReference ref){
    databaseId = ref.key;
  }

  Map<String, dynamic> toJson(){
    return {
      'databaseId': databaseId,
      'userName': userName,
      'diary': diary.toJson()
    };
  }
  



}