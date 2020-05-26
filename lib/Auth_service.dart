import 'package:firebase_auth/firebase_auth.dart';
import 'package:lwk/Database_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<FirebaseUser> get user{
    return _auth.onAuthStateChanged;
  }

  Future signIn(String email, String password) async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    }catch (e){
      print(e.toString());
      return null;
    }
  }

  Future register(String email, String password) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      await DatabaseService(uid: user.uid).updateUserData(100.00, 10, [], [],'No username');
      return user;
    }catch (e){
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try{
      print('Signedout');
      return await _auth.signOut();
    }catch (e){
      print(e.toString());
      return null;
    }
  }


}