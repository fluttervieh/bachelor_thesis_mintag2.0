// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:mintag_application/Database/ModelClasses/DiaryDTO.dart';
import 'package:mintag_application/Database/ModelClasses/DiaryEntryDTO.dart';
import 'package:mintag_application/Database/ModelClasses/EntryMsgDTO.dart';
import 'package:mintag_application/Database/ModelClasses/UserAccountDTO.dart';
import 'package:mintag_application/Reusable_Widgets/DateParser.dart';
import 'package:mintag_application/Reusable_Widgets/HeaderContainer.dart';
import 'package:mintag_application/Reusable_Widgets/Themes.dart';
import 'package:mintag_application/Views/MyDiaryView/NewEntryView.dart';
import 'package:mintag_application/prog_onboarding/Prog_OverviewScreen.dart';
import 'package:showcaseview/showcaseview.dart';

class Prog_NewEntryView extends StatefulWidget {
  final DateTime newEntryDate;
  final UserAccountDTO tempUserAccount;
  const Prog_NewEntryView({
    required this.newEntryDate,
    required this.tempUserAccount,
    Key? key }) : super(key: key);

  @override
  State<Prog_NewEntryView> createState() => _Prog_NewEntryViewState();
}

class _Prog_NewEntryViewState extends State<Prog_NewEntryView> {

  final introductionKey = GlobalKey();
  final textKey = GlobalKey();
  final checkboxKey = GlobalKey();
  final safeEntryBtnKey = GlobalKey();

  List<Widget> _expandableListItems = [];
  Map<int, EntryMsgDTO> _entryMsgs = {};
  List<EntryMsgDTO> entryMsgDTOs = [];




   @override
  void initState() {
    super.initState();
    _expandableListItems.add(Showcase(key: textKey, description: 'Hier kannst du reinschreiben, was immer du willst. Wenn du fertig bist, drücke "OK" auf deiner Tastatur.', child: Prog_ExpandableListItem(header: "Heute bin ich besonders Dankbar für:", index: 0, entryMsgs: _entryMsgs,  isTextField: true, isSelected: true,)));
    _expandableListItems.add(Prog_ExpandableListItem(header: "Heute bin ich weniger Dankbar für:", index: 1, entryMsgs: _entryMsgs,  isTextField: true, isSelected: false,));
    _expandableListItems.add(Showcase(key: checkboxKey, description: 'Hier siehst eine Bewertungsskala von 1 bis 5, wobei 1 eher schlecht und 5 eher gut ist. Um die Frage zu beantworten, tippe einfach eine der Zahlen an.',child: Prog_ExpandableListItem(header: "Heute habe ich mich gesund gefühlt.", index: 2, entryMsgs: _entryMsgs,  isTextField: false, isSelected: true,)));
    _expandableListItems.add(Prog_ExpandableListItem(header: "Heute habe ich mich gerne für etwas angestrengt.", index: 3, entryMsgs: _entryMsgs,  isTextField: false, isSelected: false,));
    _expandableListItems.add(Prog_ExpandableListItem(header: "Ich habe Wünsche für die Zukunft.",index: 4, entryMsgs: _entryMsgs,  isTextField: false, isSelected: false,));
    _expandableListItems.add(Prog_ExpandableListItem(header: "Manches ist mir heute besonders gut gelungen.", index: 5, entryMsgs: _entryMsgs,  isTextField: false, isSelected: false,));

    WidgetsBinding.instance!.addPostFrameCallback((_)async{ ShowCaseWidget.of(context)!.startShowCase([textKey, checkboxKey, safeEntryBtnKey]); });

  }

  @override
  Widget build(BuildContext context) {
   final String _dateString = DateParser.parseDate(widget.newEntryDate);

    return WillPopScope(
      onWillPop: ()async {
        return false;
      } ,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               HeaderContainer(header: "Neuer Eintrag" , subHeader: "Heutiges Datum: " + _dateString, optionalDescription: "Tippe die jeweiligen Felder an und wähle deine Bewertung von 1-5.",),
               Expanded(
                 child: ListView.builder(itemCount: _expandableListItems.length, itemBuilder: (context, index){
                   return _expandableListItems[index];
                 })
                ),
            ],
          ),
        ),
        bottomNavigationBar: Row(
          children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 8, top: 8, bottom: 8),
                  child: ElevatedButton(
                    onPressed: (){},
                  child:  const Text("Zurück"), style: Themes.secondaryButtonStyle),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 16, top: 8, bottom: 8),
                  child: Showcase(key: safeEntryBtnKey, description: 'Selbstverständlich kannst du noch mehr Fragen beantworten, du kannst aber auch welche unbeantwortet lassen. Wenn du fertig bist, drücke einfach auf "Speichern". So schnell geht`s.', child: ElevatedButton(onPressed: safeEntry, child:  const Text("Speichern"), style: Themes.primaryButtonStyle,)),
                )
              ),
    
          ],
        ),
        
      ),
    );
  }
  void safeEntry(){
   

      DiaryEntryDTO newEntry = DiaryEntryDTO(DateTime.now().toString());
      //persistEntryDTO(widget.userAccountDTO.databaseId!, newEntry);

      List<EntryMsgDTO> messageList = [];

      newEntry.setEntryMsgs(entryMsgDTOs);
      //String entryId = newEntry.entryId!;

      _entryMsgs.forEach((key, value) {
         print("[--mappp------]" + key.toString() + ": " + value.message + " , " + value.rating.toString());

         EntryMsgDTO msgDTO = value;
         messageList.add(value);
      });
      newEntry.setEntryMsgs(messageList);

      widget.tempUserAccount.diary.entries = [];
      widget.tempUserAccount.diary.entries!.add(newEntry);

      widget.tempUserAccount.diary.entries!.forEach((element) {
        element.entryMsgs.forEach((e) {
          print("[--------" + e.message);
        });
      });

     
     if(checkIfMinimumOneTextAndOneNumberIsAnswered(messageList)){
        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ShowCaseWidget(builder: Builder(builder: (_) =>   Prog_OverviewScreen(tempUserAccount: widget.tempUserAccount, isMyDiaryEnabled: false, isThankfulViewEnabled: true, isMyRatingsEabled: false, isTutorialFinished: false,)))));
     }else{
       showDialog(context: context, builder: (BuildContext context){
         return  AlertDialog(
           title: const Text("Damit du das Tutorial erfolgreich abschließen kannst, fülle bitte mindestens eine Textfrage und eine Punktefrage aus."),
           actions: [
             ElevatedButton(onPressed: ()=> Navigator.of(context).pop(), child: const Text("OK"), style: Themes.primaryButtonStyle,)
           ],
         );
       });
     }


      
    
  }
  bool checkIfMinimumOneTextAndOneNumberIsAnswered(List<EntryMsgDTO> messages){

      bool textDone = false;
      bool numberDone = false;

      messages.forEach((m) {
        if(m.isTextField){
          textDone = true;
        }else{
          numberDone = true;
        }
      });

      if(textDone && numberDone){
        return true;
      }else{
        return false;
      }
    }
}

class Prog_ExpandableListItem extends StatefulWidget {

  final String header;
  final int index;
  final Map<int, EntryMsgDTO> entryMsgs;
  final bool isTextField;
  final bool isSelected;

  const Prog_ExpandableListItem({
    Key? key,
    required this.header,
    required this.index,
    required this.entryMsgs,
    required this.isTextField,
    required this.isSelected
  }) : super(key: key);


  @override
  State<Prog_ExpandableListItem> createState() => _Prog_ExpandableListItemState();
}

class _Prog_ExpandableListItemState extends State<Prog_ExpandableListItem> {

  List<CircleSelection> circleSelections = [];
  List<bool> selectedBoxes =[];
  bool isExpanded = false;
  EntryMsgDTO msg = EntryMsgDTO("", 0, false, false);


  String defaultTextValue = "";
  TextEditingController textEditingController = TextEditingController();



  @override
  void initState() {
    super.initState();

    isExpanded = widget.isSelected;

      msg = EntryMsgDTO(widget.header, 0.toDouble(), false, false);
  
      circleSelections.add(CircleSelection(false, 1, (val)=> setState(() 
       {i = val!;
        updateMessageDTOMap(val);
       }
      ), Colors.red));
      circleSelections.add(CircleSelection(false, 2, (val)=> setState(() 
       {i = val!;
        updateMessageDTOMap(val);
       }
      ), Themes.secondaryColor));
      circleSelections.add(CircleSelection(false, 3, (val)=> setState(() 
       {i = val!;
        updateMessageDTOMap(val);
       }
      ), Colors.yellow));
      circleSelections.add(CircleSelection(false, 4, (val)=> setState(() 
       {i = val!;
        updateMessageDTOMap(val);
       }
      ), Colors.lightGreen));
      circleSelections.add(CircleSelection(false, 5, (val)=> setState(() 
       {i = val!;
        updateMessageDTOMap(val);
       }
      ), Themes.primaryColor));
  }

    //callback fkt
    int i = 0;
    set integer(int value) => setState(() {
      i = value;
    });

    //updates msgDTO in map, removes entry on double selection. 
    void updateMessageDTOMap(int value){
       if(widget.entryMsgs[widget.index] != null){
        if(value.toDouble() == widget.entryMsgs[widget.index]!.rating){
          widget.entryMsgs.remove(widget.index);
        }else{
          msg.setRating(value.toDouble());
          widget.entryMsgs[widget.index] = msg;
        }
      }else{
          msg.setRating(value.toDouble());
          widget.entryMsgs[widget.index] = msg;
      }  
    }

  @override
  Widget build(BuildContext context) =>Padding(
    padding:  EdgeInsets.symmetric(horizontal: isExpanded?16.0: 32.0, vertical: 16),
    child: GestureDetector(
      onTap: (){
         setState(() { 
           isExpanded?isExpanded = false:isExpanded=true;
          print("[-----I-" + widget.index.toString() + "---]" + i.toString());
         });
      },
      child: Material(
        elevation: 10,
        shadowColor: Colors.black,
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: SizedBox(
            height: isExpanded?100:60,
            width: MediaQuery.of(context).size.width,
            
            
            child: isExpanded?Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: widget.isTextField?Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Flexible(child: Text(widget.header ,style: const TextStyle(fontWeight: FontWeight.bold,), overflow: TextOverflow.ellipsis, maxLines: 2,)),
                    TextField(
                      controller: textEditingController,
                      decoration: const InputDecoration(
                      hintText: "Schreibe hier deine Gedanken auf...",
                      ),
                      onEditingComplete:() {
                            if(textEditingController.text != ""){
                                setState(() {
                                       defaultTextValue = textEditingController.text;
                                widget.entryMsgs[widget.index]=EntryMsgDTO(widget.header + " " + textEditingController.text, 0, true, false);
                                });

                            }else{
                              setState(() {
                                defaultTextValue = textEditingController.text;
                                widget.entryMsgs.remove(widget.index);
                              });
                            }
                        
                      } ,                    
                    )
                  ],
                ),
              ):
              Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(widget.header ,style: const TextStyle(fontWeight: FontWeight.bold,),overflow: TextOverflow.ellipsis, maxLines: 2),
                    Expanded(
                      child: ListView.builder(shrinkWrap: true, itemCount: circleSelections.length, scrollDirection: Axis.horizontal, itemBuilder: (context, index){
                                    return GestureDetector(
                                      onTap: (){
                                        for(int i = 0; i<circleSelections.length; ++i){                                  
                                          if(i == index){
                                            if(circleSelections[i].isSelected){
                                              setState(() {
                                                circleSelections[i].isSelected = false;
                                                circleSelections[i].callBack(circleSelections[i].value);
                                  
                                              });
                                            }else{
                                              setState(() {
                                                circleSelections[i].isSelected = true;
                                                circleSelections[i].callBack(circleSelections[i].value);
                                              });
                                            }
                                           
                                          }else{
                                            setState(() {
                                              circleSelections[i].isSelected = false;
                                            });
                                          }
                                        }
                                  
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                         height: 36,
                                        width: 36,
                                        decoration: BoxDecoration(
                                          color: circleSelections[index].isSelected?circleSelections[index].fillColor: Colors.white,
                                          borderRadius: BorderRadius.circular(1000),
                                          border: Border.all(color: circleSelections[index].isSelected?Colors.transparent:const Color(0xffa4a4a4), width: 2),
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                         crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(circleSelections[index].value.toString(), style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: circleSelections[index].isSelected?Colors.white : const Color(0xffa4a4a4)), )
                                          ],
                                        ),
                                        ),
                                      ),
                                    );
                                 }),
                    ),
                  ],
                ),
              ),
               
            )
            
            :Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:  [
                  Icon(Icons.check_circle, color: checkIfCircleSelectionsContainsTrue(defaultTextValue)?const Color(0xff0c947b): const Color(0xffa4a4a4), size: 32,),
                  const SizedBox(width: 16,),
                  Flexible(child: Text(widget.header ,style: const TextStyle(fontWeight: FontWeight.bold,), overflow: TextOverflow.clip, maxLines: 2)),
                ],
              ),
            )
        ),
      ),
    ),
  );


// checks 
  bool checkIfCircleSelectionsContainsTrue(String textMsg){
    for (var item in circleSelections) {
      if(item.isSelected){
        return true;
      }
    }
     if(textMsg != ""){
      return true;
    }
    return false;
  }

}