import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'main_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  Duration get loadingTime => const Duration(milliseconds: 2000);

  Future<String?> _authUser(LoginData data) async {
    return Future.delayed(loadingTime).then(
      (value) async {
        try {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: data.name,
            password: data.password,
          );
          return null;
        } catch (e) {
          return e.toString();
        }
      },
    );
  }

  Future<String?> _signupUser(SignupData data) async {
    return Future.delayed(loadingTime).then(
      (value) async {
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: data.name!,
            password: data.password!,
          );
          return null;
        } catch (e) {
          return e.toString();
        }
      },
    );
  }

  Future<String?> _recoverPassword(String data) async {
    return Future.delayed(loadingTime).then(
      (value) async {
        try {
          await FirebaseAuth.instance.sendPasswordResetEmail(email: data);
          return null;
        } catch (e) {
          return e.toString();
        }
      },
    );
  }

  Future<void> _handleGoogleSignIn(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId:
          '567556118089-j8op1s8a6mh9o5t3ipe1jdntu5pbej4g.apps.googleusercontent.com',
    );

    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        return;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const MainPage(),
      ));
    } catch (e) {
      print(e);
    }
  }

  void _onLoginSuccess(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const MainPage(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterLogin(
          onLogin: (loginData) => _authUser(loginData).then((value) {
                if (value == null) {
                  _onLoginSuccess(context);
                }
                return value;
              }),
          onRecoverPassword: _recoverPassword,
          onSignup: (signupData) => _signupUser(signupData).then((value) {
                if (value == null) {
                  _onLoginSuccess(context);
                }
                return value;
              }),
          loginAfterSignUp: true,
          additionalSignupFields: const [],
          messages: LoginMessages(
            userHint: 'Email',
            passwordHint: 'Password',
            confirmPasswordHint: 'Confirm',
            loginButton: 'LOGIN',
            signupButton: 'SIGN UP',
            forgotPasswordButton: 'Forgot Password?',
            recoverPasswordButton: 'RECOVER',
            recoverPasswordIntro: 'Recover your password',
            recoverPasswordDescription:
                'We will send you instructions to recover your password',
          ),
          onSubmitAnimationCompleted: () {},
          headerWidget: IconButton(
            icon: Image.asset(
              'lib/icon/google_icon.png',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            onPressed: () => _handleGoogleSignIn(context),
          )),
    );
  }
}
