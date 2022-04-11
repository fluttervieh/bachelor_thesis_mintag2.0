import 'package:flutter/material.dart';
import 'package:mintag_application/BO_Onboarding/HealthMonitoring.dart';
import 'package:mintag_application/Reusable_Widgets/BO_Onboarding/BO_Header.dart';
import 'package:mintag_application/Reusable_Widgets/BO_Onboarding/BO_ProgressBar.dart';
import 'package:mintag_application/Reusable_Widgets/Themes.dart';

class Upcheering extends StatelessWidget {
  const Upcheering({ Key? key }) : super(key: key);

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
                      child: BO_Header(header: "Aufheiterung.",subHeader: "Jeder hat einmal einen schlechten Tag, an dem einfach alles doof ist. Durch Erinnerungen an besonders schöne Momente im Leben können die Regenwolken gelichtet werden.",),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: SizedBox(
                      child: Image.asset("assets/img/undraw_moments.png"),
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child: BO_ProgressBar(isFirstCircleSelected: false, isSecondCircleSelected: true, isThirdCircleSelected: false,),
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
                                  child: ElevatedButton(onPressed: ()=> navigateToHealthMonitoringView(context), child: const Text("Weiter"), style: Themes.primaryButtonStyle,),
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
  void navigateToHealthMonitoringView(BuildContext context){
    Navigator.of(context).push( PageRouteBuilder(
      pageBuilder: (c, a1, a2) => const HealthMonitoring(),
      transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
      transitionDuration: const Duration(milliseconds: 1000),
      ),
    );
}

}