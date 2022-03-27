import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
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

  DateTime _currentDate = DateTime(2022, 2, 3);


  @override
  Widget build(BuildContext context) {

    final _calendarCarousel = CalendarCarousel<Event>(
      onDayPressed: (date, events){
        setState(()=> _currentDate = date);
        for (var event in events) {
          print(event.title);
        }
      },
      weekendTextStyle: const TextStyle(
        color:  Color(0xffE06031)
      ),
      thisMonthDayBorderColor: const Color(0xffa4a4a4),
      height: 400,
      customGridViewPhysics: const NeverScrollableScrollPhysics(),
      todayTextStyle: const TextStyle(color: Colors.yellow),
    );


    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children:[
            HeaderContainer(header: "Mein Tagebuch", subHeader: "Heute ist der " + DateParser.parseDate(DateTime.now()).toString(), optionalDescription: "Wähle ein freies Datum auf dem Kalender aus und drücke auf “neuer Eintrag”.",),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _calendarCarousel,
              ),
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