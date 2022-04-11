import 'package:flutter/material.dart';
import 'package:mintag_application/BO_Onboarding/SelfReflection.dart';
import 'package:mintag_application/Reusable_Widgets/Themes.dart';

// ignore: camel_case_types
class BO_StartScreen extends StatelessWidget {
  const BO_StartScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.primaryColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:  [

              Expanded(
                flex: 4,
                child: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 60.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Text("Herzlich willkommen bei", style:  TextStyle(color: Colors.white, fontSize: 16),),
                        Text("MinTag", style:  TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),),
                        Text("deinem persönlichen Tagebuch.", style:  TextStyle(color: Colors.white, fontSize: 16),),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 48.0, horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Bist du bereit zu erfahren, was MinTag alles zu bieten hat? :)",textAlign: TextAlign.center, style:  TextStyle(color: Colors.white, fontSize: 16),),
                        const SizedBox(height: 32),
                        Row(
                          children: [
                            Expanded(child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 60.0),
                              child: ElevatedButton(
                                onPressed: (){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const SelfReflection()));

                                  // Navigator.of(context).push( PageRouteBuilder(
                                  //   pageBuilder: (c, a1, a2) => const SelfReflection(),
                                  //   transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                  //   transitionDuration: const Duration(milliseconds: 1000),
                                  //   ),
                                  // );
                                },
                                style: Themes.primaryButtonContrastStyle, child: const Text("Na klar!", style:  TextStyle(color: Themes.primaryColor, fontSize: 16),)),
                            )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
              

              
          ],
        ),
      ),
      
    );

  
  }
}