import 'dart:ffi';

import 'package:covid_vijay_app/screens/admin_login.dart';
import 'package:covid_vijay_app/services/auth.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class AdminDashboard extends StatefulWidget {
  final Map<String, double> dataMap;
  AdminDashboard({this.dataMap});
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Colors.white,
          elevation: 0,
          flexibleSpace: Container(
            margin: EdgeInsets.all(9.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[g1, g2])),
          ),
          
          title: Text('Admin Dashboard'),
          centerTitle: true,
          actions: [
            IconButton(
              padding: EdgeInsets.all(22.0),
              icon: Icon(Icons.logout),
              onPressed: () async {
                await Authentication().signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminLogin(),
                    ),
                    (route) => false);
              },
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: Container(
          constraints: BoxConstraints.expand(),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hey👋',
                      style: GoogleFonts.varelaRound(
                          foreground: Paint()..shader = linearGradient,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Looks like a lot of people are getting vaccinated',
                      style: GoogleFonts.varelaRound(
                          foreground: Paint()..shader = linearGradient,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width - 20,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            stops: [0.1, 0.5, 0.7, 0.9],
                            colors: [
                              Colors.red[800],
                              Colors.red[700],
                              Colors.red[600],
                              Colors.red[400],
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(color: Colors.black26, blurRadius: 20.0)
                          ],
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Vaccines available Per Day ',
                            style: TextStyle(
                                color: Colors.red[100],
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            '500',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width - 20,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            stops: [0.1, 0.5, 0.7, 0.9],
                            colors: [
                              Colors.teal[800],
                              Colors.teal[700],
                              Colors.teal[600],
                              Colors.teal[400],
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(color: Colors.black26, blurRadius: 20.0)
                          ],
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Area Details:',
                            style: TextStyle(
                                color: Colors.teal[100],
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Delhi',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
