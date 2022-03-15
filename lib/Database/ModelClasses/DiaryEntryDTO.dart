import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:mintag_application/Database/ModelClasses/EntryMsgDTO.dart';
import 'package:uuid/uuid.dart';

class DiaryEntryDTO{

  String? entryId;
  String date;
  List<EntryMsgDTO> entryMsgs = [];

  DiaryEntryDTO(this.date, this.entryMsgs){
    const uuid = Uuid();
    entryId = uuid.v1();
  }

  
  Map<String, dynamic> toJson(){
    return {
      'entryId': entryId,
      'date': date,
      'entryMsgs': entryMsgs.toList()
    };
  }

}