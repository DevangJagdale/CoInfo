import 'package:flutter/material.dart';
import 'package:project/screens/ask.dart';
import 'package:project/screens/give.dart';

class Donate extends StatefulWidget {
  @override
  _DonateState createState() => _DonateState();
}

class _DonateState extends State<Donate> {
  String selectedOption = 'give';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff3383CD),
        title: Text('Help'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 5),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 120,
                          child: TextButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                    selectedOption == 'ask'
                                        ? Colors.amber
                                        : Colors.white)),
                            child: Text(
                              'Ask',
                              style: TextStyle(
                                  color: selectedOption == 'ask'
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize:
                                      MediaQuery.of(context).size.height * 0.03,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              setState(() {
                                selectedOption = 'ask';
                              });
                            },
                          ),
                        ),
                        Container(
                          width: 120,
                          child: TextButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                    selectedOption == 'give'
                                        ? Colors.amber
                                        : Colors.white)),
                            child: Text(
                              'Give',
                              style: TextStyle(
                                  color: selectedOption == 'give'
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize:
                                      MediaQuery.of(context).size.height * 0.03,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              setState(() {
                                selectedOption = 'give';
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              selectedOption == 'ask' ? Ask() : Give(),
            ],
          ),
        ),
      ),
    );
  }
}
