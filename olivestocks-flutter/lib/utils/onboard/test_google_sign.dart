// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class GoogleSignInButton extends StatelessWidget {
//
//   // Future<UserCredential> signInWithGoogle() async {
//   //   // Trigger the authentication flow
//   //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//   //
//   //   // Obtain the auth details from the request
//   //   final GoogleSignInAuthentication? googleAuth =
//   //   await googleUser?.authentication;
//   //
//   //   // Create a new credential
//   //   final credential = GoogleAuthProvider.credential(
//   //     accessToken: googleAuth?.accessToken,
//   //     idToken: googleAuth?.idToken,
//   //   );
//   //
//   //   // Once signed in, return the UserCredential
//   //   return await FirebaseAuth.instance.signInWithCredential(credential);
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(git commit -m "Initial commit"
//       onPressed: () async {
//         try {
//           //await signInWithGoogle();
//           // Successfully signed in
//         } catch (error) {
//           print('Error signing in with Google: $error');
//         }
//       },
//       child: const Text('Sign in with Google'),
//     );
//   }
// }