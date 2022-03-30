import 'package:flutter/material.dart';
import 'package:mintag_application/Database/ModelClasses/DiaryEntryDTO.dart';
import 'package:mintag_application/Database/ModelClasses/EntryMsgDTO.dart';
import 'package:mintag_application/Database/ModelClasses/UserAccountDTO.dart';
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
  List<EntryMsgDTO> entryMsgDTOs = [];

 
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
                        ExpandableListItem(index: 1, entries: entryMsgDTOs,  isTextField: false),
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
                child: ElevatedButton(onPressed: ()=> Navigator.of(context).pop(), child:  const Text("Speichern"), style: Themes.primaryButtonStyle,),
              )
            ),

        ],
      ),
      
    );
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

  List<CircleCheckbox> checkBoxes = [];
  List<bool> selectedBoxes =[];
  bool isExpanded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("[{-------------initState called");


    selectedBoxes = [
      false,
      false,
      false,
      false,
      false
    ];
    checkBoxes = [
      CircleCheckbox(fillColor: Colors.red, value: 1, selectedBoxes: selectedBoxes, index: 0),
      CircleCheckbox(fillColor: Colors.yellow, value: 1, selectedBoxes: selectedBoxes, index: 1),
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
              child: Column(
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
                            
                           
                            // const CircleCheckbox(fillColor: Colors.red, value: 1),
                            // Expanded(child: Container(height: 2, color: Colors.grey,)),
                            // const CircleCheckbox(fillColor: Colors.orange, value: 2),   
                            // Expanded(child: Container(height: 2, color: Colors.grey,)),
                            // const CircleCheckbox(fillColor: Colors.yellow, value: 3),
                            // Expanded(child: Container(height: 2, color: Colors.grey,)),
                            // const CircleCheckbox(fillColor: Colors.greenAccent, value: 4),   
                            // Expanded(child: Container(height: 2, color: Colors.grey,)),
                            // const CircleCheckbox(fillColor: Colors.green, value: 5)

                          
                        
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
                children: const [
                  Icon(Icons.check_circle, color: Color(0xffa4a4a4), size: 32,),
                  SizedBox(width: 16,),
                  Text("Heute geht es mir sehr gut." ,style: TextStyle(fontWeight: FontWeight.bold,)),
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
    required this.fillColor,
    required this.value,
        required this.selectedBoxes,
        required this.index

  }) : super(key: key);

  final Color fillColor;
  final int value;
  final int index;
  final List<bool> selectedBoxes;

  @override
  State<CircleCheckbox> createState() => _CircleCheckboxState();
}

class _CircleCheckboxState extends State<CircleCheckbox> {
  @override
  Widget build(BuildContext context) {
    
    bool _isPressed = widget.selectedBoxes[widget.index];
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {

      return GestureDetector(
        onTap: (){
          if(_isPressed){
            setState(() {
              _isPressed = false;
              widget.selectedBoxes[widget.index] = false;
              
            });
          }else{
            setState(() {
              _isPressed = true;
              widget.selectedBoxes[widget.index] = true;

            });
          }    
        },
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
}

