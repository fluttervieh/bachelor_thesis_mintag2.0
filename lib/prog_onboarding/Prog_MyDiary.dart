// ignore_for_file: camel_case_types


import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:mintag_application/Database/ModelClasses/DiaryEntryDTO.dart';
import 'package:mintag_application/Database/ModelClasses/UserAccountDTO.dart';
import 'package:mintag_application/Reusable_Widgets/DateParser.dart';
import 'package:mintag_application/Reusable_Widgets/HeaderContainer.dart';
import 'package:mintag_application/Reusable_Widgets/Themes.dart';
import 'package:mintag_application/prog_onboarding/Prog_NewEntry.dart';

class Prog_MyDiary extends StatefulWidget {
  final UserAccountDTO tempUserAccount;
  const Prog_MyDiary({required this.tempUserAccount, Key? key }) : super(key: key);

  @override
  State<Prog_MyDiary> createState() => _Prog_MyDiaryState();
}

class _Prog_MyDiaryState extends State<Prog_MyDiary> {

  DateTime _currentDate = DateTime.now();
  final EventList<Event> _markedDateMap = EventList(events: {});


  static final Widget _eventIcon = Container(
    decoration:  BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Themes.primaryColor, width: 2.0)),
    child: const  Icon(
      Icons.check,
      color: Themes.primaryColor,
    ),
  );


   //initState fills map with events
  @override
  void initState() {
    super.initState();
    List<DiaryEntryDTO>? allEntries = widget.tempUserAccount.diary.entries;
    // for(var entry in allEntries!){
    //   debugPrint("date: " + entry.date);
    //   var parsedDate = DateTime.parse(entry.date);
    //   var parsedYear = parsedDate.year;
    //   var parsedMonth = parsedDate.month;
    //   var parsedDay = parsedDate.day;

    //   var newFormattedDate = DateTime(parsedYear, parsedMonth, parsedDay);
      

    //   _markedDateMap.add(
    //     newFormattedDate,
    //      Event(
    //       date: newFormattedDate,
    //       title: 'Entry',
    //       icon: _eventIcon
    //     ));
    // }
    final now = DateTime.now();
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    _markedDateMap.add(yesterday,Event(date: yesterday, icon: _eventIcon));
  }



  @override
  Widget build(BuildContext context) {

     //initalizing the calendar + styles
    final _calendarCarousel = CalendarCarousel<Event>(
      onDayPressed: (date, events){
        debugPrint("[--day pressed--]" + date.toString());
        setState((){ _currentDate = date;});
        for (var event in events) {
          print(event.title);
        }
      },
      headerTextStyle: const TextStyle(color:  Color(0xff0c947b), fontSize: 16, fontWeight: FontWeight.bold),
      leftButtonIcon: const Icon(Icons.arrow_back_ios, color: Themes.primaryColor,),
      rightButtonIcon: const Icon(Icons.arrow_forward_ios, color: Themes.primaryColor),
      //text: const TextStyle(color: Themes.primaryColor),
      weekendTextStyle: const TextStyle(
        color:  Themes.secondaryColor,
      ),
      thisMonthDayBorderColor: const Color(0xffa4a4a4),
      height: 400,
      customGridViewPhysics: const NeverScrollableScrollPhysics(),
      todayTextStyle: const TextStyle(color: Colors.white),
      todayButtonColor: Themes.secondaryColor,
      selectedDateTime: _currentDate,
      selectedDayButtonColor: Themes.primaryColor,
      markedDatesMap: _markedDateMap,
      markedDateIconBorderColor: Colors.black,
      markedDateShowIcon: true,
      markedDateIconMaxShown: 1,
      showIconBehindDayText: false,
       markedDateIconBuilder: (event) {
        return event.icon ?? const Icon(Icons.help_outline);
      },

    );
   return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children:[
            HeaderContainer(header: "Mein Tagebuch", subHeader: "Heute ist der " + DateParser.parseDate(DateTime.now()).toString(), optionalDescription: "Wähle ein freies Datum auf dem Kalender aus und drücke auf “neuer Eintrag”.",),
            const SizedBox(height: 16,),
            Column(
              children: [
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: _calendarCarousel,
                  ),
              ],
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
                child: ElevatedButton(onPressed: ()=>navigateToNewEntryView(_currentDate), child:  const Text("Neuer Eintrag"), style: Themes.primaryButtonStyle,),
              )
            ),

        ],
      ),
    );
  }
   void navigateToNewEntryView(DateTime selectedDate){

    var isSameDay = false;
    _markedDateMap.events.forEach((key, value) {
        if(DateParser.isSameDay(key, selectedDate)){
          isSameDay = true;
        }
    });

    var isDateInFuture = selectedDate.isAfter(DateTime.now());


    if(!isSameDay && !isDateInFuture){
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => Prog_NewEntryView(newEntryDate: selectedDate, tempUserAccount: widget.tempUserAccount,)
        )
      );
    }else if(isSameDay && !isDateInFuture){
      showDialog(context: context, builder: (BuildContext context){
        return const AlertDialog(
          title: Text("HIER HAST DU SCHON EINEN EINTRAG GEMACHT"),
        );
      });
    }else{
      showDialog(context: context, builder: (BuildContext context){
        return const AlertDialog(
          title: Text("DER TAG LIEGT IN DER ZUKUNFT"),
        );
      });
    }
      
  }
}