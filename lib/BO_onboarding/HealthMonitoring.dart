import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mintag_application/BO_onboarding/BO_loginScreen.dart';
import 'package:mintag_application/Reusable_Widgets/BO_Onboarding/BO_Header.dart';
import 'package:mintag_application/Reusable_Widgets/BO_Onboarding/BO_ProgressBar.dart';
import 'package:mintag_application/Reusable_Widgets/Themes.dart';
import 'package:mintag_application/Views/LoginScreen/LoginScreen.dart';


class HealthMonitoring extends StatelessWidget {
  const HealthMonitoring({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
            children: [
             
              Column(
                children: [
                  const Expanded(
                    flex: 3,
                    child:  SizedBox(
                      child: BO_Header(header: "Gesundheits-Monitoring.",subHeader: "Wie ging es dir in letzter Zeit? Ein Überblick über deine Gesamtbewertungen hilft dir, einen Überblick über dein allgemeines Wohlbefinden zu erhalten.",),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: SizedBox(
                      child: Image.asset("assets/img/undraw_Segment_analysis.png"),
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child: BO_ProgressBar(isFirstCircleSelected: false, isSecondCircleSelected: false, isThirdCircleSelected: true,),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 96.0),
                                  child: ElevatedButton(onPressed: ()=> navigateToLoginView(context), child: const Text("Fertig"), style: Themes.primaryButtonStyle,),
                                ),
                              )
                            ],
                          )
                        ],
                        
                      ),
                      
                    ),
                  )
                ],
              ),
               Positioned(
                right: 0,
                child: ClipRRect(
                  child: SizedBox(
                    height: 100,
                    child: Image.asset("assets/img/corner_img.PNG"),
                  ),
                ),
              ),
            ],
        ),
      ),
      
    ); 
  }
  void navigateToLoginView(BuildContext context) async{
    await finishOnboarding(); 
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const BO_LoginScreen()));
  }

  Future<void>finishOnboarding()async{
    final storage = FlutterSecureStorage();
    await storage.write(key: "onboardingFinished", value: "yes");
  }

}