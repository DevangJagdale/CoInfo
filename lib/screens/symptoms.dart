import 'package:flutter/material.dart';
import 'package:project/widgets/MyClipper.dart';
import 'package:project/widgets/clipPath.dart';
import 'package:project/widgets/symptomCard.dart';

class Symptoms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff3383CD),
        title: Text('Symptoms of Corona'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              MyClipPath(MyClipper1(), 'assets/images/medical-team.png'),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Most Common Symptoms',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        SymptomCard(
                            Colors.green, 'assets/images/fever.png', 'fever'),
                        SymptomCard(Colors.green, 'assets/images/cough.png',
                            'dry cough'),
                        SymptomCard(Colors.green, 'assets/images/fatigue.png',
                            'tiredness'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Less Common Symptoms',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        SymptomCard(Colors.amber, 'assets/images/pain.png',
                            'aches and pain'),
                        SymptomCard(Colors.amber,
                            'assets/images/sore-throat.png', 'sore throat'),
                        SymptomCard(Colors.amber, 'assets/images/diarrhea.png',
                            'diarrhoea'),
                        SymptomCard(Colors.amber, 'assets/images/redness.png',
                            'conjunctivitis'),
                        SymptomCard(Colors.amber, 'assets/images/headache.png',
                            'headache'),
                        SymptomCard(
                            Colors.amber,
                            'assets/images/loss-of-sense-of-taste.png',
                            'loss of taste or smell'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Serious Symptoms',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        SymptomCard(
                            Colors.red,
                            'assets/images/difficulty-breathing.png',
                            'difficulty in breathing'),
                        SymptomCard(
                            Colors.red,
                            'assets/images/disabled-person.png',
                            'loss of movement'),
                        SymptomCard(
                            Colors.red,
                            'assets/images/chest-pain-or-pressure.png',
                            'chest pain'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
