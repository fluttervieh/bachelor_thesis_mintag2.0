import 'package:flutter/cupertino.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;
  final _storage = const FlutterSecureStorage();


  GoogleSignInAccount get user => _user!;

  Future googleLogin() async{
    final googleUser = await googleSignIn.signIn();
    if(googleUser == null) return;

    _user = googleUser;

    //debugPrint("[---user---]" + user.email);

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );


    await FirebaseAuth.instance.signInWithCredential(credential);
        notifyListeners();
        
  }
  
  Future<User?> signUp(String email, String password)async{
    try{
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      assert(userCredential.user!=null);
      assert(await userCredential.user!.getIdToken() != null);
      notifyListeners();
      return userCredential.user;
    }catch (e){
      print(e);
      return null;
    }
  }

   Future<User?> signIn(String email, String password)async{
    try{
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      assert(userCredential.user != null);
      assert(await userCredential.user!.getIdToken() != null);
      final User currentUser =  FirebaseAuth.instance.currentUser!;
      assert(userCredential.user!.uid == currentUser.uid);
      notifyListeners();
      return userCredential.user;

      
    }catch (e){
      print(e);
      return null;
    }
  }



}