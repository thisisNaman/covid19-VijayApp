import 'dart:convert';

import 'package:covid_vijay_app/screens/admin.dart';
import 'package:covid_vijay_app/screens/onboarding.dart';
import 'package:covid_vijay_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class AdminLogin extends StatefulWidget {
  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  Map<String, double> dataMap;
  double vaccinated = 0;
  double notvaccinated = 0;
  final _key = GlobalKey<FormState>();
  TextEditingController _textEditingController;
  String email;
  String password;
  bool credentialTrue = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [g1, g2])),
        ),
        ListView(children: [
          Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(30.0)),
            child: Image(
              image: AssetImage('assets/images/admin.png'),
            ),
          ),
          Form(
            key: _key,
            child: Column(children: [
              Center(
                child: Chip(
                  padding: EdgeInsets.all(8.0),
                  backgroundColor: Colors.transparent,
                  label: Text('Admin Login'),
                  labelStyle: GoogleFonts.varelaRound(
                      color: Colors.purple,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold),
                  avatar: Image.asset('assets/img/key.png'),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 5, 20, 0),
                decoration: BoxDecoration(
                    border: Border.all(width: 2.0, color: Colors.white24),
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(20.0)),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  controller: _textEditingController,
                  onChanged: (val) {
                    email = val;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Image.asset('assets/img/user.png'),
                    labelText: 'Email',
                    labelStyle: GoogleFonts.varelaRound(
                      color: Colors.white,
                    ),
                  ),
                  cursorColor: Colors.white,
                  cursorWidth: 2.0,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 5, 20, 0),
                decoration: BoxDecoration(
                    border: Border.all(width: 2.0, color: Colors.white24),
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(20.0)),
                child: TextFormField(
                  controller: _textEditingController,
                  onChanged: (val) {
                    password = val;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Image.asset('assets/img/lock.png'),
                    labelText: 'Password',
                    labelStyle: GoogleFonts.varelaRound(
                      color: Colors.white,
                    ),
                  ),
                  obscureText: true,
                  cursorColor: Colors.white,
                  cursorWidth: 2.0,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                  onTap: () async {
                    _key.currentState.save();
                    _key.currentState.validate();
                    dynamic user = await Authentication()
                        .signIn(email: email, password: password);

                    if (user == null)
                      setState(() {
                        credentialTrue = false;
                      });
                    if (credentialTrue == false)
                      Text(
                        "Wrong username or password",
                        style: TextStyle(color: Colors.red),
                      );
                    if (_key.currentState.validate()) {
                      var url = 'https://covid19-vaccine.herokuapp.com/api/';
                      final response = await http.get(url);

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
                            builder: (context) => Admin(),
                          ));
                    }
                  },
                  child: Container(
                    width: 350,
                    height: 60,
                    margin: EdgeInsets.fromLTRB(20, 5, 20, 15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 2.0, color: Colors.greenAccent),
                            color: Colors.greenAccent,
                            borderRadius: BorderRadius.circular(20.0)),
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Login',
                              style: GoogleFonts.varelaRound(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                          ],
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        height: 80,
                      ),
                    ),
                  )),
              Container(
                margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                width: double.maxFinite,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  textBaseline: TextBaseline.alphabetic,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Hero(
                      tag: "back_next",
                      child: IconButton(
                          padding: EdgeInsets.all(5),
                          color: Colors.white,
                          splashColor: Color(0xff02AE8B),
                          iconSize: 30,
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Onboarding(),
                                ));
                          }),
                    ),
                    Text(
                      "Not Admin?",
                      style: GoogleFonts.varelaRound(
                          fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ]),
      ]),
    );
  }
}
