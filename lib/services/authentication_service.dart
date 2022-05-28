import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:final_year_project/screens/otp_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_year_project/screens/registration_screen.dart';

class AuthenticationService{
  final FirebaseAuth _firebaseAuth;
  final _fireStore = FirebaseFirestore.instance;

  AuthenticationService(this._firebaseAuth);

  /// Changed to idTokenChanges as it updates depending on more cases.
  get firestore => _fireStore;
  Stream<User?> get authStateChanges => _firebaseAuth.idTokenChanges();

  /// This won't pop routes so you could do something like
  /// Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  /// after you called this method if you want to pop all routes.
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
  ///

  Future<bool?> signIn({String? phoneNumber, var context}) async {
    bool signedIn = false;

    await _firebaseAuth.verifyPhoneNumber(
      timeout: const Duration(seconds: 120),
      phoneNumber: phoneNumber!,
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
        User? user;
        bool error = false;
        try {
          user = (await FirebaseAuth.instance
                  .signInWithCredential(phoneAuthCredential))
              .user!;
        } catch (e) {
          print("Failed to sign in: " + e.toString());
          error = true;
        }
        if (!error && user != null) {
          String id = user.uid;
          // _fireStore.collection('userdata').add({
          //   'uid' : id,
          // });

          _fireStore
              .doc('userdata/${id}')
              .set({'id': id, 'phone': phoneNumber});
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const RegistrationScreen()));
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        print('failed');
      },
      codeSent: (String verificationId, int? resendToken) async {
        final result = Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpScreen(
                phoneNumber: phoneNumber,
                verificationId: verificationId,
              ),
            ));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print('Timeout ayi myre');
      },
    );
  }

  Future<bool?> verifyOtp(
      {String? pin,
      String? verificationId,
      String? phoneNumber,
      var context}) async {
    UserCredential userCredential;

    try {
      // print(pin);
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId!, smsCode: pin!);

      userCredential = await _firebaseAuth.signInWithCredential(credential);
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text('Success')));
      print('kunna  Ran !!!!!!!!!!!!!!!ran');

      if (userCredential != null) {
        String? id = userCredential.user?.uid;
        await _fireStore
            .doc('userdata/$id')
            .set({'id': id, 'phone': phoneNumber});

        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(const SnackBar(content: Text('Success2')));
        return false;
      }
    } catch (e) {
      print('Error  Ran !!!!!!!!!!!!!!!ran');
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text('Invalid OTP')));
      print(e);
      return true;
    }
  }

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
}
