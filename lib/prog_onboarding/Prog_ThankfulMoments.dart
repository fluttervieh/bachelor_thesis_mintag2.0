// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:mintag_application/Reusable_Widgets/DateParser.dart';
import 'package:mintag_application/Reusable_Widgets/HeaderContainer.dart';
import 'package:mintag_application/Views/ThankfulMomentsView/ThankfulMomentsView.dart';

import '../Reusable_Widgets/Themes.dart';

class Prog_ThankfulMoments extends StatefulWidget {
  const Prog_ThankfulMoments({ Key? key }) : super(key: key);

  @override
  State<Prog_ThankfulMoments> createState() => _Prog_ThankfulMomentsState();
}

class _Prog_ThankfulMomentsState extends State<Prog_ThankfulMoments> {

   //Map<DateTime, String> _badMessages = {};
  List<bool> isSelected = [];
  List<bool> isFavouriteSelected = [];

  Map<String?, EntryMsgWrapper> allMessages = {};
  Map<String?, EntryMsgWrapper> favoriteMessages = {};
  List<String?> allMessagesKeys = [];
  List<String?> favoriteMessagesKeys = [];


  bool areAllMessagesSelected = true;

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: SafeArea(
        child: Column(
          children:   [
            const HeaderContainer(header: "Meine Momente", subHeader: "Hier werden Situationen angegeben, für die du in letzter Zeit besonders dankbar warst."),
            Expanded(
              child: Column(
              children:[
                Expanded(
                  flex: 1, 
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              areAllMessagesSelected = true;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            children:  [
                               Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: Text("Alle", style: TextStyle(fontSize: 16, color: areAllMessagesSelected? Themes.primaryColor: Themes.secondaryTextColor, fontWeight: FontWeight.bold),),
                              ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children:  [
                                      Padding(
                                        padding:const EdgeInsets.symmetric(horizontal:8.0),
                                        child: Divider(thickness: 6, color: areAllMessagesSelected?Themes.primaryColor:Themes.secondaryTextColor),
                                      )
                                    ],
                                  ),
                                )
                            ]
                          ),
                        ),
                      ),
                        Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              areAllMessagesSelected = false;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            children:  [
                               Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: Text("Favoriten", style: TextStyle(fontSize: 16, color: areAllMessagesSelected?  Themes.secondaryTextColor:Themes.primaryColor, fontWeight: FontWeight.bold),),
                              ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children:  [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal:8.0),
                                        child: Divider(thickness: 6, color: areAllMessagesSelected? Themes.secondaryTextColor:Themes.primaryColor, ),
                                      )
                                    ],
                                  ),
                                )
                            ]
                          ),
                        ),
                        )],
                  )
                ),
                Expanded(
                  flex: 9, 
                  child: Container(
                        
                      
                     
                    ),
                  )
                

              ]
            )
            
            )
          ],
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: ElevatedButton(onPressed: ()=> Navigator.of(context).pop(), child: const Text("Zurück"), style: Themes.secondaryButtonStyle,),
            ),
          )
        ],
      ),
    );
  }
}