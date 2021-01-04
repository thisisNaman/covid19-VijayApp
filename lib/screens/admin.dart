import 'package:covid_vijay_app/screens/add_person.dart';
import 'package:covid_vijay_app/screens/admin_dashboard.dart';
import 'package:covid_vijay_app/screens/chatbot.dart';
import 'package:covid_vijay_app/screens/update_vaccination_status.dart';
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
          HomePageDialogflow(),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: pageIndex,
        onTap: onTap,
        activeColor: Colors.black,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home)),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
          ),
          BottomNavigationBarItem(
              icon: Icon(
            Icons.add_a_photo,
          )),
          BottomNavigationBarItem(icon: Icon(Icons.help)),
        ],
      ),
    );
  }
}
