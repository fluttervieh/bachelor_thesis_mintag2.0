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
  final UserAccountDTO tempUserAccount;
  const Prog_OverviewScreen({ required this.tempUserAccount,Key? key }) : super(key: key);

  @override
  State<Prog_OverviewScreen> createState() => _Prog_OverviewScreenState();
}

class _Prog_OverviewScreenState extends State<Prog_OverviewScreen> {

  final keyOne = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


   WidgetsBinding.instance!.addPostFrameCallback((_)async{ ShowCaseWidget.of(context)!.startShowCase([keyOne]); });
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
                            key: keyOne,
                            description: "Hier kannst du neue Einträge in dein Tagebuch machen.",
                            child: OverViewListItem(header: "Mein Tagebuch", subHeader: "Hier kannst du einen neuen Eintrag in dein Tagebuch machen.", assetImgUrl: "assets/img/undraw_Diary.png", onPress: navigateToMyDiaryView)),
                          OverViewListItem(header: "Dankbare Momente", subHeader: "Dankbare Momente erhellen einen regnerischen Tag.", assetImgUrl: "assets/img/undraw_moments.png", onPress: navigateToThankfulMomentsView),
                          OverViewListItem(header: "Meine Bewertungen", subHeader: "Gesamtüberblick über deine bisher abgegebenen Bewertungen.", assetImgUrl: "assets/img/undraw_Segment_analysis.png", onPress: navigateToMyRatingsView),
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
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ShowCaseWidget(builder: Builder(builder: (_) => Prog_MyDiary(tempUserAccount: widget.tempUserAccount,)))));
  }

  void navigateToThankfulMomentsView(){
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) =>  ShowCaseWidget(builder: Builder(builder: (_) => Prog_ThankfulMoments(tempUserAccount: widget.tempUserAccount,)))));
  }

  void navigateToMyRatingsView(){
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) =>  ShowCaseWidget(builder: Builder(builder: (_) => Prog_MyRatingsView(tempUserAccount: widget.tempUserAccount,)))));
  }
}