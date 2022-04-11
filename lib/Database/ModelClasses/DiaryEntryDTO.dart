import 'dart:collection';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:mintag_application/Database/ModelClasses/EntryMsgDTO.dart';
import 'package:uuid/uuid.dart';

class DiaryEntryDTO{

  String? entryId;
  String date;
  List<EntryMsgDTO> entryMsgs = [];

  DiaryEntryDTO(this.date);

  void setEntryId(String? entryId){
    this.entryId =entryId;
  }

  void setEntryMsgs (List<EntryMsgDTO> entryMsgs){
    this.entryMsgs = entryMsgs;
  }

  Map<String, dynamic> toJson(){
    return {
      //'entryId': entryId,
      'date': date,
      'entryMsgs': entryMsgs
    };
  }

}