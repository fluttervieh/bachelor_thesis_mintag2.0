import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mintag_application/CreateDiaryScreen/CreateDiary.dart';
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
    //await _storage.deleteAll();
    debugPrint("[----IDDDD-----]" + _dbId);
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
            
           
           if(_dbId == null){
              return const CreateDiary();
           }else{

            //UserAccountDTO userAccountDTO =  fetchAndParseUserAccountDTO(_dbId);
            return  const OverviewScreen();
             
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



 
  
}