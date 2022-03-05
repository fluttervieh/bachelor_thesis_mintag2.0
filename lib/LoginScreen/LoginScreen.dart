import 'package:flutter/material.dart';
import 'package:mintag_application/LoginScreen/GoogleSignInProvider.dart';
import 'package:provider/provider.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black12,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Herzlich willkommen bei mintag!", style: TextStyle(fontWeight: FontWeight.bold),),
            ElevatedButton(onPressed: (){
              final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.googleLogin();
              
            }, child: const Text("Anmelden"))

          ],
        ),
      ),
    );
  }
}