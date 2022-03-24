import 'package:flutter/material.dart';
import 'package:mintag_application/Database/ModelClasses/UserAccountDTO.dart';
import 'package:mintag_application/Reusable_Widgets/HeaderContainer.dart';
import 'package:mintag_application/Reusable_Widgets/Themes.dart';

class MyRatingsView extends StatefulWidget {

    final UserAccountDTO userAccountDTO;

  const MyRatingsView({required this.userAccountDTO, Key? key }) : super(key: key);

  @override
  State<MyRatingsView> createState() => _MyRatingsViewState();
}

class _MyRatingsViewState extends State<MyRatingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: const[
            HeaderContainer(header: "Meine Bewertungen", subHeader: "Hier siehst die Bewertung aller Einträge, die du bis jetzt gemacht hast.")
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