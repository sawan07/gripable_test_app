
import 'package:flutter/material.dart';
import 'package:gripable_test_app/assets/brand_colors.dart';
import 'package:gripable_test_app/screens/registration_view.dart';
import 'package:gripable_test_app/widgets/buttons.dart';
import 'package:gripable_test_app/widgets/custom_app_bar.dart';

import 'login_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('Reps Counter'),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomAnimatedButton(
                text: 'Login',
              color: BrandColors.colorPrimary,
              onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                      LoginPage()));
              },),
              SizedBox(height: 20,),
              CustomAnimatedButton(
                text: 'Registration',
                color: BrandColors.colorSecondary,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                      RegistrationPage()));
                },)
            ],
          ),
        ),
      ),
    );
  }
}
