import 'package:flutter/material.dart';
import 'package:mintag_application/Database/ModelClasses/UserAccountDTO.dart';

class MyDiaryView extends StatefulWidget {

  final UserAccountDTO? userAccountDTO;

  const MyDiaryView({required this.userAccountDTO, Key? key }) : super(key: key);

  
  @override
  State<MyDiaryView> createState() => _MyDiaryViewState();
}

class _MyDiaryViewState extends State<MyDiaryView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(child: const Text("back"), onPressed: ()=> Navigator.of(context).pop(),),
    );
  }
}