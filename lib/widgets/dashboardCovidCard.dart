import 'package:flutter/material.dart';

Widget displayCovidCard(context, color, title, text, image) {
  return Card(
    elevation: 20,
    // color: Colors.amber,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    child: Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.height * 0.2,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                color: color,
                fontSize: MediaQuery.of(context).size.height * 0.028,
                // fontWeight: FontWeight.bold
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.09,
            width: MediaQuery.of(context).size.height * 0.09,
            child: Image.asset(
              image,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "$text",
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.02,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    ),
  );
}
