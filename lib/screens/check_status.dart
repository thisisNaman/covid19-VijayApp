import 'package:covid_vijay_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DisplayVaccinationStatus extends StatelessWidget {
  static String routeName = '/displayStatus';

  @override
  Widget build(BuildContext context) {
    final Map data = ModalRoute.of(context).settings.arguments as Map;
    final Map dataFetched = data['maindata'];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Color(0xff02AE8B),
        title: Text('Vaccination Status'),
      ),
      body: ListView(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  child: Image.asset('assets/images/covid_vaccine.png'),
                ),
                ListTile(
                    title: Text(
                  'Aadhar Number : ${dataFetched['aadhar_number']}',
                  style: GoogleFonts.varelaRound(
                      foreground: Paint()..shader = linearGradient,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                )),
              ],
            ),
          ),
          ListTile(
              title: Text(
            'Name: ${dataFetched['name']}',
            style: GoogleFonts.varelaRound(
                foreground: Paint()..shader = linearGradient,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          )),
          ListTile(
              title: Text(
            'Area: ${dataFetched['area']}',
            style: GoogleFonts.varelaRound(
                foreground: Paint()..shader = linearGradient,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          )),
          ListTile(
              title: Text(
            'Zone: ${dataFetched['zone']}',
            style: GoogleFonts.varelaRound(
                foreground: Paint()..shader = linearGradient,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          )),
          ListTile(
              title: Text(
            'IsAtRisk: ${dataFetched['isatRisk']}',
            style: GoogleFonts.varelaRound(
                foreground: Paint()..shader = linearGradient,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          )),
          if ('${dataFetched['isVaccinated']}' == false.toString())
            ListTile(
                title: Text(
              'Date of Vaccination: ${dataFetched['dateofvaccination']}',
              style: GoogleFonts.varelaRound(
                  foreground: Paint()..shader = linearGradient,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            )),
          ListTile(
              title: Text(
            'IsVaccinated: ${dataFetched['isVaccinated']}',
            style: GoogleFonts.varelaRound(
                foreground: Paint()..shader = linearGradient,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          )),
        ],
      ),
    );
  }
}
