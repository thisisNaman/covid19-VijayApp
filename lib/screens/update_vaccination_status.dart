import 'dart:convert';

import 'package:covid_vijay_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class UpdateVaccinationStatus extends StatefulWidget {
  @override
  _UpdateVaccinationStatusState createState() =>
      _UpdateVaccinationStatusState();
}

class _UpdateVaccinationStatusState extends State<UpdateVaccinationStatus> {
  TextEditingController _textEditingController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UpdateVaccinationStatus'),
        elevation: 0,
        centerTitle: true,
      ),
          body: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        height: MediaQuery.of(context).size.height / 2,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(height:20),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Add the person who got vaccinated',
                style: GoogleFonts.varelaRound(
                    foreground: Paint()..shader = linearGradient,
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
                  border: Border.all(width: 2.0, color: Colors.orange),
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
                style: TextStyle(fontSize: 15, color: Colors.purple),
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
                    style: TextStyle(color: Color(0xff02AE8B), fontSize: 20),
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
                    var url = 'https://covid19-vaccine.herokuapp.com/api/';
                    try {
                      response = await http.get(url);
                      List Data = json.decode(response.body);

                      for (int i = 0; i < Data.length; i++) {
                        if (Data[i]["aadhar_number"].toString() ==
                            _textEditingController.text.toString()) {
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
                                          Navigator.pop(context);
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                            child: Text(
                                          'Already Vaccinated',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
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
                      //_showAlert(context, 'Invalid number');
                    }
                    try {
                      response = await http.put(url,
                          headers: {'Content-type': 'application/json'},
                          body: json.encode(requiredata));
                      print(response.body);
                    } catch (e) {
                      // _showAlert(context, e);
                    }
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Add',
                    style: TextStyle(color: Colors.white, fontSize: 20),
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
  }
}
