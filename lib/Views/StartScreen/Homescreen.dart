import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mintag_application/BO_onboarding/BO_StartScreen.dart';
import 'package:mintag_application/Views/CreateDiaryScreen/CreateDiary.dart';
import 'package:mintag_application/Database/Database.dart';
import 'package:mintag_application/Views/LoginScreen/LoginScreen.dart';
import 'package:mintag_application/Views/OverviewScreen/OverviewScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _hasUserAlreadyAccount = false;
  final _storage = const FlutterSecureStorage();
  bool isOnboaringFinished = false;



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
              return const OverviewScreen();          
          }else{
              return const LoginScreen();
          }
         
        },
      ),
    );
  }



 
  
}