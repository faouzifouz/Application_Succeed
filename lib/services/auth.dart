import 'package:firebase_auth/firebase_auth.dart'; // Authentication Firebase
import 'package:google_sign_in/google_sign_in.dart'; // Connection with Google
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore DB 
import 'dart:async';

class AuthService {
  // JE N'ARRIVE PAS A UPDATE CORRECTEMENT CE BOUT DE CODE.
  // LE COMPTE GOOGLE FONCTIONNE, ON PEUT SE CONNECTER
  // MAIS L'USER RESTE NULL DU COUP IMPOSSIBLE D'ENTRER DANS L'APP
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  
  Future<FirebaseUser> get getUser => _auth.currentUser();
  
  Stream<FirebaseUser> get user => _auth.onAuthStateChanged;

  Future<FirebaseUser> googleSignIn() async { // Google function
  // Connection with Google's account
    try {
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
      updateUserData(user);
      return user;
    } catch (error) { // if any error, show an error message
      print('Authentication error : ' + error);
      return null;
    }
  }

  Future<FirebaseUser> anonLogin() async { // Anonymous function
    // I made this connection possible to make test but I don't think it will be in the app at the end.
    FirebaseUser user = (await _auth.signInAnonymously()).user;
    updateUserData(user);
    return user;
    }

  Future<void> updateUserData(FirebaseUser user) { // Function for update all user's data
    DocumentReference reportRef = _db.collection('reports').document(user.uid);

    return reportRef.setData({
      'uid': user.uid,
      'lastActivity': DateTime.now()
    }, merge: true); // IMPORTANT DON'T TOUCH merge: true
  }

  Future<void> signOut() {
    return _auth.signOut();
  }
}