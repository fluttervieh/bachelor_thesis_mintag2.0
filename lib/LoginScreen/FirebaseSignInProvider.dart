import 'package:firebase_auth/firebase_auth.dart';


class FirebaseSignInProvider{

  Future<User?> signUp(String email, String password)async{
    try{
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      assert(userCredential.user!=null);
      assert(await userCredential.user!.getIdToken() != null);
      return userCredential.user;
    }catch (e){
      print(e);
      return null;
    }
  }
}