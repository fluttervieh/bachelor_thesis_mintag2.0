import 'package:flutter/material.dart';
import 'package:mintag_application/BO_onboarding/SelfReflection.dart';
import 'package:mintag_application/BO_onboarding/Upcheering.dart';
import 'package:mintag_application/Reusable_Widgets/BO_Onboarding/BO_Header.dart';
import 'package:mintag_application/Reusable_Widgets/BO_Onboarding/BO_ProgressBar.dart';
import 'package:mintag_application/Reusable_Widgets/Themes.dart';

class SelfReflection extends StatelessWidget {
  const SelfReflection({ Key? key }) : super(key: key);

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
                      child: BO_Header(header: "Blick in den Spiegel.",subHeader: "MinTag unterstützt dich dabei, deinen Tag zu revue passieren zu lassen und deine Gedanken zu organisieren.",),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: SizedBox(
                      child: Image.asset("assets/img/undraw_Diary.png"),
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child: BO_ProgressBar(isFirstCircleSelected: true, isSecondCircleSelected: false, isThirdCircleSelected: false,),
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
                                  child: ElevatedButton(onPressed: ()=> navigateToUpCheeringView(context), child: const Text("Weiter"), style: Themes.primaryButtonStyle,),
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
}

void navigateToUpCheeringView(BuildContext context){
  //  Navigator.of(context).push( PageRouteBuilder(
  //   pageBuilder: (c, a1, a2) => const Upcheering(),
  //   transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
  //   transitionDuration: const Duration(milliseconds: 1000),
  //   ),
  //);
      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => const Upcheering()));

}



