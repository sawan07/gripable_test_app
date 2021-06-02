import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gripable_test_app/screens/home_view.dart';
import 'package:gripable_test_app/widgets/buttons.dart';
import 'package:gripable_test_app/widgets/custom_app_bar.dart';
import 'package:gripable_test_app/assets/brand_colors.dart';


class RepsView extends StatefulWidget {
  const RepsView({Key key}) : super(key: key);

  @override
  _RepsViewState createState() => _RepsViewState();
}

class _RepsViewState extends State<RepsView> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('users').snapshots();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar('User List'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
              CustomAnimatedButton(
              text: 'Logout',
                color: Colors.red,
                onPressed: () {
                  logutUser();
                }),
              StreamBuilder<QuerySnapshot>(
                stream: _usersStream,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }

                  return new ListView(
                    children: snapshot.data.docs.map((DocumentSnapshot document) {
                      return new ListTile(
                        title: new Text(document.data()),
                        subtitle: new Text(document.data()),
                      );
                    }).toList(),
                  );
                },
              ),
                  CustomAnimatedButton(
                      text: 'Add Reps',
                      color: Colors.tealAccent,
                      onPressed: () {
                        logutUser();
                      }),
                ],

              ),
            ),
          ),
        ),
      ),
    );


  }

  void logutUser() async {
    await FirebaseAuth.instance.signOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) =>
        HomeView()));
  }
}
