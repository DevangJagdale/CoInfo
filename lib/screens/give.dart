import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/widgets/snackbar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'dart:core';

class Give extends StatefulWidget {
  @override
  _GiveState createState() => _GiveState();
}

class _GiveState extends State<Give> {
  final itemNameController = TextEditingController();
  final itemQuantityController = TextEditingController();
  final pincodeController = TextEditingController();
  final priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('People who need help'),
                  Container(
                    height: 100,
                    width: 100,
                    child: Image.asset('assets/images/helping-hand.png'),
                  )
                ],
              ),
              StreamBuilder<QuerySnapshot>(
                  stream:
                      FirebaseFirestore.instance.collection('ask').snapshots(),
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              return snapshot.data.docs[index]['helpRecieved']
                                  ? null
                                  : Container(
                                      child: ExpansionTile(
                                        leading: snapshot
                                                    .data.docs[index]['email']
                                                    .toString() ==
                                                FirebaseAuth
                                                    .instance.currentUser.email
                                                    .toString()
                                            ? IconButton(
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                                onPressed: () {
                                                  FirebaseFirestore.instance
                                                      .collection('ask')
                                                      .doc(
                                                          '${snapshot.data.docs[index].id}')
                                                      .delete()
                                                      .whenComplete(() {
                                                    showSnackbar(
                                                        'Help deleted successfully',
                                                        context);
                                                  });
                                                })
                                            : null,
                                        title: Text(
                                            '${snapshot.data.docs[index]['name']} wants a ${snapshot.data.docs[index]['item']}'),
                                        subtitle: Text(
                                          'Quantity: ${snapshot.data.docs[index]['quantity']}',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
                                                height: 80,
                                                width: 80,
                                                child: Image.network(
                                                  '${snapshot.data.docs[index]['photo']}',
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              Text(
                                                  '${snapshot.data.docs[index]['email']}'),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'Price offered: ${snapshot.data.docs[index]['price']}'),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                                'Pincode: ${snapshot.data.docs[index]['pincode']}'),
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                final Uri _emailLaunchUri = Uri(
                                                    scheme: 'mailto',
                                                    path:
                                                        '${snapshot.data.docs[index]['email']}',
                                                    queryParameters: {
                                                      'subject':
                                                          '${FirebaseAuth.instance.currentUser.displayName} is intrested in helping you to get ${snapshot.data.docs[index]['item']}'
                                                    });
                                                launch(
                                                    _emailLaunchUri.toString());
                                              },
                                              child: Text('Mail for quries'))
                                        ],
                                      ),
                                    );
                            })
                        : Container();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
