import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:mintag_application/Database/Database.dart';
import 'package:mintag_application/Database/ModelClasses/DiaryEntryDTO.dart';
import 'package:mintag_application/Database/ModelClasses/EntryMsgDTO.dart';
import 'package:mintag_application/Database/ModelClasses/UserAccountDTO.dart';
import 'package:mintag_application/Reusable_Widgets/DateParser.dart';
import 'package:mintag_application/Reusable_Widgets/HeaderContainer.dart';
import 'package:mintag_application/Reusable_Widgets/Themes.dart';

class ThankfulMomentsView extends StatefulWidget {

  final UserAccountDTO userAccountDTO;

  const ThankfulMomentsView({ required this.userAccountDTO, Key? key }) : super(key: key);

  @override
  State<ThankfulMomentsView> createState() => _ThankfulMomentsViewState();
}

class _ThankfulMomentsViewState extends State<ThankfulMomentsView> {

  List<List<String>> _goodMessages = [];
  List<List<String>> _favouriteMessages = [];
  //Map<DateTime, String> _badMessages = {};
  List<bool> isSelected = [];
  List<bool> isFavouriteSelected = [];

  Map<String?, EntryMsgWrapper> allMessages = {};
  Map<String?, EntryMsgWrapper> favoriteMessages = {};
  List<String?> allMessagesKeys = [];
  List<String?> favoriteMessagesKeys = [];




                     


  @override
  void initState() {
    super.initState();

    List<DiaryEntryDTO>? entries=  widget.userAccountDTO.diary.entries;
    
    if(entries != null){

        entries = List.from(entries.reversed);

        List<EntryMsgDTO> entryMsgs = [];
        for( var entry in entries){
            entryMsgs = entry.entryMsgs;

            //todo: somehow filter bad/ good
            for(var entryMsg in entryMsgs){
              if(entryMsg.isTextField){

                allMessages[entryMsg.entryMsgId] = EntryMsgWrapper(entry.entryId,entryMsg.entryMsgId, entry.date, entryMsg.message, entryMsg.isFavorite);
               
                isSelected.add(false);
                if(entryMsg.isFavorite){
                  favoriteMessages[entryMsg.entryMsgId] = EntryMsgWrapper(entry.entryId, entryMsg.entryMsgId, entry.date, entryMsg.message, entryMsg.isFavorite);
                }
              }
             
            }  
        }
    }
    allMessagesKeys = allMessages.keys.toList();
    favoriteMessagesKeys = favoriteMessages.keys.toList();
    allMessages.forEach((key, value) {debugPrint("[---key: " + value.entryId! + " [val: "  + value.msg  + " " + value.date);});
  }

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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          children:  [
                            const Padding(
                              padding:  EdgeInsets.only(top: 16.0),
                              child: Text("Alle", style: TextStyle(fontSize: 16, color: Themes.primaryColor, fontWeight: FontWeight.bold),),
                            ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal:8.0),
                                      child: Divider(thickness: 6, color: Themes.primaryColor, ),
                                    )
                                  ],
                                ),
                              )
                          ]
                        ),
                      ),
                        Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          children:  [
                            const Padding(
                              padding:  EdgeInsets.only(top: 16.0),
                              child: Text("Favoriten", style: TextStyle(fontSize: 16, color: Color(0xffa4a4a4), fontWeight: FontWeight.bold),),
                            ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal:8.0),
                                      child: Divider(thickness: 6, color: Color(0xffa4a4a4), ),
                                    )
                                  ],
                                ),
                              )
                          ]
                        ),
                        )],
                  )
                ),
                Expanded(
                  flex: 9, 
                  child: Container(
                    child: ListView.builder(itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => setState(() {
                          
                          if(isTabisAlreadyOpened()){
                            int oldIndex = getIndexOfAlreadyOpenedTab();
                            if(oldIndex != index){
                               isSelected[oldIndex] = false;
                            }
                          }
                          if(isSelected[index]){
                            isSelected[index] = false;
                          }else{
                            isSelected[index] = true;
                          }
                        }),
                        child: isSelected[index]?
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
                                        children: [
                                          IconButton(onPressed: ()=>updateEntryMsg(allMessages[allMessagesKeys[index]]!, widget.userAccountDTO.databaseId!, favoriteMessages), icon:  favoriteMessagesKeys.contains(allMessagesKeys[index])? const Icon(Icons.favorite, color: Colors.red,):const Icon(Icons.favorite_outline, color: Color(0xffa4a4a4),),),
                                          const  Icon(Icons.arrow_drop_up, color: Colors.black,),
                                        ],
                                      ),
                                    ]
                                  ),
                                  const SizedBox(height: 8,),
                                  Text(allMessages[allMessagesKeys[index]]!.msg, style: const TextStyle(color: Color(0xffa4a4a4), fontWeight: FontWeight.bold),)
                                  
                                  
                                ],
                              ),
                            ),
                            // child: Text(
                            //   _goodMessages[index][0] + ", "+ _goodMessages[index][1]),
                            // ) ,
                          )
                        ):Card(
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
                                      Text("Eintrag vom "  + DateParser.parseDate(DateTime.parse(allMessages[allMessagesKeys[index]]!.date)) + ":", style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                                      const Icon(Icons.arrow_drop_down, color: Colors.black,),
                                    ]
                                  ),
                                ],
                              ),
                            ),
                            // child: Text(
                            //   _goodMessages[index][0] + ", "+ _goodMessages[index][1]),
                            // ) ,
                          )
                        )
                      );
                    },
                    itemCount: allMessagesKeys.length,
                    )),
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


  int getIndexOfAlreadyOpenedTab(){
    int index = 0;
    for (var element in isSelected) {
      if(element == true){
        index =  isSelected.indexOf(element);
      }
    }
    return index;
  }

  bool isTabisAlreadyOpened(){
    return isSelected.contains(true);
  }

  void updateEntryMsg (EntryMsgWrapper msg, String dbId, Map<String?, EntryMsgWrapper> favoriteMap){

    debugPrint("[---tapped---]");

    String entryId = msg.entryId!;
    String entryMsgId = msg.entryMsgId!;
    
    EntryMsgDTO entryMsgDTO = EntryMsgDTO(msg.msg, 0, true, msg.isFavorite);

    updateEntryMsgDTO(dbId, entryId, entryMsgId, entryMsgDTO, msg.isFavorite?false:true);

    setState(() {

      if(msg.isFavorite){
        favoriteMap[entryMsgId] = EntryMsgWrapper(entryId, entryMsgId, msg.date, msg.msg, true);
      }else{
        favoriteMap.remove(entryMsgId);
      }
      
    });

  }
}

//wrapper to get the date into msg
class EntryMsgWrapper{
  String? entryId;
  String? entryMsgId;
  String date;
  String msg;
  bool isFavorite;

  EntryMsgWrapper(this.entryId, this.entryMsgId,  this.date, this.msg, this.isFavorite);
}


