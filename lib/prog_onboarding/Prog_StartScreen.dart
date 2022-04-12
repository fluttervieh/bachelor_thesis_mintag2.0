// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:mintag_application/Database/ModelClasses/DiaryDTO.dart';
import 'package:mintag_application/Database/ModelClasses/UserAccountDTO.dart';
import 'package:mintag_application/prog_onboarding/Prog_OverviewScreen.dart';
import 'package:showcaseview/showcaseview.dart';

class Prog_StartScreen extends StatefulWidget {
  const Prog_StartScreen({ Key? key }) : super(key: key);

  @override
  State<Prog_StartScreen> createState() => _Prog_StartScreenState();
}

class _Prog_StartScreenState extends State<Prog_StartScreen> {



  UserAccountDTO tempUserAccount  = UserAccountDTO(DiaryDTO("123456789", "tempUser's Diary"), "tempUser");

  
  @override
  Widget build(BuildContext context) {
   return Center(
      child: ElevatedButton(onPressed: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> ShowCaseWidget(builder: Builder(builder: (_)=>Prog_OverviewScreen(tempUserAccount: tempUserAccount, isMyDiaryEnabled: true, isMyRatingsEabled: false, isThankfulViewEnabled: false,))))), child: const Text("Los gehts"),),
      
    );
  }
}