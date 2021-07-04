import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/screens/home.dart';
import 'package:project/screens/login.dart';
import 'package:project/services/getImage.dart';
import 'package:project/widgets/snackbar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Auth {
  checkStatus() {
    FirebaseAuth auth = FirebaseAuth.instance;

    return StreamBuilder(
      stream: auth.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          print('User is signed in!');
          return Home();
        } else {
          print('User is currently signed out!');
          return Login();
        }
      },
    );
  }

  login(email, pass, context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        showSnackbar('No user found for that email.', context);
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        showSnackbar('Wrong password provided for that user.', context);
      }
    }
  }

  logout(context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
    showSnackbar('Logged out Successfully', context);
  }

  googleLogIn(context) async {
    final GoogleSignInAccount googleUser =
        await GoogleSignIn(signInOption: SignInOption.standard).signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        // handle the error here
        showSnackbar('Your account exists with different credential', context);
      } else if (e.code == 'invalid-credential') {
        // handle the error here
        showSnackbar(
            'Error occurred while accessing credentials. Try again.', context);
      }
    } catch (e) {
      showSnackbar('Error occurred using Google Sign-In. Try again.', context);
    }
  }

  forgotPassword(context, email) {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    showSnackbar('Check your mail to reset your password.', context);
    Navigator.of(context).pop();
  }

  signUp(email, pass, name, phone, image, context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass)
          .whenComplete(() {
        showSnackbar('Signed Up successfully', context);
      });
      await uploadImage(email, image);
      String profilepic;
      User user = userCredential.user;
      await user.reload();
      await firebase_storage.FirebaseStorage.instance
          .ref('$email/profile')
          .getDownloadURL()
          .then((value) {
        profilepic = value;
      });
      user.updateProfile(
        displayName: name,
        photoURL: profilepic.toString(),
      );
      await user.reload();

      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackbar('The password provided is too weak.', context);
      } else if (e.code == 'email-already-in-use') {
        showSnackbar('The account already exists for that email.', context);
      }
    } catch (e) {
      print(e);
      showSnackbar('$e', context);
    }
  }
}
