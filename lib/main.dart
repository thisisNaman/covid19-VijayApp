import 'package:covid_vijay_app/screens/onboarding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/check_status.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid19-Vijay-App',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: 
       Onboarding(),
      debugShowCheckedModeBanner: false,
      routes: {
        DisplayVaccinationStatus.routeName: (context)=>DisplayVaccinationStatus(),
      },
    );
  }
}
