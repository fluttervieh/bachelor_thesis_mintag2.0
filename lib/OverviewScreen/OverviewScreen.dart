// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mintag_application/Database/Database.dart';
import 'package:mintag_application/Database/ModelClasses/DiaryDTO.dart';
import 'package:mintag_application/Database/ModelClasses/DiaryEntryDTO.dart';
import 'package:mintag_application/Database/ModelClasses/EntryMsgDTO.dart';
import 'package:mintag_application/Database/ModelClasses/UserAccountDTO.dart';
import 'package:mintag_application/LoginScreen/GoogleSignInProvider.dart';
import 'package:mintag_application/MyDiaryView/MyDiaryView.dart';
import 'package:mintag_application/MyRatingsView/MyRatingsView.dart';
import 'package:mintag_application/Reusable_Widgets/DateParser.dart';
import 'package:mintag_application/Reusable_Widgets/HeaderContainer.dart';
import 'package:mintag_application/ThankfulMomentsView/ThankfulMomentsView.dart';
import 'package:provider/provider.dart';


class OverviewScreen extends StatefulWidget {



   const OverviewScreen(
    {Key? key }) 
     : super( key: key);

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {

  final _user = FirebaseAuth.instance.currentUser;
  UserAccountDTO? _userAccountDTO;


  @override
  void initState() {
    super.initState();
    debugPrint("[initstate called");
    fetchUserAccount();
  }

  Future<void>fetchUserAccount()async{
     //_dbId = await _storage.read(key: "db_id");
    UserAccountDTO u = await fetchUserAccountDTO(_user!.uid);

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
             HeaderContainer(header: _userAccountDTO==null?"":"Willkommen, " + userName!, subHeader: "Heute ist der " + DateParser.parseDate(DateTime.now()).toString(), optionalDescription: "Wie geht es dir heute?",),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Weisheit des Tages", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                        ),
                        const WisdomOfTheDay(),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("MinTag", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                        ),
                        OverViewListItem(header: "Mein Tagebuch", subHeader: "Hier kannst du einen neuen Eintrag in dein Tagebuch machen.", assetImgUrl: "assets/img/undraw_Diary.png", onPress: navigateToMyDiaryView),
                        //const SizedBox(height: 16),
                        OverViewListItem(header: "Dankbare Momente", subHeader: "Dankbare Momente erhellen einen regnerischen Tag.", assetImgUrl: "assets/img/undraw_moments.png", onPress: navigateToThankfulMomentsView),
                        //const SizedBox(height: 16),
                        OverViewListItem(header: "Meine Bewertungen", subHeader: "Gesamtüberblick über deine bisher abgegebenen Bewertungen.", assetImgUrl: "assets/img/undraw_Segment_analysis.png", onPress: navigateToMyRatingsView),
                      ],
                    ),
                  ),
                ),
              )
            
          ],
        ),
      )
      );
    
  }

  void navigateToMyDiaryView(){
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => MyDiaryView(userAccountDTO: _userAccountDTO)));
  }

  void navigateToThankfulMomentsView(){
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ThankfulMomentsView(userAccountDTO: _userAccountDTO!)));
  }

  void navigateToMyRatingsView(){
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => MyRatingsView(userAccountDTO: _userAccountDTO!)));
  }
}

class WisdomOfTheDay extends StatelessWidget {
  const WisdomOfTheDay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shadowColor: Colors.black,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
      child: SizedBox(
        height: 140,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:16.0, vertical: 16),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:const [
                 Text("'Wenn du ein Problem hast, dann versuche es zu lösen. Kannst du es nicht lösen, dann mache kein Problem daraus.'", style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16), textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, maxLines: 3,),
                Text("-Buddha", style: TextStyle(color: Color(0xffa4a4a4), fontSize: 12),),
              ],
          ),
        ),
      ),

      
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
                onTap: widget.onPress,
                // onTapDown: (_){
                //     widget.onPress;

                //   setState(() {
                //     _isPressed = true;
                //   });
                // },
                // onTapUp: (_){
                //   setState(() {
                //     _isPressed = false;
                //   });
                // },
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