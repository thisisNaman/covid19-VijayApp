import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class AddPerson extends StatefulWidget {
  @override
  _AddPersonState createState() => _AddPersonState();
}

class _AddPersonState extends State<AddPerson> {
  File pickedImage;
  bool isLoaded = false;
  Future pickImage() async {
    var temp = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      if(temp!=null){
      pickedImage = temp;
      isLoaded = true;
      }
      
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        elevation: 0,
      ),
      body: Column(
        children: [
          isLoaded ? Container(
            child: Image.file(pickedImage)
          ): Container(
            height: MediaQuery.of(context).size.height/1.6,
                      width: MediaQuery.of(context).size.width,
                      child: Text('as'),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: pickImage,
        icon: Icon(Icons.image),
        backgroundColor: Colors.amberAccent,
        label: Text('Pick Image')),
    );
  }
}
