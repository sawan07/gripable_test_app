import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gripable_test_app/auth_service.dart';
import 'package:gripable_test_app/screens/home_view.dart';
import 'package:gripable_test_app/screens/login_view.dart';
import 'package:gripable_test_app/screens/registration_view.dart';
import 'package:gripable_test_app/screens/reps_view.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider(
              create: (_)=> AuthenticationService(FirebaseAuth.instance)
          ),
          StreamProvider(
              create: (context) => context.read<AuthenticationService>().authStateChanges,
          )
        ],
    child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: AuthenticationWrapper(),
    ),);
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if(firebaseUser == null){
      return HomeView();
    }
    return RepsView();
  }
}

