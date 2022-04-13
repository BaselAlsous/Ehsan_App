// ignore_for_file: file_names, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart'as auth;
import 'User-Model.dart';


// ignore: prefer_typing_uninitialized_variables
class AuthService {

final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

User? _userFromFirebase(auth.User? user){
  if(user == null){
    return null ;
  }

  return User(user.uid , user.email);
}

Stream<User?>? get user {
  return _firebaseAuth.authStateChanges().map(_userFromFirebase);
}



Future<void> signOut()async{
  return await _firebaseAuth.signOut();
}

Future <User?> creatUserWithEmailAndPassword(String email , String password) async {
    final Credential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  return _userFromFirebase(Credential.user);

}

//  void deleteuseraccount(String email,String pass) async{

//     auth.AuthCredential credential = auth.EmailAuthProvider.credential(email: email, password: pass);

//     await _firebaseAuth.currentUser?.reauthenticateWithCredential(credential).then((value) {
//       value.user?.delete();
//     }

//     );
//   }

}


