import 'package:flutter/material.dart';
import 'package:mintag_application/Database/ModelClasses/UserAccountDTO.dart';
import 'package:mintag_application/Reusable_Widgets/HeaderContainer.dart';

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
      body: Column(
        children: const[
          HeaderContainer(header: "Meine Bewertungen", subHeader: "Hier siehst die Bewertung aller Einträge, die du bis jetzt gemacht hast.")
        ],
      ),
    );
  }
}