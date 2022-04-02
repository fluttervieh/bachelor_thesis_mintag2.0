import 'package:flutter/material.dart';
import 'package:mintag_application/Database/ModelClasses/UserAccountDTO.dart';
import 'package:mintag_application/Reusable_Widgets/HeaderContainer.dart';
import 'package:mintag_application/Reusable_Widgets/Themes.dart';
import 'package:pie_chart/pie_chart.dart';

class MyRatingsView extends StatefulWidget {

    final UserAccountDTO userAccountDTO;

  const MyRatingsView({required this.userAccountDTO, Key? key }) : super(key: key);

  @override
  State<MyRatingsView> createState() => _MyRatingsViewState();
}

class _MyRatingsViewState extends State<MyRatingsView> {

  Map<String, double>ratingCounts  = {};

  @override
  void initState() {
    super.initState();

    ratingCounts["1"] = 0;
    ratingCounts["2"] = 0;
    ratingCounts["3"] = 0;
    ratingCounts["4"] = 0;
    ratingCounts["5"] = 0;

    for(var entry in widget.userAccountDTO.diary.entries!){
      for(var entryMsg in entry.entryMsgs){
        if(!entryMsg.isTextField){
         String parsedKey = entryMsg.rating.toInt().toString();
         debugPrint("[--key--]" + parsedKey); 
         ratingCounts[parsedKey] = ratingCounts[parsedKey]!+1;
        }
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const HeaderContainer(header: "Meine Bewertungen", subHeader: "Hier siehst die Bewertung aller Einträge, die du bis jetzt gemacht hast."),
            Expanded(
              child: PieChart(
                dataMap: ratingCounts)
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
}