import 'dart:convert';
import 'package:covid_vijay_app/screens/admin_login.dart';
import 'package:covid_vijay_app/screens/user_home.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:http/http.dart' as http;

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  Map<String, double> dataMap;
   double vaccinated=0;
 double notvaccinated=0;
 bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Plasma(
          particles: 10,
          foregroundColor: Color(0x66e50ba4),
          backgroundColor: Color(0xff0a56cd),
          size: 1.00,
          speed: 6.00,
          offset: 0.00,
          blendMode: BlendMode.colorDodge,
        ),
        Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10.0, left: 5.0, right: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image(
                      image: AssetImage("assets/images/covid_vaccine.png"),
                    ),
                  ),
                ),


                Center(
                    child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('The', style: heading),
                      SizedBox(
                        width: 10.0,
                      ),
                      Chip(
                        backgroundColor: Colors.transparent,
                        label: Text('Vaccination Programme'),
                        labelStyle: GoogleFonts.varelaRound(
                          color: Colors.green,
                          fontSize: 15.0,
                        ),
                        avatar: Image.asset('assets/img/vaccine.png'),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text('for', style: heading),
                    ],
                  ),
                )),
                Center(
                    child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Chip(
                      backgroundColor: Colors.transparent,
                      label: Text('COVID 19'),
                      labelStyle: GoogleFonts.varelaRound(
                          color: Colors.red,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold),
                      avatar: Image.asset('assets/img/covid.png'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'is here',
                      style: GoogleFonts.varelaRound(
                          fontSize: 30.0, color: Colors.red),
                    ),
                  ],
                )),
                SizedBox(
                  height: 5,
                ),
                Center(
                    child: Text('we will help you to get vaccinated safely',
                        style: subhead)),
                new SizedBox(
                  height: 20,
                ),
                new InkWell(
                  focusColor: Colors.white,
                  hoverColor: Colors.white,
                  splashColor: Colors.white,
                  onTap: () async{
                    try {
                      var url = 'http://192.168.1.6:8000/api';
                      setState(() {
                        _loading = true;
                      });
                      String username = 'admin',
                          password = 'admin';
                      String basicAuth =
                          'Basic ' +
                              base64Encode(utf8.encode('$username:$password'));

                      final response = await http.get(
                          url, headers: {'authorization': basicAuth});
                      List Data = json.decode(response.body);
                      for (int i = 0; i < Data.length; i++) {
                        if (Data[i]["isVaccinated"]) vaccinated++;
                        if (!Data[i]["isVaccinated"]) notvaccinated++;
                      }
                      setState(() {
                        dataMap = {
                          "vaccinated": vaccinated,
                          "notvaccinated": notvaccinated,
                        };
                      });
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                UserHome(dataMap: {
                                  "vaccinated": vaccinated,
                                  "notvaccinated": notvaccinated,
                                })

                        ),

                      );
                      setState(() {
                        _loading = false;
                      });
                    }catch(e) {
                      _showAlert(context, e.toString());
                      setState(() {
                        _loading = false;
                      });
                    }
                  },
                  child: new Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 2.0, color: Colors.greenAccent),
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(20.0)),
                    padding: EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Get Started',
                          style: GoogleFonts.varelaRound(
                              color: Colors.greenAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 30.0),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Icon(
                          Icons.forward,
                          color: Colors.greenAccent,
                          size: 40.0,
                        )
                      ],
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    height: 80,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                    child: Text(
                  'OR',
                  style: GoogleFonts.varelaRound(color: Colors.greenAccent),
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Log in as',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdminLogin(),
                          )),
                      child: Chip(
                        backgroundColor: Colors.transparent,
                        label: Text('Admin'),
                        labelStyle: GoogleFonts.varelaRound(
                            color: Colors.black,
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold),
                        avatar: Icon(Icons.satellite),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                _loading?SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.yellow),
                  ),
                ):Text(''),
              ],
            ),
          ),


        ),
      ]),
    );
  }
}
void _showAlert(BuildContext context, String text) {
  showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            height: 500,
            child: Column(
              children: [
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                        text,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            ),
          ),
        );
      });
}
