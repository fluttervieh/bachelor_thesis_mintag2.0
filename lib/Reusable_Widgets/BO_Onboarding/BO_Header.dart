import 'package:flutter/material.dart';

class BO_Header extends StatelessWidget {

  final String header;
  final String subHeader;
  const BO_Header({
    required this.header,
    required this.subHeader,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32, left: 16, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(header, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text(subHeader, style: const  TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}