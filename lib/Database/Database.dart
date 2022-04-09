import 'dart:collection';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mintag_application/Database/ModelClasses/DiaryDTO.dart';
import 'package:mintag_application/Database/ModelClasses/DiaryEntryDTO.dart';
import 'package:mintag_application/Database/ModelClasses/EntryMsgDTO.dart';
import 'package:mintag_application/Database/ModelClasses/QuoteDTO.dart';
import 'package:mintag_application/Database/ModelClasses/UserAccountDTO.dart';
import 'package:flutter/material.dart';

final databaseReference = FirebaseDatabase.instance.ref();
final user = FirebaseAuth.instance.currentUser;
const _storage = FlutterSecureStorage();




//checks if user already has a diary
Future<bool>checkIfUserAlreadyHasAccount()async{

  String uid = user!.uid;
  var ref  = databaseReference.child('accounts/');
  var json = (await ref.once()).snapshot.value as Map<dynamic, dynamic>;

  print("[------]" + json.containsKey(uid).toString());

  return json.containsKey(uid);
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
        bool isTextField;
        String entryDate = "";
        bool isFavorite;

        //fetching and parsing all entryMsgDTOs 
        allEntryMsgs.forEach((msgKey, msgValue) {
          
          if(msgKey != "date"){
            rating = msgValue['rating'];
            message = msgValue['message'];
            isTextField = msgValue['isTextField'];
            isFavorite = msgValue['isFavorite'];
            msgId = msgKey.toString();

            entryMsgDTO = EntryMsgDTO(message, rating.toDouble(), isTextField, isFavorite);
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

//updates an exiisting entryDTO and changes its isFavourite value
void updateEntryMsgDTO(String databaseId, String entryId, String entryMsgId, EntryMsgDTO entryMsgDTO, bool isFavorite){

  //String? entryMsgId = entryMsgDTO.entryMsgId;
  EntryMsgDTO newEntryMsgDTO = EntryMsgDTO(entryMsgDTO.message, entryMsgDTO.rating, entryMsgDTO.isTextField, isFavorite);
  newEntryMsgDTO.setId(entryMsgId); 

  databaseReference.child('accounts/' + databaseId + '/diary/entries/' + entryId + '/' + entryMsgId + '/').update(newEntryMsgDTO.toJson());

}

//returns a random quote
Future<QuoteDTO>getRandomQuote()async{
  var ref = databaseReference.child('quotes/');

  var json = (await ref.once()).snapshot.value as Map<dynamic, dynamic>;
  List<QuoteDTO> allQuotes = [];

  json.forEach((key, value) {
    QuoteDTO quoteDTO = QuoteDTO(value['quote'], value['author']);
    allQuotes.add(quoteDTO);
  });

  final randomIndex = Random();

  return  allQuotes[randomIndex.nextInt(allQuotes.length)];
}


 //for initial use only
void persistQuotes(){
  List<List<String>> allQuotes = [];

  List<String> a = ["'Wenn du ein Problem hast, dann versuche es zu lösen. Kannst du es nicht lösen, dann mache kein Problem daraus.'", "Buddha"];
  List<String> b = ["'Die Zukunft gehört denen, die an die Schönheit ihrer Träume glauben.'", "Eleonore Roosevelt"];
  List<String> c = ["'Die Schönheit der Dinge existiert im Geist, der sie betrachtet.'", "David Hume"];
  List<String> d = ["'Schönheit beginnt in dem Moment, in dem du dich entscheidest, du selbst zu sein.'", "Coco Chanel"];
  List<String> e = ["'Die beste Art, für einen schönen Moment zu bezahlen, ist ihn zu genießen.'", "Richard Bach"];
  List<String> f = ["'Die Tanzenden wurden für verrückt gehalten von denjenigen, die die Musik nicht hören konnten.'", "Unbekannt"];
  List<String> g = ["'Jedes Mal, wenn du jemanden anlächelst, ist dies eine Tat der Liebe, ein Geschenk für diesen Menschen, eine Sache von Schönheit.'", "Mutter Theresa"];
  List<String> h = ["'Kindheit bedeutet Einfachheit. Sieh dir die Welt mit den Augen eines Kindes an – sie ist wunderschön.'", "Kailash Satyarthi"];
  List<String> i = ["'Wann hast du das letzte Mal einfach die Augen geschlossen und einfach nur zugehört?'", "Maxime Lagacé"];
  List<String> j = ["'Äußerliche Schönheit ist ein Geschenk. Innere Schönheit ist eine Errungenschaft.'", "Randi G. Fine"];
  List<String> k = ["'Schönheit liegt nicht im Gesicht, Schönheit ist ein Licht im Herzen.'", "Khalil Gibran"];
  List<String> l = ["'Weisheit ist die Zusammenfassung der Vergangenheit, aber Schönheit ist das Versprechen der Zukunft.'", "Oliver Wendell Holmes"];
  List<String> m = ["'Wie wunderbar ist es doch, dass niemand auch nur einen einzigen Augenblick warten muss, bevor er beginnen kann, die Welt zu verbessern.'", "Anne Frank"];
  List<String> n = ["'Es gibt tausend Krankheiten, aber nur eine Gesundheit.'", "Ludwig Börne"];
  List<String> o = ["'Wer glaubt, keine Zeit für seine Gesundheit zu haben, wird früher oder später Zeit zum Kranksein haben müssen.'", "Chinesisches Sprichwort"];
  List<String> p = ["'Reichtum ist viel. Zufriedenheit ist mehr. Gesundheit ist alles!'", "Asiatisches Sprichwort"];
  List<String> q = ["'Ein gesundes Außen beginnt mit einem gesunden Innen.'", "Robert Urich"];

  allQuotes.add(a);
  allQuotes.add(b);
  allQuotes.add(c);
  allQuotes.add(d);
  allQuotes.add(e);
  allQuotes.add(f);
  allQuotes.add(g);
  allQuotes.add(h);
  allQuotes.add(i);
  allQuotes.add(j);
  allQuotes.add(k);
  allQuotes.add(l);
  allQuotes.add(m);
  allQuotes.add(n);
  allQuotes.add(o);
  allQuotes.add(p);
  allQuotes.add(q);

  allQuotes.forEach((quote) {

    QuoteDTO quoteDTO = QuoteDTO(quote[0], quote[1]);
    var ref = databaseReference.child('quotes/').push();
    quoteDTO.setId(ref.key!);
    ref.set(quoteDTO.toJson());
  });
  

}

