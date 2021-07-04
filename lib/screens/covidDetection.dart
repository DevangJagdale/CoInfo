import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project/services/getImage.dart';
import 'package:project/widgets/MyClipper.dart';
import 'package:project/widgets/clipPath.dart';
import 'package:tflite/tflite.dart';

class CovidDetection extends StatefulWidget {
  @override
  _CovidDetectionState createState() => _CovidDetectionState();
}

class _CovidDetectionState extends State<CovidDetection> {
  List _outputs;
  File _image;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff3383CD),
        title: Text("Covid Detection"),
      ),
      body: _loading
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : _image == null
              ? Container(
                  child: Column(
                    children: [
                      MyClipPath(MyClipper1(), 'assets/images/search.png'),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.55,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Upload your chest X-ray',
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.03,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.33,
                                width:
                                    MediaQuery.of(context).size.height * 0.33,
                                child: Image.asset('assets/images/x-ray.png'),
                              ),
                              Text(
                                'Studies have indicated that for faster covid detection chest x-ray can be used. Pooled results showed that chest X-ray correctly diagnosed COVID-19 in 80.6% of people who had COVID-19. However, it incorrectly identified COVID-19 in 28.5% of people who did not have COVID-19.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 300,
                        width: 300,
                        child: Image.file(
                          _image,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      _outputs != null
                          ? Text(
                              "X-ray looks like ${_outputs[0]["label"]}",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                background: Paint()..color = Colors.white,
                              ),
                            )
                          : Container()
                    ],
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: pickImage,
        backgroundColor: Colors.red,
        child: Icon(Icons.image),
      ),
    );
  }

  Future pickImage() async {
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
      _loading = true;
      _image = File(pickedFile.path);
    });

    classifyImage(File(pickedFile.path));
  }

  void pickFromGallery() async {
    var pickedFile = await pickImageFromGallery();

    setState(() {
      _loading = true;
      _image = File(pickedFile.path);
    });

    classifyImage(File(pickedFile.path));
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _loading = false;
      _outputs = output;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/models/model_unquant.tflite",
      labels: "assets/models/labels.txt",
    );
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }
}
