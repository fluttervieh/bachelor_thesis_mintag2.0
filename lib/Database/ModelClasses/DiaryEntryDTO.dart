import 'dart:collection';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:mintag_application/Database/ModelClasses/EntryMsgDTO.dart';
import 'package:uuid/uuid.dart';

class DiaryEntryDTO{

  String? entryId;
  String date;
  //List<EntryMsgDTO> entryMsgs = [];

  DiaryEntryDTO(this.date);

  void setEntryId(DatabaseReference entryId){
    this.entryId =entryId.key;
  }

  Map<String, dynamic> toJson(){
    return {
      //'entryId': entryId,
      'date': date,
    };
  }

}