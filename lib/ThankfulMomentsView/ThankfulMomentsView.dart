import 'dart:collection';

import 'package:flutter/material.dart';
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
                 List<String> e = [];
                e.add(entry.date);
                e.add(entryMsg.message);
                _goodMessages.add(e);
                isSelected.add(false);
                if(entryMsg.isFavorite){
                  _favouriteMessages.add(e);
                }
              }
             
            }  
        }
    }
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
                                      Text("Eintrag vom "  + DateParser.parseDate(DateTime.parse(_goodMessages[index][0])) + ".", style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          _favouriteMessages.contains(_goodMessages[index])?
                                          const Icon(Icons.favorite, color: Colors.red,):
                                          const Icon(Icons.favorite_outline, color: Color(0xffa4a4a4),),
                                          const Icon(Icons.arrow_drop_up, color: Colors.black,),
                                        ],
                                      ),
                                    ]
                                  ),
                                  const SizedBox(height: 8,),
                                  Text(_goodMessages[index][1], style: const TextStyle(color: Color(0xffa4a4a4), fontWeight: FontWeight.bold),)
                                  
                                  
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
                                      Text("Eintrag vom "  + DateParser.parseDate(DateTime.parse(_goodMessages[index][0])) + ":", style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
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
                    itemCount: _goodMessages.length,
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
}


