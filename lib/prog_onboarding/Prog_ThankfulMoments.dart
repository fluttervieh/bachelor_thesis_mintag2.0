// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:mintag_application/Database/ModelClasses/DiaryEntryDTO.dart';
import 'package:mintag_application/Database/ModelClasses/EntryMsgDTO.dart';
import 'package:mintag_application/Database/ModelClasses/UserAccountDTO.dart';
import 'package:mintag_application/Reusable_Widgets/DateParser.dart';
import 'package:mintag_application/Reusable_Widgets/HeaderContainer.dart';
import 'package:mintag_application/Views/ThankfulMomentsView/ThankfulMomentsView.dart';
import 'package:mintag_application/prog_onboarding/Prog_OverviewScreen.dart';
import 'package:showcaseview/showcaseview.dart';

import '../Reusable_Widgets/Themes.dart';

class Prog_ThankfulMoments extends StatefulWidget {
  final UserAccountDTO tempUserAccount;
  const Prog_ThankfulMoments({ required this.tempUserAccount, Key? key }) : super(key: key);

  @override
  State<Prog_ThankfulMoments> createState() => _Prog_ThankfulMomentsState();
}

class _Prog_ThankfulMomentsState extends State<Prog_ThankfulMoments> {

  final textItemKey = GlobalKey();
  final backBtnKey = GlobalKey();

   //Map<DateTime, String> _badMessages = {};
  //List<bool> isSelected = [];
  //List<bool> isFavouriteSelected = [];

  Map<String?, EntryMsgWrapper> allMessages = {};
  Map<String?, EntryMsgWrapper> favoriteMessages = {};
  List<String?> allMessagesKeys = [];
  List<String?> favoriteMessagesKeys = [];

  bool areAllMessagesSelected = true;

  @override
  void initState() {
    super.initState();
    buildList();

      WidgetsBinding.instance!.addPostFrameCallback((_)async{ ShowCaseWidget.of(context)!.startShowCase([textItemKey, backBtnKey]); });

  }

  void buildList(){

    List<DiaryEntryDTO>? entries = widget.tempUserAccount.diary.entries;

    List<EntryMsgDTO> entryMsgs = [];
    if(entries != null){
      for( var entry in entries){
            entryMsgs = entry.entryMsgs;

            //todo: somehow filter bad/ good
            for(var entryMsg in entryMsgs){
              if(entryMsg.isTextField){
                allMessages[entryMsg.entryMsgId] = EntryMsgWrapper(entry.entryId,entryMsg.entryMsgId, entry.date, entryMsg.message, entryMsg.isFavorite);
              }
            }  
        }

        setState(() {
            allMessagesKeys = allMessages.keys.toList();
        });
    }
  }

  @override
  Widget build(BuildContext context) {
     return WillPopScope(
       onWillPop: ()async => false,
       child: Scaffold(
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
                              // setState(() {
                              //   areAllMessagesSelected = true;
                              // });
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
                              // setState(() {
                              //   areAllMessagesSelected = false;
                              // });
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
                          child: ListView.builder(itemCount: allMessagesKeys.length, itemBuilder: (context, index){
                            return index == 0? 
                            Showcase(
                              key: textItemKey,
                              description: 'Hier siehst du deinen zuvor erstellten Eintrag.',
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: SizedBox(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text("Eintrag vom "  + DateParser.parseDate(DateTime.parse(allMessages[allMessagesKeys[index]]!.date)) + ".", style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: const [
                                                 Icon(Icons.favorite_outline, color: Color(0xffa4a4a4),),
                                                 Icon(Icons.arrow_drop_up, color: Colors.black,),
                                              ],
                                            ),
                                          ]
                                        ),
                                        const SizedBox(height: 8,),
                                        Text(allMessages[allMessagesKeys[index]]!.msg, style: const TextStyle(color: Color(0xffa4a4a4), fontWeight: FontWeight.bold),)
                                        
                                    
                                      ],
                                    ),
                                  ),
                                )
                              ),
                            ):
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text("Eintrag vom "  + DateParser.parseDate(DateTime.parse(allMessages[allMessagesKeys[index]]!.date)) + ".", style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: const [
                                               Icon(Icons.favorite_outline, color: Color(0xffa4a4a4),),
                                               Icon(Icons.arrow_drop_up, color: Colors.black,),
                                            ],
                                          ),
                                        ]
                                      ),
                                      const SizedBox(height: 8,),
                                      Text(allMessages[allMessagesKeys[index]]!.msg, style: const TextStyle(color: Color(0xffa4a4a4), fontWeight: FontWeight.bold),)
                                      
                                  
                                    ],
                                  ),
                                ),
                              )
                            );

                          })
                        
                       
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
              child: Showcase(
                key: backBtnKey,
                description: 'Tippe auf "Zurück", um auf zurück auf die Startseite zu gelangen.',
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: ElevatedButton(onPressed: ()=> navigateToOverView(), child: const Text("Zurück"), style: Themes.secondaryButtonStyle,),
                ),
              ),
            )
          ],
        ),
         ),
     );
  }

  void navigateToOverView(){
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ShowCaseWidget(builder: Builder(builder: (_) =>  Prog_OverviewScreen(tempUserAccount: widget.tempUserAccount, isMyDiaryEnabled: false, isThankfulViewEnabled: false, isMyRatingsEabled: true, isTutorialFinished: false,)))));

  }
}