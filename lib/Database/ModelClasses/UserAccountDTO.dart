import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:mintag_application/Database/ModelClasses/DiaryDTO.dart';

class UserAccountDTO {

  String? databaseId;
  final String userName;
  final DiaryDTO diary;

  UserAccountDTO(
     this.diary,
    this.userName,
    {this.databaseId}
  );

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

  // factory UserAccountDTO.fromJson(Map<String, dynamic> json) => 
  //   UserAccountDTO(
  //     diary: DiaryDTO.fromJson(json['diary']),
  //     userName: json['userName']
  //   );
  



}