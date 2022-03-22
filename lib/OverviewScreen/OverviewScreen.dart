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
import 'package:mintag_application/Reusable_Widgets/HeaderContainer.dart';
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
    super.initState();
    fetchUserAccount();
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
    final String? userName = _userAccountDTO?.userName.toString();
    
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
             HeaderContainer(header: _userAccountDTO==null?"":"Willkommen, " + userName!, subHeader: "Heute ist der 22.03.2022."),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    OverViewListItem(header: "Mein Tagebuch", subHeader: "Hier kannst du einen neuen Eintrag in dein Tagebuch machen.", assetImgUrl: "assets/img/undraw_Diary.png", onPress: (){}),
                    OverViewListItem(header: "Dankbare Momente", subHeader: "Dankbare Momente erhellen einen regnerischen Tag.", assetImgUrl: "assets/img/undraw_moments.png", onPress: (){}),
                    OverViewListItem(header: "Meine Bewertungen", subHeader: "Gesamtüberblick über deine bisher abgegebenen Bewertungen.", assetImgUrl: "assets/img/undraw_Segment_analysis.png", onPress: (){}),

                    
                  ],
                ),
              )
      
          ],
        ),
      )
      );
    
  }
}


class OverViewListItem extends StatefulWidget {

  final String header;
  final String subHeader;
  final String assetImgUrl;
  final VoidCallback onPress;

  const OverViewListItem({ 
    required this.header,
    required this.subHeader,
    required this.assetImgUrl,
    required this.onPress,
    Key? key }) : super(key: key);

  @override
  State<OverViewListItem> createState() => _OverViewListItemState();
}

class _OverViewListItemState extends State<OverViewListItem> {

  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return  Card(
      color: Colors.white,
      shadowColor: Colors.black,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
      child: SizedBox(
        height: 120,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 16.0, bottom: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Text(widget.header, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                      const SizedBox(height: 8,),
                      Text(widget.subHeader, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xffa4a4a4)),)

                    ],
                  ),
                ),
              )
            ),
            Expanded(
              flex: 3,
              child: ClipRRect(
                
                child: SizedBox(
                  
                  child: Image.asset(widget.assetImgUrl),
                ),
              )
            ),
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTapDown: (_){
                  setState(() {
                    _isPressed = true;
                  });
                },
                onTapUp: (_){
                  setState(() {
                    _isPressed = false;
                  });
                },
                child: Container(
                  decoration:  BoxDecoration(
                      color:  _isPressed?Colors.white:const Color(0xff0c947b),
                      borderRadius: const BorderRadius.only(topRight: Radius.circular(12), bottomRight: Radius.circular(12)),
                      border: Border.all(color: _isPressed?const Color(0xff0c947b): Colors.transparent, width: 2)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:  [
                      Icon(Icons.arrow_forward_ios, color: _isPressed?const Color(0xff0c947b):Colors.white, size: 40,)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      
    );
  }
}