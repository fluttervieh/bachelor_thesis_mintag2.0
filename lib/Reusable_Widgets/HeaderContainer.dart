import 'package:flutter/material.dart';

class HeaderContainer extends StatelessWidget {

  final String header;
  final String subHeader;
  const HeaderContainer({
     required this.header,
     required this.subHeader,
     Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      shadowColor: Colors.black,
      color: Colors.white,
      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
      child: SizedBox(
        height: 200,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Text(header, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),
                const SizedBox(height: 24,),
                Text(subHeader, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
            ],
          ),
        ),
      ),
    );
  }
}