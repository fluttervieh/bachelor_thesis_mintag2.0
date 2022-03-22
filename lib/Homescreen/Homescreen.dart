import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mintag_application/CreateDiaryScreen/CreateDiary.dart';
import 'package:mintag_application/Database/Database.dart';
import 'package:mintag_application/Database/ModelClasses/DiaryDTO.dart';
import 'package:mintag_application/Database/ModelClasses/DiaryEntryDTO.dart';
import 'package:mintag_application/Database/ModelClasses/EntryMsgDTO.dart';
import 'package:mintag_application/Database/ModelClasses/UserAccountDTO.dart';
import 'package:mintag_application/LoginScreen/LoginScreen.dart';
import 'package:mintag_application/OverviewScreen/overviewScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _storage = const FlutterSecureStorage();
  var _dbId;

  @override
  void initState() {
    readKeyfromStorage();
    super.initState();
  }

  Future<void> readKeyfromStorage()async{
    _dbId = await _storage.read(key: "db_id");
    await _storage.deleteAll();
    //debugPrint("[----IDDDD-----]" + _dbId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }else if (snapshot.hasError){
            return const Center(child: Text("irgendwas is schiefgelaufen..."),);
          }else if(snapshot.hasData){
            
           
           if(_dbId == "" || _dbId == null){
              return const CreateDiary();
           }else{
             fetchAndParseUserAccountDTO(_dbId);
             return const OverviewScreen(entries: []);
           }
            //return const OverviewScreen(entries: [],);
            //checkSecureStorageandGetUserAccountDTO();
            //return LoginScreen();
            
          }else{
            return const LoginScreen();
          }
        },
      ),
    );
  }

  Future<Widget> checkSecureStorageandGetUserAccountDTO()async {
    String? key = await _storage.read(key: "db_id");

    if(key == null){
      return const CreateDiary();
    }else{
      return const OverviewScreen(entries: []);
    }
  }

  void fetchAndParseUserAccountDTO(String dataBaseId){
  
    DatabaseReference ref = getDiaryReference(dataBaseId);
    ref.once().then((DatabaseEvent dataSnapshot){
    //UserAccountDTO userAccountDTO = UserAccountDTO.fromJson(dataSnapshot.snapshot.value);

        String dataBaseId = dataSnapshot.snapshot.child("databaseId").value.toString();
        String userName = dataSnapshot.snapshot.child("userName").value.toString();

       

        String diaryId = dataSnapshot.snapshot.child("diary/diaryId").value.toString();
        String diaryName = dataSnapshot.snapshot.child("diary/diaryName").value.toString();


        List<DiaryEntryDTO> entries = [];

        dataSnapshot.snapshot.child("diary/entries").children.forEach((e){
          String id = e.child("entryId").value.toString();
          String date = e.child("date").value.toString();
          String msg = e.child("entryMsgs").value.toString();

          DiaryEntryDTO diaryEntryDTO = DiaryEntryDTO(date, []);
          entries.add(diaryEntryDTO);
        });

        DiaryDTO diaryDTO = DiaryDTO( diaryId,  diaryName, entries: entries);
        UserAccountDTO userAccountDTO = UserAccountDTO(diaryDTO, userName, databaseId: dataBaseId);

        return userAccountDTO;
        

        


    });
 // return null;
  }
  
}