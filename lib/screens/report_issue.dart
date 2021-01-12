import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReportIssue extends StatefulWidget {
  @override
  _ReportIssueState createState() => _ReportIssueState();
}

class _ReportIssueState extends State<ReportIssue> {

  String painSeverity;
  TextEditingController name,aadharNumber,description,age;

  @override
  void initState() {
    super.initState();
    name = TextEditingController();
    aadharNumber = TextEditingController();
    description = TextEditingController();
    age = TextEditingController();
  }

  @override
  void dispose() {
   name.dispose();
   aadharNumber.dispose();
   description.dispose();
    super.dispose();
  }


  bool fever = false;
  bool allergic = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff02AE8B),
        centerTitle: true,
        elevation: 0,
        title: Text('Report Issue'),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.supervised_user_circle_sharp),
                    alignLabelWithHint: true,
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    labelText: 'Name',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(

                child: TextFormField(
                  controller: age,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    prefixIcon: Icon(Icons.broken_image),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    labelText: 'Age',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.opacity),
                  Text('Pain Severity',style: TextStyle(
                    fontSize: 15,
                  ),),
                  SizedBox(width: 20,),
                  DropdownButton(
                    hint: Text('Select Pain Severity',style: TextStyle(
                      fontSize: 15,
                    ),),
                    value: painSeverity,
                    onChanged: (value) {
                      setState(() {
                        painSeverity = value;
                      });
                    },
                    items: [
                      DropdownMenuItem(child:
                      Text('Low Pain',style: TextStyle(
                    fontSize: 15,
                  ),),
                      value: 'Low',),
                      DropdownMenuItem(child:
                      Text('Medium Pain',style: TextStyle(
                      fontSize: 15,
                      ),),
                      value: 'Medium',),
                      DropdownMenuItem(child:
                      Text('High Pain',style: TextStyle(
    fontSize: 15,
    ),),
                      value: 'High',),
                    ],
                  ),
                ],
              )
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: TextFormField(

                  controller: aadharNumber,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    prefixIcon: Image.asset(
                      'assets/images/aadhar.png',
                      height: 10,
                      width: 50,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    labelText: 'Aadhar No.',
                  ),
                ),
              ),
            ),

            Text(
              'Symptoms',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Fever  ",
                      style: TextStyle(fontSize: 20),
                    ),
                    Checkbox(
                      activeColor: Color(0xff02AE8B),
                      value: fever,
                      onChanged: (bool value) {
                        setState(() {
                          fever = value;
                        });
                      },
                    ),
                  ],
                ),
                  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Allergic",
                  style: TextStyle(fontSize: 20),
                ),
                Checkbox(
                  activeColor: Color(0xff02AE8B),
                  value: allergic,
                  onChanged: (bool value) {
                    setState(() {
                      allergic = value;
                    });
                  },
                ),
              ],
            ),
              ],
            ),

            Text('If any other symptoms',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w400),),
                        Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: TextFormField(
                  controller: description,
                  minLines: 1,
                  maxLines: 20,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    labelText: 'Give Brief Description About Symptoms',
                  ),
                ),
              ),
            ),
            MaterialButton(
              onPressed: () async{
                try {
                  var url = 'http://192.168.1.6:8000/api1/';
                  String username = 'admin',
                      password = 'admin';
                  String basicAuth = 'Basic ' +
                      base64Encode(utf8.encode('$username:$password'));

                  Map data = {
                    "aadhar_number": aadharNumber.text.toString(),
                    "name": name.text.toString(),
                    "age": age.text.toString(),
                    "description": description.text.toString(),
                    "Fever": fever,
                    "Pain_Severity": painSeverity,
                    "Any_allergies": allergic,
                  };
                  final response = await http.post(
                      url, headers: {
                    'authorization': basicAuth,
                    "Content-Type": "application/json"
                  }, body: json.encode(data));
                  print(response.body);
                  final snackBar = SnackBar(
                      content: Text('Your report has been submitted!'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }catch(e){
                  print(e);
                }
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
