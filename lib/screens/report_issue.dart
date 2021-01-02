import 'package:flutter/material.dart';

class ReportIssue extends StatefulWidget {
  @override
  _ReportIssueState createState() => _ReportIssueState();
}

class _ReportIssueState extends State<ReportIssue> {
  bool aVal = false;
  bool bVal = false;
  bool cVal = false;
  bool dVal = false;
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
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    prefixIcon: Icon(Icons.call),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    labelText: 'Contact No.',
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: TextFormField(
                  minLines: 1,
                  maxLines: 20,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    labelText: 'Description',
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
                      value: aVal,
                      onChanged: (bool value) {
                        setState(() {
                          aVal = value;
                        });
                      },
                    ),
                  ],
                ),
                  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Alergic",
                  style: TextStyle(fontSize: 20),
                ),
                Checkbox(
                  activeColor: Color(0xff02AE8B),
                  value: bVal,
                  onChanged: (bool value) {
                    setState(() {
                      bVal = value;
                    });
                  },
                ),
              ],
            ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Cough",
                      style: TextStyle(fontSize: 20),
                    ),
                    Checkbox(
                      activeColor: Color(0xff02AE8B),
                      value: cVal,
                      onChanged: (bool value) {
                        setState(() {
                          cVal = value;
                        });
                      },
                    ),
                  ],
                ),
                  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Others",
                  style: TextStyle(fontSize: 20),
                ),
                Checkbox(
                  activeColor: Color(0xff02AE8B),
                  value: dVal,
                  onChanged: (bool value) {
                    setState(() {
                      dVal = value;
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
                  minLines: 1,
                  maxLines: 20,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    labelText: 'Mention symptoms',
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
                            children: [Text('Your report has been submitted!')],
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
