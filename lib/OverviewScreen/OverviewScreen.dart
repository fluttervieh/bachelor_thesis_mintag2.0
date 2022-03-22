// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mintag_application/Database/Database.dart';
import 'package:mintag_application/Database/ModelClasses/DiaryDTO.dart';
import 'package:mintag_application/Database/ModelClasses/DiaryEntry.dart';
import 'package:mintag_application/Database/ModelClasses/DiaryEntryDTO.dart';
import 'package:mintag_application/Database/ModelClasses/EntryMsgDTO.dart';
import 'package:mintag_application/Database/ModelClasses/UserAccountDTO.dart';
import 'package:mintag_application/LoginScreen/GoogleSignInProvider.dart';
import 'package:provider/provider.dart';


class OverviewScreen extends StatefulWidget {



   const OverviewScreen(
    {Key? key }) 
     : super( key: key);

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {

  final _storage = const FlutterSecureStorage();
  String? _dbId;
  UserAccountDTO? _userAccountDTO;


  @override
  void initState() {
    // TODO: implement initState
    fetchUserAccount();
    super.initState();
  }

  Future<void>fetchUserAccount()async{
     _dbId = await _storage.read(key: "db_id");
    UserAccountDTO u = await fetchUserAccountDTO(_dbId!);
    
     setState(() {
       _userAccountDTO = u;
     });

  }
  
  @override
  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser!;
    final String? userName = user.displayName.toString();

    debugPrint("[---username---]" + userName!);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
             Text("Willkommen, " + userName),
            ElevatedButton(onPressed: (){
               final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
               provider.googleLogout();
             }, child: const Text("logout")),
            const SizedBox(height: 30,),
            //ElevatedButton(onPressed: createUserAccount, child: const Text("test create acc")),
            ElevatedButton(onPressed: addTestEntry, child: const Text("testEntry")),
            ElevatedButton(onPressed: printAllEntries, child: const Text("getAllEntries")),
           // ElevatedButton(onPressed: ()=> getJson(_dbId), child: const Text("getDiary")),




          ],
        ),
      )
      );
    
  }


  Future<UserAccountDTO> fetchUserAccountDTO(String? dataBaseId) async {
    DatabaseReference ref = getDiaryReference(dataBaseId!);
    var json = (await ref.once()).snapshot.value as Map<dynamic, dynamic>;
    var diary = json['diary'];
    var entries = diary['entries'];


    String dbId  = json['databaseId'];
    String userName = json['userName'];
    String diaryId = diary['diaryId'];
    String diaryName = diary['diaryName'];
  
    print("[----diaryID--]" + entries.toString());

    DiaryDTO diaryDTO = DiaryDTO(diaryId, diaryName);
    UserAccountDTO userAccountDTO = UserAccountDTO( diaryDTO, userName, databaseId: dataBaseId,);
    return userAccountDTO;
  //return result;
}

  //  //fetches diary and parses it into model class object
  // Future<UserAccountDTO> fetchAndParseUserAccountDTO(String dataBaseId)async{
  
  //   DatabaseReference ref = getDiaryReference(dataBaseId);

  //   UserAccountDTO userAccountDTO = UserAccountDTO(DiaryDTO("hallo", "hallo"), "Peter amk");
  //   ref.once().then((DatabaseEvent dataSnapshot){
  //   //UserAccountDTO userAccountDTO = UserAccountDTO.fromJson(dataSnapshot.snapshot.value);

  //       String dataBaseId = dataSnapshot.snapshot.child("databaseId").value.toString();
  //       String userName = dataSnapshot.snapshot.child("userName").value.toString();

       

  //       String diaryId = dataSnapshot.snapshot.child("diary/diaryId").value.toString();
  //       String diaryName = dataSnapshot.snapshot.child("diary/diaryName").value.toString();


  //       List<DiaryEntryDTO> entries = [];

  //       dataSnapshot.snapshot.child("diary/entries").children.forEach((e){
  //         String id = e.child("entryId").value.toString();
  //         String date = e.child("date").value.toString();
  //         String msg = e.child("entryMsgs").value.toString();

  //         DiaryEntryDTO diaryEntryDTO = DiaryEntryDTO(date, []);
  //         entries.add(diaryEntryDTO);
  //       });

  //       DiaryDTO diaryDTO = DiaryDTO( diaryId,  diaryName, entries: entries);
  //       userAccountDTO = UserAccountDTO(diaryDTO, userName, databaseId: dataBaseId);
  //       return userAccountDTO;

        

  //   });
  //   return userAccountDTO;
  // }






























// //test purpose
//   void createUserAccount(){

//     final user = FirebaseAuth.instance.currentUser!;
//     //String diaryName = "richards diary";
//     DiaryDTO diary = DiaryDTO("yeahh");
//     UserAccountDTO newAccount = UserAccountDTO(diary: diary, user.uid);
//     newAccount.setId(persistUserAccout(newAccount));
//   }

//test purpose
  void addTestEntry(){

    List<EntryMsgDTO> entryMsgs = [];
    var msg = EntryMsgDTO("Heute gings mir gut", 5);
    entryMsgs.add(msg);

    var entry = DiaryEntryDTO(DateTime.now().toString(), entryMsgs);

    String testId = "-MyDTrYVsdUIbLcdlp_t";

    addDiaryEntry(testId, entry);

  }






















//test purpose
void printDiary(){
  DatabaseReference ref = getDiaryReference("-MyDTrYVsdUIbLcdlp_t");
  ref.once().then((DatabaseEvent dataSnapshot){
    print("data: " + dataSnapshot.snapshot.value.toString());
  });
}

//test purpose
void printAllEntries(){
  getAllEntries("-MyDTrYVsdUIbLcdlp_t");
}
  






  //this one is for test purposes
  void createTestEntry(){

    String date = DateTime.now().toString();
    var newEntry = DiaryEntry(date, "Hello, this is a test entry");
    newEntry.setId(saveEntry(newEntry));

    // setState(() {
    //   widget.entries.add(newEntry);
    // });
  }
}