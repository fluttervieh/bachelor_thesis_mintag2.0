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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _expandableListItems.add(ExpandableListItem(index: 1, entries: entryMsgDTOs,  isTextField: true));
    _expandableListItems.add(ExpandableListItem(index: 2, entries: entryMsgDTOs,  isTextField: true));
    _expandableListItems.add(ExpandableListItem(index: 1, entries: entryMsgDTOs,  isTextField: false));
    _expandableListItems.add(ExpandableListItem(index: 2, entries: entryMsgDTOs,  isTextField: false));
    _expandableListItems.add(ExpandableListItem(index: 1, entries: entryMsgDTOs,  isTextField: false));
    _expandableListItems.add(ExpandableListItem(index: 2, entries: entryMsgDTOs,  isTextField: false));
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
               child: Container(
                 child: SingleChildScrollView(
                   child: Column(
                     children: [
                        ExpandableListItem(index: 1, entries: entryMsgDTOs,  isTextField: true),
                        ExpandableListItem(index: 2, entries: entryMsgDTOs, isTextField: false),
                        ExpandableListItem(index: 3, entries: entryMsgDTOs,  isTextField: false),
                        ExpandableListItem(index: 4, entries: entryMsgDTOs,  isTextField: false),
                        ExpandableListItem(index: 5, entries: entryMsgDTOs, isTextField: false),
                        

                     ],
                   ),
                 ),
                )
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
    if(entryMsgDTOs.isEmpty){
      showDialog(context: context, builder: (BuildContext context){
        return const AlertDialog(
          title: Text("der Eintrag ist leer"),
        );
      });
    }else{

      DiaryEntryDTO newEntry = DiaryEntryDTO(DateTime.now().toString());
     // persistEntryDTO(widget.userAccountDTO.databaseId!, newEntry);

      newEntry.setEntryMsgs(entryMsgDTOs);
      String entryId = newEntry.entryId!;


      entryMsgDTOs.forEach((element) { 
        debugPrint("-----]" + element.message + ", " + element.rating.toString());
       // persistEntryMsgDTO(widget.userAccountDTO.databaseId!, entryId, element);

      });

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
  final List<EntryMsgDTO> entries;
  final bool isTextField;

  const ExpandableListItem({
    Key? key,
    required this.index,
    required this.entries,
    required this.isTextField,
  }) : super(key: key);


  @override
  State<ExpandableListItem> createState() => _ExpandableListItemState();
}

class _ExpandableListItemState extends State<ExpandableListItem> {

  List<Widget> checkBoxes = [];
  List<bool> selectedBoxes =[];
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    selectedBoxes = [
      false,
      false,
      false,
      false,
      false
    ];
    checkBoxes = [
      CircleCheckbox(entryMsgs: widget.entries, fillColor: Colors.red, value: 1, selectedBoxes: selectedBoxes, index: 0),
      Expanded(child: Container(height: 2, color: const Color(0xffa4a4a4),)),
      CircleCheckbox(entryMsgs: widget.entries, fillColor: Colors.orange, value: 2, selectedBoxes: selectedBoxes, index: 1),
      Expanded(child: Container(height: 2, color: const Color(0xffa4a4a4),)),
      CircleCheckbox(entryMsgs: widget.entries, fillColor: Colors.yellow, value: 3, selectedBoxes: selectedBoxes, index: 2),
      Expanded(child: Container(height: 2, color: const Color(0xffa4a4a4),)),
      CircleCheckbox(entryMsgs: widget.entries, fillColor: Colors.greenAccent, value: 4, selectedBoxes: selectedBoxes, index: 3),
      Expanded(child: Container(height: 2, color: const Color(0xffa4a4a4),)),
      CircleCheckbox(entryMsgs: widget.entries, fillColor: Colors.green, value: 5, selectedBoxes: selectedBoxes, index: 4),
    ];

  }


  @override
  Widget build(BuildContext context) =>Padding(
    padding:  EdgeInsets.symmetric(horizontal: isExpanded?16.0: 48.0, vertical: 16),
    child: GestureDetector(
      onTap: (){
        setState(() {
          isExpanded?isExpanded = false:isExpanded=true;
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
                    TextFormField(
                      decoration: const InputDecoration(
                      hintText: "Schreibe hier deine Gedanken auf...",
                      ),
                      onSaved:  (String?value){
                        if(value != null){

                        }
                      } ,
                    )
                  ],
                ),
              ):
               Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:  [
                    const Text("Heute geht es mir sehr gut." ,style: TextStyle(fontWeight: FontWeight.bold,)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: checkBoxes,  
                      ),
                    )

                ],
              ),
            )
            
            :Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:  [
                  Icon(Icons.check_circle, color: selectedBoxes.contains(true)?const Color(0xff0c947b): const Color(0xffa4a4a4), size: 32,),
                  const SizedBox(width: 16,),
                  const Text("Heute geht es mir sehr gut." ,style: TextStyle(fontWeight: FontWeight.bold,)),
                ],
              ),
            )
        ),
      ),
    ),
  );


  
}

class CircleCheckbox extends StatefulWidget {
   const CircleCheckbox({
    Key? key,
    required this.entryMsgs,
    required this.fillColor,
    required this.value,
        required this.selectedBoxes,
        required this.index


  }) : super(key: key);

  final Color fillColor;
  final int value;
  final int index;
  final List<bool> selectedBoxes;
  final List<EntryMsgDTO> entryMsgs;

  

  @override
  State<CircleCheckbox> createState() => _CircleCheckboxState();
}

class _CircleCheckboxState extends State<CircleCheckbox> {



  

  @override
  Widget build(BuildContext context) {

    EntryMsgDTO msg = EntryMsgDTO("NEW MESSAGE---TEST", widget.value.toDouble(), false);
    bool _isPressed = widget.selectedBoxes[widget.index];

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {

      return GestureDetector(
        onTap: () => setState((){


            if(isNumberSelected()){
            int oldIndex = getIndexOfAlreadySelectedNumber();
            if(oldIndex != widget.index){
              widget.selectedBoxes[oldIndex] = false;
              _isPressed = false;
              widget.entryMsgs.remove(msg);
            }
          }

          if(_isPressed){
             _isPressed = false;
              widget.selectedBoxes[widget.index] = false;
              widget.entryMsgs.remove(msg);
          }else{
             widget.entryMsgs.add(msg);
                widget.selectedBoxes[widget.index] = true;
                _isPressed = true;
          }

        }),
        child: Container(
          height: 36,
          width: 36,
          decoration: BoxDecoration(
            color: _isPressed?widget.fillColor: Colors.white,
            borderRadius: BorderRadius.circular(1000),
            border: Border.all(color: _isPressed?Colors.transparent:const Color(0xffa4a4a4), width: 2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(widget.value.toInt().toString(), style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: _isPressed?Colors.white : const Color(0xffa4a4a4)), )
            ],
          ),
        ),
      );
      }
    );
  }

  int getAlreadySelectedIndex(){
    for(var i in widget.selectedBoxes){
      if(i == true){
        return widget.selectedBoxes.indexOf(i);
      }
    }
    return 0;
  }

  bool isNumberSelected(){return widget.selectedBoxes.contains(true);}

  int getIndexOfAlreadySelectedNumber(){
    int index = 0;
    for(var element in widget.selectedBoxes){
      if(element == true){
        index = widget.selectedBoxes.indexOf(element);
      }
    }
    return index;

  }
  
}

