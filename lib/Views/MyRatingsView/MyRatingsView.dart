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

  Map<String, double>ratingCountsAllTime  = {};
  Map<String, double>ratingCountsThisMonth = {};

  String headerTextAllTime = "";
  String headerTextThisMonth = "";

  String setHeaderTextAllTime(){
    double tmpVal = 0;
    String tmpKey = "";
    ratingCountsAllTime.forEach((key, value) {

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

  String setHeaderTextThisMonth(){
    double tmpVal = 0;
    String tmpKey = "";
    ratingCountsThisMonth.forEach((key, value) {

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

  bool isAllTimeViewSelected = true;

  @override
  void initState() {
    super.initState();

    ratingCountsAllTime["1"] = 0;
    ratingCountsAllTime["2"] = 0;
    ratingCountsAllTime["3"] = 0;
    ratingCountsAllTime["4"] = 0;
    ratingCountsAllTime["5"] = 0;

    ratingCountsThisMonth["1"] = 0;
    ratingCountsThisMonth["2"] = 0;
    ratingCountsThisMonth["3"] = 0;
    ratingCountsThisMonth["4"] = 0;
    ratingCountsThisMonth["5"] = 0;

    int currentMonth = DateTime.now().month;
    int currentYear = DateTime.now().year;


  //filling the map with data
    for(var entry in widget.userAccountDTO.diary.entries!){
      DateTime date = DateTime.parse(entry.date);
      for(var entryMsg in entry.entryMsgs){
        if(!entryMsg.isTextField){
         String parsedKey = entryMsg.rating.toInt().toString();
         debugPrint("[--key--]" + parsedKey); 
         ratingCountsAllTime[parsedKey] = ratingCountsAllTime[parsedKey]!+1;

         if(date.month == currentMonth && date.year == currentYear){
            ratingCountsThisMonth[parsedKey] = ratingCountsThisMonth[parsedKey]!+1;
         }
        }
      }
    }
    headerTextAllTime = setHeaderTextAllTime();
    headerTextThisMonth = setHeaderTextThisMonth();
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
                  //split-header-section
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        if(!isAllTimeViewSelected){
                          setState(() {
                            isAllTimeViewSelected = true;
                          });
                        }
                      },
                      child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            children:  [
                               Padding(
                                padding:  const EdgeInsets.only(top: 16.0),
                                child: Text("Insgesamt", style: TextStyle(fontSize: 16, color: isAllTimeViewSelected? Themes.primaryColor: const Color(0xffa4a4a4), fontWeight: FontWeight.bold),),
                              ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children:  [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal:8.0),
                                        child: Divider(thickness: 6, color: isAllTimeViewSelected? Themes.primaryColor: const Color(0xffa4a4a4) ),
                                      )
                                    ],
                                  ),
                                )
                            ]
                          ),
                        ),
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: (() {
                                if(isAllTimeViewSelected){
                                  setState(() {
                                    isAllTimeViewSelected = false;
                                  });
                                }
                              }),
                              child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.max,
                              children:  [
                                 Padding(
                                  padding:  const EdgeInsets.only(top: 16.0),
                                  child: Text("Dieser Monat", style: TextStyle(fontSize: 16, color: isAllTimeViewSelected?const Color(0xffa4a4a4):Themes.primaryColor, fontWeight: FontWeight.bold),),
                                ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children:  [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal:8.0),
                                          child: Divider(thickness: 6, color:  isAllTimeViewSelected?const Color(0xffa4a4a4):Themes.primaryColor, ),
                                        )
                                      ],
                                    ),
                                  )
                              ]
                            ),
                            ),
                          )],
                    ),
                    ),
                  ),
                  //eval-text section
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(isAllTimeViewSelected?headerTextAllTime: headerTextThisMonth, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xffa4a4a4)),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //Pie chart section
                  Expanded(
                    flex: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: PieChart(
                        dataMap: isAllTimeViewSelected? ratingCountsAllTime: ratingCountsThisMonth,
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