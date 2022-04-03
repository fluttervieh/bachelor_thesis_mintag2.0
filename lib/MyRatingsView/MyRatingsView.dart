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

  String headerText = "";

  String setHeaderText(){
    double tmpVal = 0;
    String tmpKey = "";
    ratingCounts.forEach((key, value) {

      if(value > tmpVal){
        tmpKey = key;
        tmpVal = value;
      } 
    });

    switch (tmpKey){
      case "1":{
        return "Hmm, dir gehts wohl nicht so gut. Manschmal hilft es, mit jemandem über seine Probleme zu reden.";
      }
      case "2":{
        return "Hmm.. Deine Bewertungen sehen nicht so gut aus..";
      }
      case "3":{
        return "Deine Bewertungen sind ganz schön durchwachsen!";
      }
      case "4":{
        return "Das sieht schon mal ganz gut aus!";
      }
      case "5":{
        return "Hey, dir scheint es überwiegend gut zu gehen. Das ist schön!";
      }
      default: {
        return "Kein Ergebnis";
      }
    }
  }

  final gradientList = <List<Color>>[
  [
     Colors.red,
    Colors.red.withOpacity(0.8),
  ],
  [
     Themes.secondaryColor,
     Themes.secondaryColor.withOpacity(0.8)
     
  ],
  [
    Colors.yellow,
    Colors.yellow.withOpacity(0.8)
  ],
  [
    Colors.lightGreen,
    Colors.lightGreen.withOpacity(0.8)
  ],
  [
    const Color(0xff0c947b),
    const Color(0xff0c947b).withOpacity(0.8),
  ]
];

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
    headerText = setHeaderText();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const HeaderContainer(header: "Meine Bewertungen", subHeader: "Hier siehst die Bewertung aller Einträge, die du bis jetzt gemacht hast."),
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: 80,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(headerText, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xffa4a4a4)),),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: PieChart(
                        dataMap: ratingCounts,
                        animationDuration: const Duration(milliseconds: 1500),
                        chartType: ChartType.disc,
                        legendOptions: const LegendOptions(
                          showLegendsInRow: true,
                          legendPosition: LegendPosition.bottom,
                          legendShape: BoxShape.circle,
                          legendTextStyle:  TextStyle(
                              fontWeight: FontWeight.bold
                          )
                        ),
                        gradientList: gradientList,
                   
                      ),
                    ),
                      
                  ),
                ],
              ),
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