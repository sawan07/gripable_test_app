import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gripable_test_app/assets/brand_colors.dart';
import 'package:gripable_test_app/auth_service.dart';
import 'package:gripable_test_app/screens/reps_view.dart';
import 'package:gripable_test_app/widgets/ProgressDialog.dart';
import 'package:gripable_test_app/widgets/buttons.dart';
import 'package:gripable_test_app/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  void showSnackBar(String title) {
    final snackbar = SnackBar(
      content: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
    );
    //ToDO: replace this
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  void loginUser() async {
    var connectivityResult =
    await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {
      showSnackBar('No internet connectivity!');
      return;
    }


    if (!emailController.text.contains('@')) {
      showSnackBar('Please enter a valid email address');
      return;
    }
    if (passwordController.text.length < 6) {
      showSnackBar(
          'Password needs to have at least 6 characters');
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) =>
          ProgressDialog(status: 'Logging in...'),);

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
      );
      User user = userCredential.user;

      if (user != null) {
        print('signed up');
        DatabaseReference newUserRef =
        FirebaseDatabase.instance.reference().child('users/${user.uid}');


        Navigator.push(
            context, MaterialPageRoute(builder: (context) =>
            RepsView()));

      }

    }on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showSnackBar('The account already exists for that email.');
      }
    } catch (e) {
      showSnackBar(e);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar('Login'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 70,),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        fontSize: 14.0,
                      ),
                      hintStyle:
                      TextStyle(color: Colors.grey, fontSize: 10.0)),
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        fontSize: 14.0,
                      ),
                      hintStyle:
                      TextStyle(color: Colors.grey, fontSize: 10.0)),
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 50),
                CustomAnimatedButton(
                  text: 'Login',
                  color: BrandColors.colorPrimary,
                  onPressed: () {
loginUser();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
