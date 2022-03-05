// ignore: file_names
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class OverviewScreen extends StatefulWidget {

  const OverviewScreen(
    {
     Key? key }) 
     : super( key: key);

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  
  @override
  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser!;
    final String? userName = user.displayName.toString();

    debugPrint("[---username---]" + userName!);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
             Text("Willkommen, " + userName),
             const ElevatedButton(onPressed: null, child: Text("logout"))
          ],
        ),
      )
      );
    
  }
}