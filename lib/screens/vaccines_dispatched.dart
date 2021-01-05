import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class VaccinesDispatched extends StatefulWidget {
  @override
  _VaccinesDispatchedState createState() => _VaccinesDispatchedState();
}

class _VaccinesDispatchedState extends State<VaccinesDispatched> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VaccinesDispatched'),
        centerTitle: true,
        elevation: 0,
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
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_on),
                      alignLabelWithHint: true,
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      labelText: 'Dispatched From',
                    ),
                  ),
                ),
              ),
                   Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_on_outlined),
                      alignLabelWithHint: true,
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      labelText: 'Dispatched To',
                    ),
                  ),
                ),
              ),
                  Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.card_travel),
                      alignLabelWithHint: true,
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      labelText: 'Vehicle Number',
                    ),
                  ),
                ),
              ),
                 MaterialButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Container(
                            height: 200,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [Text('Vaccine Dispatch Status Updated!')],
                            ),
                          ),
                        );
                      });
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
    );
  }
}