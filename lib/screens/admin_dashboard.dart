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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff02AE8B),
        elevation: 0,
        title: Text('Admin Dashboard'),
        centerTitle: true,
        actions: [
          IconButton(
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
                                color: Colors.red[100],
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
                                color: Colors.teal[100],
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
        

            SizedBox(
              height: 50,
            ),

          ],
        ),
      ),
      
    );
  }
}

// void _showAlert(BuildContext context, String text) {
//   showDialog(
//       context: context,
//       builder: (context) {
//         return Dialog(
//           child: Container(
//             height: 100,
//             width: 100,
//             child: Column(
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.close),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Center(
//                       child: Text(
//                     text,
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   )),
//                 ),
//               ],
//             ),
//           ),
//         );
//       });
// }
