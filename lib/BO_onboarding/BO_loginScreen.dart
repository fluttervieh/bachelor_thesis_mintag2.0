// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:mintag_application/Reusable_Widgets/Themes.dart';
import 'package:mintag_application/Views/LoginScreen/GoogleSignInProvider.dart';
import 'package:provider/provider.dart';

class BO_LoginScreen extends StatefulWidget {
  const BO_LoginScreen({ Key? key }) : super(key: key);

  @override
  State<BO_LoginScreen> createState() => _BO_LoginScreenState();
}

class _BO_LoginScreenState extends State<BO_LoginScreen> {

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false, 
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Image.asset("assets/img/bookshelf.jpg", fit: BoxFit.cover,),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Themes.primaryColor.withOpacity(0.55),
            ),
            Column(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.transparent,),
                ),
                SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 24.0, bottom: 32, left: 16, right: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Hat dich MinTag überzeugt?" ,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
                          const SizedBox(height: 16,),
                          const Text("Dann melde dich hier an und lege los!", style: TextStyle(color: Themes.secondaryTextColor, fontWeight: FontWeight.bold, fontSize: 16),),
                          const SizedBox(height: 32,),
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("E-Mail:", style: TextStyle(fontWeight: FontWeight.bold),),
                                TextFormField(
                                  controller: _emailController,
                                  decoration: const InputDecoration(
                                    icon: Icon(Icons.mail, color: Themes.primaryColor,),
                                   // border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide(color: Themes.primaryColor))
                                  ),
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return 'Bitte fülle dieses Feld aus';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16,),
                                const Text("Passwort:", style: TextStyle(fontWeight: FontWeight.bold),),
                                TextFormField(
                                  controller: _passwordController,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    icon: Icon(Icons.lock, color: Themes.primaryColor,),
                                    
                                  ),
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return 'Bitte fülle dieses Feld aus';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 32,),

                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 64.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                          ElevatedButton(
                                            style: Themes.primaryButtonStyle,
                                            onPressed: (){
                                              final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                                              provider.signIn(_emailController.text, _passwordController.text);
                                            },
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: const [
                                                Text("Anmelden")
                                              ],
                                            )
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.white,  
                                              side: const BorderSide(color: Themes.primaryColor,width: 2),
                                              shape: RoundedRectangleBorder( //to set border radius to button
                                                borderRadius: BorderRadius.circular(30)
                                              ),
                                            ),
                                            onPressed: (){
                                              final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                                              provider.googleLogin();
                                            }, child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children:  [
                                                  Image.asset("assets/img/google.png", height: 24,),
                                                  const SizedBox(width: 8),
                                                  const Text("Anmelden mit Google", style: TextStyle(color: Themes.primaryColor, fontWeight: FontWeight.bold),)
                                              ],
                                            )
                                          ),
                                          const SizedBox(height: 8,),
                                          GestureDetector(
                                            onTap: () {
                                              final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                                              provider.signUp(_emailController.text, _passwordController.text);
                                            }, 
                                            child: const Text("Registrieren" , style: TextStyle(color: Themes.primaryColor, fontWeight: FontWeight.bold),)),
                                            ],
                                          ),
                                )
                              ],
                            )
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),    
          ],
        ),
        ),
    );
  }
}