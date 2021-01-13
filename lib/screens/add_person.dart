import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';

class AddPerson extends StatefulWidget {
  @override
  _AddPersonState createState() => _AddPersonState();
}

class _AddPersonState extends State<AddPerson> {
  TextEditingController name, age, occupation, area, zone;

  File pickedImage;
  bool isLoaded = false, vaccinated = false, isAtRisk = false;
  Future pickImage() async {
    var temp = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      if (temp != null) {
        pickedImage = temp;
        isLoaded = true;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    name = TextEditingController();
    age = TextEditingController();
    occupation = TextEditingController();
    area = TextEditingController();
    zone = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    name.dispose();
    age.dispose();
    area.dispose();
    occupation.dispose();
    zone.dispose();
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
          title: Text('Add Person'),
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
                child: Text(
                  'Add Details of person without id proof',
                  style: GoogleFonts.varelaRound(
                      foreground: Paint()..shader = linearGradient,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              CircleAvatar(
                  child: isLoaded
                      ? null
                      : IconButton(
                          icon: Icon(
                            Icons.camera_alt,
                            size: 35,
                          ),
                          onPressed: pickImage,
                        ),
                  radius: 70,
                  backgroundImage: pickedImage != null
                      ? FileImage(
                          pickedImage,
                        )
                      : null),
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
                      prefixIcon: Icon(Icons.add),
                      alignLabelWithHint: true,
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
                child: Container(
                  child: TextFormField(
                    controller: occupation,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.format_list_numbered),
                      alignLabelWithHint: true,
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      labelText: 'Occupation',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: TextFormField(
                    controller: area,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.airplanemode_active),
                      alignLabelWithHint: true,
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      labelText: 'Area',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: TextFormField(
                    controller: zone,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.location_city),
                      alignLabelWithHint: true,
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      labelText: 'Zone',
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Is at Risk?",
                        style: TextStyle(fontSize: 20),
                      ),
                      Checkbox(
                        activeColor: Color(0xff02AE8B),
                        value: isAtRisk,
                        onChanged: (bool value) {
                          setState(() {
                            isAtRisk = value;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Is Vaccinated?",
                        style: TextStyle(fontSize: 20),
                      ),
                      Checkbox(
                        activeColor: Color(0xff02AE8B),
                        value: vaccinated,
                        onChanged: (bool value) {
                          setState(() {
                            vaccinated = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              MaterialButton(
                onPressed: () async {
                  String username = 'admin', password = 'admin';
                  String basicAuth =
                      base64Encode(utf8.encode('$username:$password'));

                  var headers = {'Authorization': 'Basic $basicAuth'};
                  var request = http.MultipartRequest(
                      'POST', Uri.parse('http://192.168.1.6:8000/api3/'));
                  request.fields.addAll({
                    'name': name.text.toString(),
                    'area': area.text.toString(),
                    'zone': zone.text.toString(),
                    'age': age.text.toString(),
                    'occupation': occupation.text.toString(),
                    'isatRisk': isAtRisk.toString(),
                    "isVaccinated": vaccinated.toString(),
                  });
                  var result;
                  request.files.add(await http.MultipartFile.fromPath(
                      'file', pickedImage.path));
                  request.headers.addAll(headers);

                  http.StreamedResponse response = await request.send();

                  if (response.statusCode == 200) {
                    result = await response.stream.bytesToString();
                  } else {
                    result = response.reasonPhrase;
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
