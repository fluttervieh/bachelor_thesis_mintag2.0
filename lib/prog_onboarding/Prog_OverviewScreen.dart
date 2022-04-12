// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:mintag_application/Database/ModelClasses/UserAccountDTO.dart';
import 'package:mintag_application/Reusable_Widgets/DateParser.dart';
import 'package:mintag_application/Reusable_Widgets/HeaderContainer.dart';
import 'package:mintag_application/Views/OverviewScreen/OverviewScreen.dart';
import 'package:mintag_application/prog_onboarding/Prog_MyDiary.dart';
import 'package:mintag_application/prog_onboarding/Prog_MyRatingsView.dart';
import 'package:mintag_application/prog_onboarding/Prog_ThankfulMoments.dart';
import 'package:showcaseview/showcaseview.dart';

class Prog_OverviewScreen extends StatefulWidget {
  final bool isMyDiaryEnabled;
  final bool isThankfulViewEnabled;
  final bool isMyRatingsEabled;
  final UserAccountDTO tempUserAccount;
  const Prog_OverviewScreen({ 
    required this.isMyDiaryEnabled,
    required this.isThankfulViewEnabled,
    required this.isMyRatingsEabled,
    required this.tempUserAccount,
    Key? key }) : super(key: key);

  @override
  State<Prog_OverviewScreen> createState() => _Prog_OverviewScreenState();
}

class _Prog_OverviewScreenState extends State<Prog_OverviewScreen> {

  final myDiaryViewKey = GlobalKey();
  final thankfulMomentsKey = GlobalKey();
  final myRatingsKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    widget.isMyDiaryEnabled? WidgetsBinding.instance!.addPostFrameCallback((_)async{ ShowCaseWidget.of(context)!.startShowCase([myDiaryViewKey]); }):null;
    widget.isThankfulViewEnabled? WidgetsBinding.instance!.addPostFrameCallback((_)async{ ShowCaseWidget.of(context)!.startShowCase([thankfulMomentsKey]); }):null;
    widget.isMyRatingsEabled? WidgetsBinding.instance!.addPostFrameCallback((_)async{ ShowCaseWidget.of(context)!.startShowCase([myRatingsKey]); }):null;

   
  }
  @override
  Widget build(BuildContext context) {
    
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  [
               Stack(
                 children: [
                   HeaderContainer(header: "Herzlich Willkommen!", subHeader: "Heute ist der " + DateParser.parseDate(DateTime.now()).toString(), optionalDescription: "Wie geht es dir heute?",), 
                  
                 ],
               ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Weisheit des Tages", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                          ),
                          const WisdomOfTheDay(),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("MinTag", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                          ),
                          Showcase(
                            key: myDiaryViewKey,
                            description: "Hier kannst du neue Einträge in dein Tagebuch machen.",
                            child: OverViewListItem(header: "Mein Tagebuch", subHeader: "Hier kannst du einen neuen Eintrag in dein Tagebuch machen.", assetImgUrl: "assets/img/undraw_Diary.png", onPress: navigateToMyDiaryView)),
                          Showcase(
                            key: thankfulMomentsKey,
                            description: 'Alle Antworten der zuvor kennengelernten Textfragen kannst du im Menüpunkt "Dankbare Momente" einsehen. Tippe dafür einfach auf den grünen Pfeil.',
                            child: OverViewListItem(header: "Dankbare Momente", subHeader: "Dankbare Momente erhellen einen regnerischen Tag.", assetImgUrl: "assets/img/undraw_moments.png", onPress: navigateToThankfulMomentsView)),
                          Showcase(
                            key: myRatingsKey,
                            description: 'Um ein besseres Gesamtbild über dein generelles Wohlbefinden zu erhalten, werden alle Antworten, welche mit Punkten von 1 bis 5 bewertet wurden, in diesem Punkt angezeigt. Tippe dafür einfach auf de grünen Pfeil.',
                            child: OverViewListItem(header: "Meine Bewertungen", subHeader: "Gesamtüberblick über deine bisher abgegebenen Bewertungen.", assetImgUrl: "assets/img/undraw_Segment_analysis.png", onPress: navigateToMyRatingsView)),
                        ],
                      ),
                    ),
                  ),
                )
              
            ],
          ),
        )
        )
    );
  }
  void navigateToMyDiaryView(){
    widget.isMyDiaryEnabled? Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ShowCaseWidget(builder: Builder(builder: (_) => Prog_MyDiary(tempUserAccount: widget.tempUserAccount,))))):null;
  }

  void navigateToThankfulMomentsView(){
    widget.isThankfulViewEnabled?Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) =>  ShowCaseWidget(builder: Builder(builder: (_) => Prog_ThankfulMoments(tempUserAccount: widget.tempUserAccount,))))):null;
  }

  void navigateToMyRatingsView(){
    widget.isMyRatingsEabled?Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) =>  ShowCaseWidget(builder: Builder(builder: (_) => Prog_MyRatingsView(tempUserAccount: widget.tempUserAccount,))))):null;
  }
}