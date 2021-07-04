import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/widgets/snackbar.dart';

class Ask extends StatefulWidget {
  @override
  _AskState createState() => _AskState();
}

class _AskState extends State<Ask> {
  final itemNameController = TextEditingController();
  final itemQuantityController = TextEditingController();
  final pincodeController = TextEditingController();
  final priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Item details'),
                  Container(
                    height: 100,
                    width: 100,
                    child: Image.asset('assets/images/help.png'),
                  )
                ],
              ),
              TextFormField(
                controller: itemNameController,
                decoration: InputDecoration(
                  hintText: 'name of item',
                ),
              ),
              TextFormField(
                controller: itemQuantityController,
                decoration: InputDecoration(
                  hintText: 'quantity of item',
                ),
              ),
              // TextFormField(
              //   decoration: InputDecoration(
              //     hintText: 'Enter address for donation location',
              //   ),
              // ),
              TextFormField(
                controller: pincodeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter pincode for donation location',
                ),
              ),
              TextFormField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Quote Price for item',
                ),
              ),

              ElevatedButton(
                  onPressed: () {
                    FirebaseFirestore.instance.collection('ask').add({
                      'item': '${itemNameController.text.trim()}',
                      'quantity': '${itemQuantityController.text.trim()}',
                      'pincode': '${pincodeController.text.trim()}',
                      'price': '${priceController.text.trim()}',
                      'name':
                          '${FirebaseAuth.instance.currentUser.displayName}',
                      'email': '${FirebaseAuth.instance.currentUser.email}',
                      'photo': '${FirebaseAuth.instance.currentUser.photoURL}',
                      'helpRecieved': false,
                    }).whenComplete(() {
                      showSnackbar(
                          'Successfully posted your help for ask', context);
                      itemNameController.clear();
                      itemQuantityController.clear();
                      pincodeController.clear();
                      priceController.clear();
                    }).catchError((e) {
                      print(e.code);
                      showSnackbar(
                          'Error in posting help ,please try again later',
                          context);
                    });
                  },
                  child: Text("ask")),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("My Ask's"),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('ask')
                      .where('email',
                          isEqualTo: FirebaseAuth.instance.currentUser.email
                              .toString())
                      .snapshots(),
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              return Container(
                                child: ExpansionTile(
                                  leading: snapshot.data.docs[index]
                                          ['helpRecieved']
                                      ? null
                                      : snapshot.data.docs[index]['email']
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
                                    snapshot.data.docs[index]['helpRecieved']
                                        ? Container()
                                        : TextButton(
                                            onPressed: () {
                                              FirebaseFirestore.instance
                                                  .collection('ask')
                                                  .doc(
                                                      '${snapshot.data.docs[index].id}')
                                                  .update(
                                                      {'helpRecieved': true});
                                            },
                                            child: Text('Help recieved'))
                                  ],
                                ),
                              );
                            })
                        : Container();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
