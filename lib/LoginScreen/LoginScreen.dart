import 'package:flutter/material.dart';
import 'package:mintag_application/LoginScreen/GoogleSignInProvider.dart';
import 'package:provider/provider.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(
                flex: 1,
                child: SizedBox()
              ),
               Expanded(
                 flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text("Herzlich willkommen bei mintag!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                      SizedBox(height: 16),
                      Text("hier kannst du dich mit deinem Google-Account anmelden. Frage hierfür am besten deine Eltern oder Lehrer:In um Hilfe.", textAlign: TextAlign.center, style: TextStyle(color: Color(0xffc4c4c4), fontWeight: FontWeight.bold, fontSize: 14),),
                    ],
                  ),
                )
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Image.asset("assets/img/undraw_back_to_school_inwc.png"),
                )
              ),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 64),
                        child: GestureDetector(
                          onTap: () {
                             final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                              provider.googleLogin();
                          },
                          child: Container(
                            height: 48,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: const Color(0xffaadb12),
                            ),
                          
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const[
                                 Text("Anmelden", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),),
                              ],
                            )
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
      
            ],
          ),
        ),
      ),
    );
  }
}