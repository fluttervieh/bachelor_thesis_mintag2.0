import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mintag_application/Database/Database.dart';
import 'package:mintag_application/Database/ModelClasses/DiaryDTO.dart';
import 'package:mintag_application/Database/ModelClasses/DiaryEntry.dart';
import 'package:mintag_application/Database/ModelClasses/DiaryEntryDTO.dart';
import 'package:mintag_application/Database/ModelClasses/EntryMsgDTO.dart';
import 'package:mintag_application/Database/ModelClasses/UserAccountDTO.dart';
import 'package:mintag_application/LoginScreen/GoogleSignInProvider.dart';
import 'package:provider/provider.dart';


class OverviewScreen extends StatefulWidget {

    final List<DiaryEntry> entries;


   const OverviewScreen(
    {
      required this.entries,
     Key? key }) 
     : super( key: key);

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {

  
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
            ElevatedButton(onPressed: createUserAccount, child: const Text("test create acc")),
            ElevatedButton(onPressed: addTestEntry, child: const Text("testEntry")),
            ElevatedButton(onPressed: printAllEntries, child: const Text("getAllEntries")),



          ],
        ),
      )
      );
    
  }


//test purpose
  void createUserAccount(){

    final user = FirebaseAuth.instance.currentUser!;

    //String diaryName = "richards diary";
    DiaryDTO diary = DiaryDTO("yeahh");
    UserAccountDTO newAccount = UserAccountDTO(diary, user.uid);
    newAccount.setId(persistUserAccout(newAccount));
  }

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