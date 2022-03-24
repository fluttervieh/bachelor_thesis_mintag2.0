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
    

}