import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:mintag_application/Database/ModelClasses/EntryMsgDTO.dart';

class DiaryEntryDTO{

  DatabaseReference? entryId;
  String date;
  List<EntryMsgDTO> entryMsgs = [];

  DiaryEntryDTO(this.date, this.entryMsgs);

  void setId(DatabaseReference id){
    entryId = id;
  }

  Map<String, dynamic> toJson(){
    return {
      'date': date,
      'entryMsgs': entryMsgs.toList()
    };
  }

}