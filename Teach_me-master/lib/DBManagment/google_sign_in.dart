






//
// Future<void> signInWithGoogle(SignInViewModel model) async {
//   model.state =ViewState.Busy;
//   GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
//   GoogleSignInAuthentication googleSignInAuthentication =
//   await googleSignInAccount.authentication;
//   AuthCredential credential = GoogleAuthProvider.getCredential(
//     accessToken: googleSignInAuthentication.accessToken,
//     idToken: googleSignInAuthentication.idToken,
//   );
//   AuthResult authResult = await _auth.signInWithCredential(credential);
//   _user = authResult.user;
//   assert(!_user.isAnonymous);
//   assert(await _user.getIdToken() != null);
//   FirebaseUser currentUser = await _auth.currentUser();
//   assert(_user.uid == currentUser.uid);
//   model.state =ViewState.Idle;
//   print("User Name: ${_user.displayName}");
//   print("User Email ${_user.email}");
// }