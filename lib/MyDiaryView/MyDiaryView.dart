import 'package:flutter/material.dart';
import 'package:mintag_application/Database/ModelClasses/UserAccountDTO.dart';
import 'package:mintag_application/Reusable_Widgets/DateParser.dart';
import 'package:mintag_application/Reusable_Widgets/HeaderContainer.dart';
import 'package:mintag_application/Reusable_Widgets/Themes.dart';

class MyDiaryView extends StatefulWidget {

  final UserAccountDTO? userAccountDTO;

  const MyDiaryView({required this.userAccountDTO, Key? key }) : super(key: key);

  
  @override
  State<MyDiaryView> createState() => _MyDiaryViewState();
}

class _MyDiaryViewState extends State<MyDiaryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children:[
            HeaderContainer(header: "Mein Tagebuch", subHeader: "Heute ist der " + DateParser.parseDate(DateTime.now()).toString(), optionalDescription: "Wähle ein freies Datum auf dem Kalender aus und drücke auf “neuer Eintrag”.",),
          ]
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
                child: ElevatedButton(onPressed: ()=> Navigator.of(context).pop(), child:  const Text("Neuer Eintrag"), style: Themes.primaryButtonStyle,),
              )
            ),

        ],
      ),
    );
  }

}