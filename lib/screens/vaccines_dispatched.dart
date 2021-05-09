import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants.dart';

class VaccinesDispatched extends StatefulWidget {
  @override
  _VaccinesDispatchedState createState() => _VaccinesDispatchedState();
}

class _VaccinesDispatchedState extends State<VaccinesDispatched> {
  TextEditingController vaccines_dispatched,
      vaccines_usable,
      temperature,
      humidity;

  @override
  void initState() {
    vaccines_dispatched = TextEditingController();
    vaccines_usable = TextEditingController();
    temperature = TextEditingController();
    humidity = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    vaccines_usable.dispose();
    vaccines_dispatched.dispose();
    temperature.dispose();
    humidity.dispose();
    super.dispose();
  }

  String trafficDensity;
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
          title: Text('Vaccine Logistics Information'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
                    'Add Details of Dispatched Vaccines',
                    style: GoogleFonts.varelaRound(
                        foreground: Paint()..shader = linearGradient,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: TextFormField(
                    controller: vaccines_dispatched,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.format_list_numbered_sharp),
                      alignLabelWithHint: true,
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      labelText: 'Number of vaccines dispatched',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: TextFormField(
                    controller: vaccines_usable,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.check),
                      alignLabelWithHint: true,
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      labelText: 'No. of vaccines which can be used',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: TextFormField(
                    controller: temperature,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.texture),
                      alignLabelWithHint: true,
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      labelText: 'Temperature',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: TextFormField(
                    controller: humidity,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.opacity),
                      alignLabelWithHint: true,
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      labelText: 'Humidity',
                    ),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.traffic),
                      Text(
                        'Traffic Density',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      DropdownButton(
                        hint: Text(
                          'Select Traffic Density',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        value: trafficDensity,
                        onChanged: (value) {
                          setState(() {
                            trafficDensity = value;
                          });
                        },
                        items: [
                          DropdownMenuItem(
                            child: Text(
                              'Low',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            value: 'Low',
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'Medium',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            value: 'Medium',
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'High',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            value: 'High',
                          ),
                        ],
                      ),
                    ],
                  )),
              MaterialButton(
                onPressed: () async {
                  var result;
                  try {
                    var url = 'http://192.168.1.6:8000/api2/';
                    String username = 'admin', password = 'admin';
                    String basicAuth = 'Basic ' +
                        base64Encode(utf8.encode('$username:$password'));
                    Map data = {
                      "No_vaccine_dispatched": vaccines_dispatched.text,
                      "No_usable_vaccine": vaccines_usable.text,
                      "Temperature": temperature.text,
                      "Humidity": humidity.text,
                      "traffic_density": trafficDensity
                    };
                    final response = await http.post(url,
                        headers: {
                          'authorization': basicAuth,
                          "Content-Type": "application/json"
                        },
                        body: json.encode(data));
                    print(response.body);

                    result =
                        "Data Submitted! We Recommend you to Dispatch ${json.decode(response.body)["Success"]} Vaccines";
                    print(result);
                  } catch (e) {
                    result = e.toString();
                  }
                  final snackbar = SnackBar(content: Text(result));
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                color: Color(0xff02AE8B),
                minWidth: MediaQuery.of(context).size.width / 2,
                height: 50,
                child: Text('Submit',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
