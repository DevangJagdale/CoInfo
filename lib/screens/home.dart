import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project/model/covidData.dart';
import 'package:project/screens/covidDetection.dart';
import 'package:project/screens/donate.dart';
import 'package:project/screens/symptoms.dart';
import 'package:project/screens/vaccine.dart';
import 'package:project/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:project/widgets/MyClipper.dart';
import 'package:project/widgets/dashboardCovidCard.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var user = FirebaseAuth.instance.currentUser;
  String name;
  String url;

  var covidData;

  bool loading = true;
  void initState() {
    super.initState();
    if (user != null) {
      print('user is not null');
      name = user.displayName;
      url = user.photoURL;
    }
    getData();
    getData1();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  Auth().logout(context);
                }),
          ),
        ],
        backgroundColor: Color(0xff3383CD),
        title: Text('Dashboard'),
        elevation: 0,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xff3383CD),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(url),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Text("Welcome $name"),
                ],
              ),
            ),
            ListTile(
              title: Text('Help'),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Donate()));
              },
            ),
            ListTile(
              title: Text('Vaccine'),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Vaccine()));
              },
            ),
            ListTile(
              title: Text('Symptoms'),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Symptoms()));
              },
            ),
            ListTile(
              title: Text('X-Ray'),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CovidDetection()));
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Container(
            child: loading
                ? CircularProgressIndicator()
                : Column(
                    children: [
                      ClipPath(
                        clipper: MyClipper(),
                        child: Container(
                          height: MediaQuery.of(context).size.height * .30,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                Color(0xff3383CD),
                                Color(0xff11249F)
                              ])),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * .20,
                                  width:
                                      MediaQuery.of(context).size.height * .20,
                                  child: Image.asset(
                                    'assets/images/diagnosis.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height,
                                child: Stack(
                                  children: [
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          "Stay Home,\nStay Safe",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.03,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * .55,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Country Status",
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.height * 0.04,
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                displayCovidCard(
                                    context,
                                    Colors.teal,
                                    'Total Cases',
                                    covidData[0]['cases']['total'],
                                    'assets/images/blood-transfusion.png'),
                                displayCovidCard(
                                    context,
                                    Colors.orange,
                                    "Active Cases",
                                    covidData[0]['cases']['active'],
                                    'assets/images/illness.png'),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                displayCovidCard(
                                    context,
                                    Colors.red,
                                    "Death",
                                    covidData[0]['deaths']['total'],
                                    'assets/images/coronavirus.png'),
                                displayCovidCard(
                                    context,
                                    Colors.green,
                                    "Recovered",
                                    covidData[0]['cases']['recovered'],
                                    'assets/images/recovered.png'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
      ),
    );
  }

  void getData() async {
    CovidResponse data;

    final response = await http.get(
        Uri.parse('https://covid-193.p.rapidapi.com/statistics?country=India'),
        headers: {
          "x-rapidapi-key":
              "your_key",
          "x-rapidapi-host": "covid-193.p.rapidapi.com",
        });

    if (response.statusCode == 200) {
      data = CovidResponse.fromJson(jsonDecode(response.body));
      covidData = data.response.asMap();
      // print(covidData[0]['cases']['new']);
      // print(data.response);
      setState(() {
        loading = false;
      });
    }
  }

  void getData1() async {
    final response = await http.get(
        Uri.parse(
            'https://coronavirus-map.p.rapidapi.com/v1/spots/region?region=india'),
        headers: {
          "x-rapidapi-key":
              "your_key",
          "x-rapidapi-host": "coronavirus-map.p.rapidapi.com",
        });

    if (response.statusCode == 200) {
      print(response.body);
    }
  }
}
