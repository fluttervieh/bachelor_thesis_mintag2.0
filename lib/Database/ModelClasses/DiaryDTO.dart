import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:mintag_application/Database/ModelClasses/DiaryEntryDTO.dart';
import 'package:uuid/uuid.dart';

class DiaryDTO {

  String? diaryId;
  List<DiaryEntryDTO> entries = [];
  String? diaryName;

  DiaryDTO(this.diaryName){

      const uuid = Uuid();
      diaryId = uuid.v1();
  }

  

  void addEntry(DiaryEntryDTO entry){
    entries.add(entry);
  }

  Map<String, dynamic> toJson(){
    return {
      'diaryId': diaryId,
      'diaryName': diaryName,
      'entries': jsonEncode(entries)
    };
  }

  



}