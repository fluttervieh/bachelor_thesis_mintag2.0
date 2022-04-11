import 'package:flutter/material.dart';

class Themes{

    static final primaryButtonStyle = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder( //to set border radius to button
        borderRadius: BorderRadius.circular(30)),
    );

    static final secondaryButtonStyle = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder( //to set border radius to button
        borderRadius: BorderRadius.circular(30)),
      primary: const  Color(0xffE06031)
    );

    static final primaryButtonContrastStyle = ElevatedButton.styleFrom(
      primary: Colors.white,
      side: const BorderSide(color: primaryColor, width: 2),
      shape: RoundedRectangleBorder( //to set border radius to button
        borderRadius: BorderRadius.circular(30)),
    );

    static const Color primaryColor =  Color(0xff0c947b);

    static const Color secondaryColor = Color(0xffe06031);

    static const Color secondaryTextColor = Color(0xffa4a4a4);
    

}