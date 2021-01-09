import 'package:covid_vijay_app/constants.dart';
import 'package:covid_vijay_app/screens/report_issue.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'check_status.dart';

class UserHome extends StatefulWidget {
  final Map<String, double> dataMap;
  UserHome({@required this.dataMap});
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  bool _loading = false;
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
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10.0,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'Welcome_',
                  style: GoogleFonts.varelaRound(
                      foreground: Paint()..shader = linearGradient,
                      fontSize: 30.0,
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
                height: 20.0,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 5, 20, 0),
                decoration: BoxDecoration(
                    border: Border.all(width: 2.0, color: Colors.orange),
                    color: Colors.orange[50],
                    borderRadius: BorderRadius.circular(20.0)),
                child: TextFormField(
                  controller: _textEditingController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: Image.asset(
                      'assets/images/aadhar.png',
                      height: 30.0,
                    ),
                    labelText: 'Aadhar No.',
                    labelStyle: GoogleFonts.varelaRound(
                      color: Colors.orange,
                    ),
                  ),
                  cursorColor: Colors.orange,
                  cursorWidth: 2.0,
                  style: TextStyle(fontSize: 25, color: Colors.purple),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              InkWell(
                onTap: () async {
                  // print(_textEditingController.text);
                  var requireddata;
                  try {
                    var url = 'http://192.168.1.6:8000/api';
                    setState(() {
                      _loading = true;
                    });
                    String username= 'admin',password = 'admin';
                    String basicAuth =
                        'Basic ' + base64Encode(utf8.encode('$username:$password'));

                    final response = await http.get(url,headers: {'authorization':basicAuth});
                    List Data = json.decode(response.body);
                    for (int i = 0; i < Data.length; i++) {
                      if (Data[i]["aadhar_number"].toString() ==
                          _textEditingController.text.toString()) {
                        requireddata = Data[i];

                        Navigator.of(context).pushNamed(
                            DisplayVaccinationStatus.routeName,
                            arguments: {'maindata': requireddata});
                        setState(() {
                          _loading = false;
                        });
                      } else {
                        setState(() {
                          _loading = false;
                        });
//                         _showAlert(context, 'Invalid Aadhar number');
                      }
                    }
                  } catch (e) {
                    setState(() {
                      _loading = false;
                    });
//                     _showAlert(context, e);
                  }
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
                        'Check',
                        style: GoogleFonts.varelaRound(
                            color: Colors.greenAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Icon(
                        Icons.check,
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
                height: 50,
              ),
        _loading?SizedBox(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.green,
                ),
              ):Text(''),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(0xff02AE8B),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ReportIssue()));
        },
        label: Text('Report an Issue'),
        icon: Icon(Icons.add_alert),
      ),
    );
  }
}

 void _showAlert(BuildContext context, String text) {
   showDialog(
     context: context,
     builder: (context) => Container(
       child: AlertDialog(
         title: Text("Error while Signing In"),
         content: Text(text),
         actions: [
           RaisedButton(
             child: Text('Go Back'),
             color: Colors.blue,
             elevation: 20,
             onPressed: () {
               Navigator.of(context).pop();
             },
           ),
         ],
       ),
     ),
   );
 }
