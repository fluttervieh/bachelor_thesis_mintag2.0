import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mintag_application/Database/Database.dart';
import 'package:mintag_application/Database/ModelClasses/DiaryEntryDTO.dart';
import 'package:mintag_application/Database/ModelClasses/EntryMsgDTO.dart';
import 'package:mintag_application/Database/ModelClasses/UserAccountDTO.dart';
import 'package:mintag_application/OverviewScreen/OverviewScreen.dart';
import 'package:mintag_application/Reusable_Widgets/DateParser.dart';
import 'package:mintag_application/Reusable_Widgets/HeaderContainer.dart';
import 'package:mintag_application/Reusable_Widgets/Themes.dart';

class NewEntryView extends StatefulWidget {

  final DateTime newEntryDate;
  final UserAccountDTO userAccountDTO;

  const NewEntryView({ required this.userAccountDTO, required this.newEntryDate, Key? key }) : super(key: key);

  @override
  State<NewEntryView> createState() => _NewEntryViewState();
}

class _NewEntryViewState extends State<NewEntryView> {

  // DiaryEntryDTO diaryEntryDTO= n;

  final user = FirebaseAuth.instance.currentUser;
  List<EntryMsgDTO> entryMsgDTOs = [];
  List<ExpandableListItem> _expandableListItems = [];
  Map<int, EntryMsgDTO> _entryMsgs = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _expandableListItems.add(ExpandableListItem(index: 0, entryMsgs: _entryMsgs,  isTextField: true));
    _expandableListItems.add(ExpandableListItem(index: 1, entryMsgs: _entryMsgs,  isTextField: true));
    _expandableListItems.add(ExpandableListItem(index: 2, entryMsgs: _entryMsgs,  isTextField: false));
    _expandableListItems.add(ExpandableListItem(index: 3, entryMsgs: _entryMsgs,  isTextField: false));
    _expandableListItems.add(ExpandableListItem(index: 4, entryMsgs: _entryMsgs,  isTextField: false));
    _expandableListItems.add(ExpandableListItem(index: 5, entryMsgs: _entryMsgs,  isTextField: false));
  }

 
  @override
  Widget build(BuildContext context) {

    final String _dateString = DateParser.parseDate(widget.newEntryDate);

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             HeaderContainer(header: "Neuer Eintrag" , subHeader: _dateString, optionalDescription: "Tippe die jeweiligen Boxen an und swipe für eine Bewertung.",),
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
                child: ElevatedButton(onPressed: ()=> Navigator.of(context).pop(), child:  const Text("Zurück"), style: Themes.secondaryButtonStyle),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 16, top: 8, bottom: 8),
                child: ElevatedButton(onPressed: safeEntry, child:  const Text("Speichern"), style: Themes.primaryButtonStyle,),
              )
            ),

        ],
      ),
      
    );
  }

//persists the entry
  void safeEntry(){
    if(_entryMsgs.isEmpty){
      showDialog(context: context, builder: (BuildContext context){
        return const AlertDialog(
          title: Text("der Eintrag ist leer"),
        );
      });
    }else{

      DiaryEntryDTO newEntry = DiaryEntryDTO(DateTime.now().toString());
     // persistEntryDTO(widget.userAccountDTO.databaseId!, newEntry);

      newEntry.setEntryMsgs(entryMsgDTOs);
      //String entryId = newEntry.entryId!;


      // entryMsgDTOs.forEach((element) { 
      //   debugPrint("-----]" + element.message + ", " + element.rating.toString());
      //  // persistEntryMsgDTO(widget.userAccountDTO.databaseId!, entryId, element);

      // });

      _entryMsgs.forEach((key, value) => print("[--mappp------]" + key.toString() + ": " + value.message + " , " + value.rating.toString()));

      //addDiaryEntry(user!.uid, newEntry);
      showDialog(context: context, builder: (BuildContext context){
        return  AlertDialog(
          title: const Text("it worked!"),
          actions: [
            ElevatedButton(onPressed: navigateToOverView, child: const Text("back to overview"), style: Themes.primaryButtonStyle,)
          ],
        );
      });

    }
  }

  void navigateToOverView(){
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const OverviewScreen()));
  }
}

class ExpandableListItem extends StatefulWidget {

  final int index;
  final Map<int, EntryMsgDTO> entryMsgs;
  final bool isTextField;

  const ExpandableListItem({
    Key? key,
    required this.index,
    required this.entryMsgs,
    required this.isTextField,
  }) : super(key: key);


  @override
  State<ExpandableListItem> createState() => _ExpandableListItemState();
}

class _ExpandableListItemState extends State<ExpandableListItem> {

  List<CircleSelection> circleSelections = [];
  List<bool> selectedBoxes =[];
  bool isExpanded = false;
  EntryMsgDTO msg = EntryMsgDTO("NEW MESSAGE---TEST", 0.toDouble(), false);


  String defaultTextValue = "";
  TextEditingController textEditingController = TextEditingController();



  @override
  void initState() {
    super.initState();
  
      circleSelections.add(CircleSelection(false, 1, (val)=> setState(() 
       {i = val!;
        updateMessageDTOMap(val);
       }
      ), Colors.red));
      circleSelections.add(CircleSelection(false, 2, (val)=> setState(() 
       {i = val!;
        updateMessageDTOMap(val);
       }
      ), Colors.orange));
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
      ), Colors.green));
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
    padding:  EdgeInsets.symmetric(horizontal: isExpanded?16.0: 48.0, vertical: 16),
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
                    const Text("Heute bin ich besonders dankbar für:" ,style: TextStyle(fontWeight: FontWeight.bold,)),
                    TextField(
                      controller: textEditingController,
                      decoration: const InputDecoration(
                      hintText: "Schreibe hier deine Gedanken auf...",
                      ),
                      onEditingComplete:() {
                            if(textEditingController.text != ""){
                                setState(() {
                                       defaultTextValue = textEditingController.text;
                                widget.entryMsgs[widget.index]=EntryMsgDTO(textEditingController.text, 0, true);
                                });

                            }else{
                              setState(() {
                                defaultTextValue = textEditingController.text;
                                widget.entryMsgs.remove(widget.index);
                              });
                            }
                        
                      } ,
                       
                        //todo: validation
                    
                    )
                  ],
                ),
              ):
              Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    const Text("Heute geht es mir sehr gut." ,style: TextStyle(fontWeight: FontWeight.bold,)),
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
                  const Text("Heute geht es mir sehr gut." ,style: TextStyle(fontWeight: FontWeight.bold,)),
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

typedef void IntCallBack(int? i);



class CircleSelection{
  bool isSelected;
  int value;
  IntCallBack callBack;
  Color fillColor;

  CircleSelection(this.isSelected, this.value, this.callBack, this.fillColor);
}

