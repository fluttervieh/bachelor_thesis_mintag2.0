import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:mintag_application/Database/ModelClasses/DiaryDTO.dart';
import 'package:mintag_application/Database/ModelClasses/DiaryEntryDTO.dart';
import 'package:mintag_application/Database/ModelClasses/EntryMsgDTO.dart';
import 'package:mintag_application/Database/ModelClasses/UserAccountDTO.dart';
import 'ModelClasses/DiaryEntry.dart';
import 'package:flutter/material.dart';

final databaseReference = FirebaseDatabase.instance.ref();
final user = FirebaseAuth.instance.currentUser;



//checks if user already has a diary
Future<bool>checkIfUserAlreadyHasAccount()async{
  //var ref2 = databaseReference.set('accounts');
  var ref  = databaseReference.child('accounts/');
  var json = (await ref.once()).snapshot.value as Map<dynamic, dynamic>;

  return json.containsKey(user!.uid);
}

//persists a given useraccountdto for a new user. 
Future<void> persistUserAccout(UserAccountDTO userAccountDTO)async{

  var ref = databaseReference.child('accounts/' + user!.uid + '/');
  userAccountDTO.setId(user!.uid);
  ref.set(userAccountDTO.toJson());
}

//persists a given diaryentrydto to a given diary. 
DatabaseReference addDiaryEntry(String dataBaseId, DiaryEntryDTO entry){
  var ref = databaseReference.child('accounts/' + dataBaseId + "/diary/entries/").push();
  ref.set(entry.toJson());
  return ref;
}


//Database reference for the UserAccountDTO
DatabaseReference getDiaryReference(String dataBaseId){
  DatabaseReference diaryRef = databaseReference.child('accounts/' + dataBaseId + '/');
  return diaryRef; 
}

//fetches user account and transforms it into a UseraccountDTO
Future<UserAccountDTO> fetchUserAccountDTO(String? dataBaseId) async {

    //references
    DatabaseReference ref = getDiaryReference(dataBaseId!);
    var json = (await ref.once()).snapshot.value as Map<dynamic, dynamic>;
    var diary = json['diary'];

    List<DiaryEntryDTO> entryDTOs = [];
    List<EntryMsgDTO> entryMsgDTOs;


    //if there are some entry dtos, they gon be fetched
    if(diary['entries'] != "null"){

        var entries = diary['entries'] as Map<dynamic, dynamic>;

        entries.forEach((entryKey, entryValue) {
     
        DiaryEntryDTO diaryEntryDTO;
        var allEntryMsgs = entryValue as Map<dynamic, dynamic>;
        entryMsgDTOs = [];
        EntryMsgDTO entryMsgDTO;
        String msgId;
        String message;
        int rating;
        String entryDate = "";

        //fetching and parsing all entryMsgDTOs 
        allEntryMsgs.forEach((msgKey, msgValue) {
          
          if(msgKey != "date"){
            rating = msgValue['rating'];
            message = msgValue['message'];
            msgId = msgKey.toString();

            entryMsgDTO = EntryMsgDTO(message, rating.toDouble());
            entryMsgDTO.setId(msgId);
            entryMsgDTOs.add(entryMsgDTO);

          }else{
            entryDate = msgValue;
          }
   
      });

      diaryEntryDTO = DiaryEntryDTO(entryDate);
      diaryEntryDTO.setEntryId(entryKey);
      diaryEntryDTO.setEntryMsgs(entryMsgDTOs);
      entryDTOs.add(diaryEntryDTO);

    });
    }

    
   
    

    //credentials for the account/diary dto
    String dbId  = json['databaseId'];
    String userName = json['userName'];
    String diaryId = diary['diaryId'];
    String diaryName = diary['diaryName'];
  
    //creating diarydto/ useraccountdto object
    DiaryDTO diaryDTO = DiaryDTO(diaryId, diaryName);
    diaryDTO.setEntries(entryDTOs);
    UserAccountDTO userAccountDTO = UserAccountDTO( diaryDTO, userName, databaseId: dataBaseId,);
    return userAccountDTO;
}


//created DB ref for a new entry and returns an ID, so that single entry msgs can be pushed
void persistEntryDTO(String databaseId, DiaryEntryDTO diaryEntryDTO){
  var ref = databaseReference.child('accounts/' + databaseId + '/diary/entries/').push();
  diaryEntryDTO.setEntryId(ref.key);
  ref.set(diaryEntryDTO.toJson());
}

//persists a entryMsgDTO under a given EntryDTO
void persistEntryMsgDTO(String databaseId, String entryId, EntryMsgDTO entryMsgDTO){
  var ref = databaseReference.child('accounts/' + databaseId + '/diary/entries/' + entryId + '/').push();
  entryMsgDTO.setId(ref.key);
  ref.set(entryMsgDTO.toJson());
}



//this one is just for test purposes
DatabaseReference saveEntry(DiaryEntry entry){
  //print("[------" + databaseReference.path);
  var id = databaseReference.child('entries/').push();
  id.set(entry.toJson());
  return id;
}