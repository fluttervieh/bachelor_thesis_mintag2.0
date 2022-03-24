import 'package:flutter/material.dart';
import 'package:mintag_application/Database/ModelClasses/UserAccountDTO.dart';
import 'package:mintag_application/Reusable_Widgets/HeaderContainer.dart';

class ThankfulMomentsView extends StatefulWidget {

  final UserAccountDTO userAccountDTO;

  const ThankfulMomentsView({ required this.userAccountDTO, Key? key }) : super(key: key);

  @override
  State<ThankfulMomentsView> createState() => _ThankfulMomentsViewState();
}

class _ThankfulMomentsViewState extends State<ThankfulMomentsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const  [
          HeaderContainer(header: "Dankbare Momente", subHeader: "Hier werden Situationen angegeben, für die du in letzter Zeit besonders dankbar warst.")
        ],
      )
    );
  }
}