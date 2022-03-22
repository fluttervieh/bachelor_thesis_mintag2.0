// //test purpose
//   void addTestEntry(){

//     List<EntryMsgDTO> entryMsgs = [];
//     var msg = EntryMsgDTO("Heute gings mir gut", 5);
//     entryMsgs.add(msg);

//     var entry = DiaryEntryDTO(DateTime.now().toString(), entryMsgs);

//     String testId = "-MyDTrYVsdUIbLcdlp_t";

//     addDiaryEntry(testId, entry);

//   }



// //test purpose
// void printDiary(){
//   DatabaseReference ref = getDiaryReference("-MyDTrYVsdUIbLcdlp_t");
//   ref.once().then((DatabaseEvent dataSnapshot){
//     print("data: " + dataSnapshot.snapshot.value.toString());
//   });
// }

// // //test purpose
// // void printAllEntries(){
// //   getAllEntries("-MyDTrYVsdUIbLcdlp_t");
// // }
  

//   //this one is for test purposes
//   void createTestEntry(){

//     String date = DateTime.now().toString();
//     var newEntry = DiaryEntry(date, "Hello, this is a test entry");
//     newEntry.setId(saveEntry(newEntry));

//     // setState(() {
//     //   widget.entries.add(newEntry);
//     // });
//   }

//   //  ElevatedButton(onPressed: (){
//   //              final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
//   //              provider.googleLogout();
//   //            }, child: const Text("logout")),
//   //           const SizedBox(height: 30,),
//   //           ElevatedButton(onPressed: createUserAccount, child: const Text("test create acc")),
//   //           ElevatedButton(onPressed: addTestEntry, child: const Text("testEntry")),
//   //          ElevatedButton(onPressed: ()=> getJson(_dbId), child: const Text("getDiary")),
