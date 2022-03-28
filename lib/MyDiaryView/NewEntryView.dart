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
                        ExpandableListItem(index: 1, entries: entryMsgDTOs, isTextField: false),
                        ExpandableListItem(index: 2, entries: entryMsgDTOs, isTextField: false),
                        ExpandableListItem(index: 3, entries: entryMsgDTOs, isTextField: false),
                        ExpandableListItem(index: 4, entries: entryMsgDTOs, isTextField: false),
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

  bool isExpanded = false;
  @override
  Widget build(BuildContext context) =>Padding(
    padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
    child: Material(
      elevation: 10,
      shadowColor: Colors.black,
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      child: SizedBox(
          height: 60,
          width: MediaQuery.of(context).size.width,
          
          
          child: Padding(
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
  );
}