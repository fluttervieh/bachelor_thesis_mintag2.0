import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:mintag_application/Database/ModelClasses/DiaryEntryDTO.dart';
import 'package:mintag_application/Database/ModelClasses/UserAccountDTO.dart';
import 'package:mintag_application/MyDiaryView/NewEntryView.dart';
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

  DateTime _currentDate = DateTime.now();
  final EventList<Event> _markedDateMap = new EventList(events: {});

   


  //initState fills map with events
  @override
  void initState() {
    super.initState();
    List<DiaryEntryDTO>? allEntries = widget.userAccountDTO!.diary.entries;
    for(var entry in allEntries!){
      debugPrint("date: " + entry.date);
      var parsedDate = DateTime.parse(entry.date);

      _markedDateMap.add(
        parsedDate,
         Event(
          date: parsedDate,
          title: 'Entry',
          icon: const Icon(Icons.check_circle_outline, color: Themes.primaryColor)
        ));
    }

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
      //todayButtonColor: Themes.primaryColor,
      selectedDateTime: _currentDate,
      selectedDayButtonColor: Colors.yellow,
      markedDatesMap: _markedDateMap,
      markedDateShowIcon: true,
      showIconBehindDayText: true,
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

  //checks if the selected Date is correct. if yes, it navigates to the new netry view.
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
          builder: (BuildContext context) => NewEntryView(newEntryDate: selectedDate)
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