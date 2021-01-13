import 'package:covid_vijay_app/screens/add_person.dart';
import 'package:covid_vijay_app/screens/admin_dashboard.dart';
import 'package:covid_vijay_app/screens/chatbot.dart';
import 'package:covid_vijay_app/screens/update_vaccination_status.dart';
import 'package:covid_vijay_app/screens/vaccines_dispatched.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  PageController pageController;
  int pageIndex = 0;
  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          AdminDashboard(),
          UpdateVaccinationStatus(),
          AddPerson(),
          VaccinesDispatched(),
          HomePageDialogflow(),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Colors.white,
        border: Border.all(color: Colors.white),
        iconSize: 30.0,
        currentIndex: pageIndex,
        onTap: onTap,
        activeColor: Colors.black,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.update_outlined)),
          BottomNavigationBarItem(icon: Icon(Icons.person_add)),
          BottomNavigationBarItem(icon: Icon(Icons.track_changes)),
          BottomNavigationBarItem(icon: Icon(Icons.help)),
        ],
      ),
    );
  }
}
