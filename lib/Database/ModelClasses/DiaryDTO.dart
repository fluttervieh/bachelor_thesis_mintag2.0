import 'package:firebase_database/firebase_database.dart';
import 'package:mintag_application/Database/ModelClasses/DiaryEntryDTO.dart';

class DiaryDTO {

  DatabaseReference? diaryId;
  List<DiaryEntryDTO> entries = [];
  String diaryName;

  DiaryDTO(this.diaryName);

  void setId(DatabaseReference id){
    diaryId = id;
  }

  void addEntry(DiaryEntryDTO entry){
    entries.add(entry);
  }

  Map<String, dynamic> toJson(){
    return {
      'diaryName': diaryName,
      'entries': entries.toList()
    };
  }

  



}