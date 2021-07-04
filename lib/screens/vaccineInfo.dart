import 'package:flutter/material.dart';
import 'package:project/widgets/MyClipper.dart';
import 'package:project/widgets/clipPath.dart';

class VaccineInfo extends StatefulWidget {
  final dynamic vaccineData;
  VaccineInfo(this.vaccineData);
  @override
  _VaccineInfoState createState() => _VaccineInfoState();
}

class _VaccineInfoState extends State<VaccineInfo> {
  final pincodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xff3383CD),
          title: Text("Vaccine centers near you"),
        ),
        body: Stack(
          children: [
            MyClipPath(MyClipper1(), 'assets/images/hospital.png'),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                  margin: const EdgeInsets.only(top: 190),
                  height: 20,
                  child: TextFormField(
                    controller: pincodeController,
                    decoration: InputDecoration(
                        hintText: 'Search by Pincode',
                        icon: Icon(Icons.search)),
                  )),
            ),
            Container(
              margin: const EdgeInsets.only(top: 250),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.vaccineData.length,
                itemBuilder: (context, index) {
                  return pincodeController.text.trim() == ''
                      ? Container(
                          child: ExpansionTile(
                            backgroundColor:
                                Colors.grey.shade200.withOpacity(0.92),
                            title: Text("${widget.vaccineData[index]['name']}"),
                            subtitle: Text(
                                "Pincode: ${widget.vaccineData[index]['pincode']}"),
                            children: <Widget>[
                              Text(
                                "Center Details",
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Text(
                                    "Address: ${widget.vaccineData[index]['name']}"),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Text(
                                    "Opening Time: ${widget.vaccineData[index]['from']}"),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Text(
                                    "Closing Time: ${widget.vaccineData[index]['to']}"),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Text(
                                    "Price: ₹${widget.vaccineData[index]['fee']}"),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Text(
                                    "Available capacity dose1: ${widget.vaccineData[index]['available_capacity_dose1']}"),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Text(
                                    "Available capacity dose2: ${widget.vaccineData[index]['available_capacity_dose2']}"),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Text(
                                    "Age Limit: ${widget.vaccineData[index]['min_age_limit']}+"),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Text(
                                    "Vaccine name: ${widget.vaccineData[index]['vaccine']}"),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Text(
                                  "Slots:\n${widget.vaccineData[index]['slots']}",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        )
                      : pincodeController.text.trim() ==
                              widget.vaccineData[index]['pincode'].toString()
                          ? Container(
                              child: ExpansionTile(
                                backgroundColor:
                                    Colors.grey.shade200.withOpacity(0.92),
                                title: Text(
                                    "${widget.vaccineData[index]['name']}"),
                                subtitle: Text(
                                    "Pincode: ${widget.vaccineData[index]['pincode']}"),
                                children: <Widget>[
                                  Text(
                                    "Center Details",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                    child: Text(
                                        "Address: ${widget.vaccineData[index]['name']}"),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                    child: Text(
                                        "Opening Time: ${widget.vaccineData[index]['from']}"),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                    child: Text(
                                        "Closing Time: ${widget.vaccineData[index]['to']}"),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                    child: Text(
                                        "Price: ₹${widget.vaccineData[index]['fee']}"),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                    child: Text(
                                        "Available capacity dose1: ${widget.vaccineData[index]['available_capacity_dose1']}"),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                    child: Text(
                                        "Available capacity dose2: ${widget.vaccineData[index]['available_capacity_dose2']}"),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                    child: Text(
                                        "Age Limit: ${widget.vaccineData[index]['min_age_limit']}+"),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                    child: Text(
                                        "Vaccine name: ${widget.vaccineData[index]['vaccine']}"),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                    child: Text(
                                      "Slots:\n${widget.vaccineData[index]['slots']}",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container();
                },
              ),
            ),
          ],
        ));
  }
}
