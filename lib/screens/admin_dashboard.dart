import 'package:covid_vijay_app/screens/admin_login.dart';
import 'package:covid_vijay_app/constants.dart';
import 'package:covid_vijay_app/screens/onboarding.dart';
import 'package:covid_vijay_app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdminDashboard extends StatefulWidget {
  Map<String, double> dataMap;
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff02AE8B),
        elevation: 0,
        title: Text('Admin Dashboard'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)),
                        height: MediaQuery.of(context).size.height / 2,
                        width: double.infinity,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                'Add the person who got vaccinated',
                                style: GoogleFonts.varelaRound(
                                    foreground: Paint()
                                      ..shader = linearGradient,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              height: 125,
                              width: 125,
                              child: CircleAvatar(
                                child: Image.asset('assets/images/aadhar.png'),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(20, 5, 20, 0),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 2.0, color: Colors.orange),
                                  color: Colors.orange[50],
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.toString().length > 10)
                                    return 'Invalid Aadhar Number';
                                  return null;
                                },
                                controller: _textEditingController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: '   Enter the 10 digit Aadhar No.',
                                  labelStyle: GoogleFonts.varelaRound(
                                    color: Colors.orange,
                                  ),
                                ),
                                cursorColor: Colors.orange,
                                cursorWidth: 2.0,
                                style: TextStyle(
                                    fontSize: 15, color: Colors.purple),
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                MaterialButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                        color: Color(0xff02AE8B), fontSize: 20),
                                  ),
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  minWidth: 125,
                                  height: 57,
                                ),
                                MaterialButton(
                                  onPressed: () async {
                                    print(_textEditingController.text);
                                    var response;
                                    var requiredata;
                                    var url =
                                        'https://covid19-vaccine.herokuapp.com/api/';
                                    try {
                                      response = await http.get(url);
                                      List Data = json.decode(response.body);

                                      for (int i = 0; i < Data.length; i++) {
                                        if (Data[i]["aadhar_number"]
                                                .toString() ==
                                            _textEditingController.text
                                                .toString()) {
                                          requiredata = Data[i];
                                        } else {
                                          print('invalid');
                                        }
                                      }

                                      if (requiredata["isVaccinated"] == true) {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Dialog(
                                                child: Container(
                                                  height: 100,
                                                  width: 100,
                                                  child: Column(
                                                    children: [
                                                      IconButton(
                                                        icon: Icon(Icons.close),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Center(
                                                            child: Text(
                                                          'Already Vaccinated',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });
                                      }
                                      requiredata["isVaccinated"] = true;
                                    } catch (e) {
                                      _showAlert(context, 'Invalid number');
                                    }
                                    try {
                                      response = await http.put(url,
                                          headers: {
                                            'Content-type': 'application/json'
                                          },
                                          body: json.encode(requiredata));
                                      print(response.body);
                                    } catch (e) {
                                      _showAlert(context, e);
                                    }
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Add',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  color: Color(0xff02AE8B),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  minWidth: 125,
                                  height: 57,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  });
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Container(
        constraints: BoxConstraints.expand(),
        child: ListView(
          children: [
            SizedBox(
              height: 35,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width / 2 - 20,
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
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Vaccines available Per Day ',
                            style: TextStyle(
                                color: Colors.red[200],
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text(
                          '2',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width / 2 - 20,
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
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Area Details:',
                            style: TextStyle(
                                color: Colors.teal[200],
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text(
                          'Delhi',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Looks like a lot of people are getting vaccinated',
                style: GoogleFonts.varelaRound(
                    foreground: Paint()..shader = linearGradient,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(300),
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 20.0)
                  ]),
              child: PieChart(
                dataMap: widget.dataMap,
                animationDuration: Duration(milliseconds: 800),
                chartLegendSpacing: 32,
                chartRadius: MediaQuery.of(context).size.width + 4,
                colorList: [Colors.blueAccent, Colors.red],
                initialAngleInDegree: 0,
                ringStrokeWidth: 32,
                legendOptions: LegendOptions(
                  showLegendsInRow: false,
                  legendPosition: LegendPosition.right,
                  showLegends: true,
                  legendShape: BoxShape.circle,
                  legendTextStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                chartValuesOptions: ChartValuesOptions(
                  showChartValueBackground: true,
                  showChartValues: true,
                  showChartValuesInPercentage: false,
                  showChartValuesOutside: false,
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () async {
                await Authentication().signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminLogin(),
                    ),
                    (route) => false);
              },
              child: new Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 2.0, color: Colors.greenAccent),
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(20.0)),
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Logout',
                      style: GoogleFonts.varelaRound(
                          color: Colors.greenAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                  ],
                ),
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                height: 80,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showAlert(BuildContext context, String text) {
  showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            height: 100,
            width: 100,
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
