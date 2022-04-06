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

    debugPrint("[---user---]" + user.email);

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );



    debugPrint(credential.accessToken);

    UserCredential u =  await FirebaseAuth.instance.signInWithCredential(credential);
    if (u.additionalUserInfo!.isNewUser){
      print("[---NEW USER");

    }else{
      print("[---NO NEW USER AMK");
      print(u.additionalUserInfo!.username);
    }

    print("[---firebaseUID---]" + FirebaseAuth.instance.currentUser!.uid);
    await _storage.write(key: "firebaseUid", value: FirebaseAuth.instance.currentUser!.uid);


    notifyListeners();

  }

  Future googleLogout() async {
     googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();

  }


}