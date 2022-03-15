import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:mintag_application/Database/ModelClasses/DiaryEntryDTO.dart';
import 'package:uuid/uuid.dart';

class DiaryDTO {

  String? diaryId;
  String? diaryName;

  DiaryDTO(this.diaryName){

      var uuid = Uuid();
      diaryId = uuid.v1();
  }

  

  // void addEntry(DiaryEntryDTO entry){
  //   entries.add(entry);
  // }

  Map<String, dynamic> toJson(){
    return {
      'diaryId': diaryId,
      'diaryName': diaryName,
      //'entries': jsonEncode(entries)
    };
  }

  



}