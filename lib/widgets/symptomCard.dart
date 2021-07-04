import 'package:flutter/material.dart';

class SymptomCard extends StatefulWidget {
  final String name;
  final String imageAddress;
  final Color color;

  SymptomCard(this.color, this.imageAddress, this.name);
  @override
  _SymptomCardState createState() => _SymptomCardState();
}

class _SymptomCardState extends State<SymptomCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width * 0.4,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: widget.color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                height: 100,
                width: 100,
                child: Image.asset(widget.imageAddress)),
            Text(
              widget.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.height * 0.02,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
