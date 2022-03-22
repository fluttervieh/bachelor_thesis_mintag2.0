import 'package:firebase_auth/firebase_auth.dart';
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
    // TODO: implement initState
    readKeyfromStorage();
    super.initState();
  }

  Future<void> readKeyfromStorage()async{
    _dbId = await _storage.read(key: "db_id");
    debugPrint(_dbId);
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
}