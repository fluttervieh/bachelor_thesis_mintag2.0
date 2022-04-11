import 'package:flutter/material.dart';
import 'package:mintag_application/Reusable_Widgets/Themes.dart';

class BO_ProgressBar extends StatelessWidget {
  final bool isFirstCircleSelected;
  final bool isSecondCircleSelected;
  final bool isThirdCircleSelected;

  const BO_ProgressBar({
    required this.isFirstCircleSelected,
    required this.isSecondCircleSelected,
    required this.isThirdCircleSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 20,
                width: 20,
                decoration:  BoxDecoration(
                  shape: BoxShape.circle,
                  color: isFirstCircleSelected? Themes.primaryColor : Themes.secondaryTextColor,
                ),
              ),
              const SizedBox(width: 12,),
              Container(
                height: 20,
                width: 20,
                decoration:  BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSecondCircleSelected? Themes.primaryColor : Themes.secondaryTextColor
                ),
              ),
              const SizedBox(width: 12,),

              Container(
                height: 20,
                width: 20,
                decoration:  BoxDecoration(
                  shape: BoxShape.circle,
                  color: isThirdCircleSelected? Themes.primaryColor : Themes.secondaryTextColor
                ),
              ),

            ],
          )
        ],
      ),
    );
  }
}