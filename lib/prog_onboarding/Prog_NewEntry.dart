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

  List<ExpandableListItem> _expandableListItems = [];
  Map<int, EntryMsgDTO> _entryMsgs = {};
  List<EntryMsgDTO> entryMsgDTOs = [];




   @override
  void initState() {
    super.initState();
    _expandableListItems.add(ExpandableListItem(header: "Heute bin ich besonders Dankbar für:", index: 0, entryMsgs: _entryMsgs,  isTextField: true));
    _expandableListItems.add(ExpandableListItem(header: "Heute bin ich weniger Danbar für:", index: 1, entryMsgs: _entryMsgs,  isTextField: true));
    _expandableListItems.add(ExpandableListItem(header: "Heute habe ich mich gesund gefühlt.", index: 2, entryMsgs: _entryMsgs,  isTextField: false));
    _expandableListItems.add(ExpandableListItem(header: "Heute habe ich mich gerne für etwas angestrengt.", index: 3, entryMsgs: _entryMsgs,  isTextField: false));
    _expandableListItems.add(ExpandableListItem(header: "Ich habe Wünsche für die Zukunft.",index: 4, entryMsgs: _entryMsgs,  isTextField: false));
    _expandableListItems.add(ExpandableListItem(header: "Manches ist mir heute besonders gut gelungen.", index: 5, entryMsgs: _entryMsgs,  isTextField: false));
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
                  child: ElevatedButton(onPressed: safeEntry, child:  const Text("Speichern"), style: Themes.primaryButtonStyle,),
                )
              ),
    
          ],
        ),
        
      ),
    );
  }
  void safeEntry(){
    if(_entryMsgs.isEmpty){
      showDialog(context: context, builder: (BuildContext context){
        return const AlertDialog(
          title: Text("der Eintrag ist leer"),
        );
      });
    }else{

      DiaryEntryDTO newEntry = DiaryEntryDTO(DateTime.now().toString());
      //persistEntryDTO(widget.userAccountDTO.databaseId!, newEntry);

      List<EntryMsgDTO> messageList = [];

      newEntry.setEntryMsgs(entryMsgDTOs);
      String entryId = newEntry.entryId!;

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

      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Prog_OverviewScreen(tempUserAccount: widget.tempUserAccount)));

      
    }
  }
}