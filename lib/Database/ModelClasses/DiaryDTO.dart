import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:mintag_application/Database/ModelClasses/DiaryEntryDTO.dart';
import 'package:uuid/uuid.dart';

class DiaryDTO {

  final String diaryId;
  List<DiaryEntryDTO>? entries = [];
  final String diaryName;


  DiaryDTO(this.diaryId,  this.diaryName, {this.entries}){

      // var uuid = Uuid();
      // diaryId = uuid.v1();
      
  }

  

  // void addEntry(DiaryEntryDTO entry){
  //   entries.add(entry);
  // }

  void setEntries(List<DiaryEntryDTO> entries){
    this.entries = entries;
  }

  Map<String, dynamic> toJson(){
    return {
      'diaryId': diaryId,
      'diaryName': diaryName,
      //'entries': jsonEncode(entries)
      'entries': jsonEncode(entries)
    };
  }

  // factory DiaryDTO.fromJson(Map<String, dynamic> json) =>
  //   DiaryDTO(
  //     diaryId: 'diaryId',
  //     diaryName: 'diaryName');



  



}