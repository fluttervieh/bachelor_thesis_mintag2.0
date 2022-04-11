import 'package:flutter/material.dart';

class HeaderContainer extends StatelessWidget {

  final String header;
  final String subHeader;
  final String? optionalDescription;
  const HeaderContainer(
    {
     required this.header,
     required this.subHeader,
     this.optionalDescription,
     Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      shadowColor: Colors.black,
      color: Colors.white,
      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
      child: Stack(
        children: [ 
          Positioned(
            right: 0,
            child: ClipRRect(
              child: SizedBox(
                height: 100,
                child: Image.asset("assets/img/corner_img.PNG"),
              ),
            ),
          ),
          SizedBox(
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
                    optionalDescription==null? const SizedBox(height: 0,): const SizedBox(height: 12,),
                    optionalDescription==null? const SizedBox(height: 0,) : Text(optionalDescription!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xffa4a4a4) ),),

                ],
              ),
            ),
          ),
        ]
      ),
    );
  }
}