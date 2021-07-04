import 'package:flutter/material.dart';

class MyClipPath extends StatefulWidget {
  final String imageAddress;
  final CustomClipper<Path> clipper;

  MyClipPath(this.clipper, this.imageAddress);
  @override
  _MyClipPathState createState() => _MyClipPathState();
}

class _MyClipPathState extends State<MyClipPath> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: widget.clipper,
      child: Container(
        height: MediaQuery.of(context).size.height * .20,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xff3383CD), Color(0xff11249F)])),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: MediaQuery.of(context).size.height * .16,
                width: MediaQuery.of(context).size.height * .16,
                child: Image.asset(
                  widget.imageAddress,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
