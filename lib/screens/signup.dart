import 'package:flutter/material.dart';
import 'package:project/screens/login.dart';
import 'package:project/services/authentication.dart';
import 'package:project/widgets/snackbar.dart';
import 'package:project/services/getImage.dart';
import 'dart:io';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var nameController = TextEditingController();
  var passController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  File _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.4), BlendMode.dstATop),
                image: AssetImage(
                  'assets/images/riken-patel-cjutU3nE7ME-unsplash.jpg',
                ),
                fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                // height: MediaQuery.of(context).size.height,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        "S i g n  U p",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.height * 0.04,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Name:",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: nameController,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Email:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: emailController,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Phone:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        controller: phoneController,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Password:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: passController,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Profile Pic:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            // textAlign: TextAlign.left,
                          ),
                          TextButton(
                            onPressed: () => pickImage(),
                            child: Text(
                              'upload image',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          CircleAvatar(
                            radius: 30,
                            child: _image == null
                                ? Container()
                                : Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: FileImage(_image),
                                            fit: BoxFit.fill)),
                                  ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.tealAccent),
                        ),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          // emailController.text = 'test@gmail.com';
                          // phoneController.text = '1';
                          // passController.text = '123456';
                          // nameController.text = 'test';
                          if (emailController.text.trim() != "" &&
                              passController.text.trim() != "" &&
                              phoneController.text.trim() != "" &&
                              nameController.text.trim() != "" &&
                              _image != null) {
                            if (isEmail(emailController.text.trim())) {
                              Auth().signUp(
                                emailController.text.trim(),
                                passController.text.trim(),
                                nameController.text.trim(),
                                phoneController.text.trim(),
                                _image,
                                context,
                              );
                            } else {
                              showSnackbar(
                                  'Please enter a valid email', context);
                            }
                          } else {
                            showSnackbar('Please fill all fields', context);
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "O R",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () {},
                              child: Text("SignUp with google",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))),
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.transparent,
                            child: Image.asset('assets/images/google.png'),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Login()));
                          },
                          child: Text("Existing user? Log In",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold))),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

  pickImage() async {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    pickFromGallery();
                    Navigator.pop(context);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        child: Image.asset('assets/images/gallery.png'),
                      ),
                      Text('Gallery')
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    pickFromCamera();
                    Navigator.pop(context);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        child: Image.asset('assets/images/camera.png'),
                      ),
                      Text('Camera')
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  void pickFromCamera() async {
    var pickedFile = await pickImageFromCamera();

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  void pickFromGallery() async {
    var pickedFile = await pickImageFromGallery();

    setState(() {
      _image = File(pickedFile.path);
    });
  }
}
