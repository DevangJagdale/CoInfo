import 'package:flutter/material.dart';
import 'package:project/model/statesData.dart';
import 'package:project/model/vaccineData.dart';
import 'package:project/screens/vaccineInfo.dart';
import 'package:project/widgets/MyClipper.dart';
import 'package:project/widgets/clipPath.dart';
import 'package:project/widgets/snackbar.dart';

class Vaccine extends StatefulWidget {
  @override
  _VaccineState createState() => _VaccineState();
}

class _VaccineState extends State<Vaccine> {
  final stateController = TextEditingController();
  final districtController = TextEditingController();
  var districtId;
  var vaccineData;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xff3383CD),
          title: Text('Vaccine Details'),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Column(
                children: [
                  MyClipPath(MyClipper1(), 'assets/images/syringe.png'),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.55,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height * .1,
                                    width:
                                        MediaQuery.of(context).size.height * .1,
                                    child: Image.asset(
                                      'assets/images/city-map.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: Text(
                                    'Enter your\nLocation Details',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.026,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border:
                                        Border.all(color: Colors.blueAccent)),
                                child: Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 10, 0, 0),
                                        child: Text(
                                          'Enter your state name:',
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: TextFormField(
                                        controller: stateController,
                                        decoration: InputDecoration(
                                          hintText: 'eg:- Maharashtra',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.blueAccent)),
                            child: Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 10, 0, 0),
                                    child: Text(
                                      'Enter your district name:',
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.02,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: TextFormField(
                                    controller: districtController,
                                    decoration: InputDecoration(
                                      hintText: 'eg:- Pune',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  loading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              loading = true;
                            });
                            if (stateController.text.trim() != '' &&
                                districtController.text.trim() != '') {
                              districtId = await StatesData().getStateData(
                                  stateController.text.trim(),
                                  districtController.text.trim());
                              // print(districtId);
                              if (districtId == null) {
                                showSnackbar(
                                    'Entered District or State name not found',
                                    context);
                              } else {
                                vaccineData = await VaccineData()
                                    .getvaccineData(districtId);
                                if (vaccineData == null) {
                                  showSnackbar(
                                      'No vaccine data available for following location.',
                                      context);
                                } else {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          VaccineInfo(vaccineData)));
                                }
                              }

                              // print(vaccineData.runtimeType);

                            } else {
                              showSnackbar(
                                  'Please enter State and District name.',
                                  context);
                            }
                            setState(() {
                              loading = false;
                            });
                          },
                          child: Text('Submit')),
                ],
              ),
            ),
          ),
        ));
  }
}
