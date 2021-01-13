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
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
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
          title: Text('UpdateVaccinationStatus'),
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          height: MediaQuery.of(context).size.height / 2,
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(height: 20),
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
                padding: EdgeInsets.symmetric(horizontal: 12.0),
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
                    labelText: 'Enter the 12 digit Aadhar No.',
                    labelStyle: GoogleFonts.varelaRound(
                      color: Colors.orange,
                    ),
                  ),
                  cursorColor: Colors.orange,
                  cursorWidth: 2.0,
                  style: TextStyle(fontSize: 17, color: Colors.purple),
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
                          foreground: Paint()..shader = linearGradient,
                          fontSize: 20),
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
                      var url = 'http://192.168.1.6:8000/api/';
                      String username = 'admin', password = 'admin';
                      String basicAuth = 'Basic ' +
                          base64Encode(utf8.encode('$username:$password'));
                      try {
                        response = await http
                            .get(url, headers: {'authorization': basicAuth});
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
                          return;
                        }
                        requiredata["isVaccinated"] = true;
                      } catch (e) {
                        //_showAlert(context, 'Invalid number');
                        final snackbar3 =
                            SnackBar(content: Text('Invalid number'));
                        ScaffoldMessenger.of(context).showSnackBar(snackbar3);
                      }

                      final snackbar1 = SnackBar(
                          content: Text('Person Successfully Vaccinated!'));
                      final snackbar2 =
                          SnackBar(content: Text('There was some error'));

                      try {
                        response = await http.put(url,
                            headers: {
                              'Content-type': 'application/json',
                              'authorization': basicAuth
                            },
                            body: json.encode(requiredata));
                        print(response.body);
                        ScaffoldMessenger.of(context).showSnackBar(snackbar1);
                      } catch (e) {
                        // _showAlert(context, e);
                        ScaffoldMessenger.of(context).showSnackBar(snackbar2);
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
      ),
    );
  }
}
