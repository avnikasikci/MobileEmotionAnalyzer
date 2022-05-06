import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_emotion/UI/models/imageAnalyzeModel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class GaleryAnalyzerView extends StatefulWidget {
  //const GaleryAnalyzerView({Key? key}) : super(key: key);

  @override
  _GaleryAnalyzerViewState createState() => _GaleryAnalyzerViewState();
  late bool isLoading;
}

class _GaleryAnalyzerViewState extends State<GaleryAnalyzerView> {
  @override
  void initState() {
    super.initState();
    loadModel();
  }

  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];
  List<ImageAnalyzeModel>? analyzeModelList = [];

  void selectImages() async {
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    print("Image List Length:" + imageFileList!.length.toString());
    setState(() {});
  }

  void clearImages() async {
    imageFileList = [];
    analyzeModelList = [];
    setState(() {});
  }

  void analyzImages() async {
    // for (int index = 0; index < imageFileList!.length; index++) {
    //   runModel(imageFileList![index].path);
    // }

    // imageFileList!.forEach((element) async {
    //     runModel(element.path);
    // });

    for (var model in imageFileList!) {
      var path = model.path;
      var predictions = await Tflite.runModelOnImage(path: path);
      predictions!.forEach((element) {
        print("element2=");
        print(element);
        var model = ImageAnalyzeModel(path, element['label']);

        setState(() {
          //output = element['label'];
          analyzeModelList?.add(model);
        });
      });
    }

    setState(() {});
  }

  runModel(String path) async {
    // var destinationImage = File(path);

    // List<Uint8List> bytes = [];
    // var bytesConcat = await destinationImage.readAsBytes();
    // bytes.add(bytesConcat);
    // var decodedImage =
    //     await decodeImageFromList(destinationImage.readAsBytesSync());

    var predictions2 = await Tflite.runModelOnImage(path: path);
    predictions2!.forEach((element) {
      print("element2=");
      print(element);
      var model = ImageAnalyzeModel(path, element['label']);

      setState(() {
        //output = element['label'];
        analyzeModelList?.add(model);
      });
    });

    // var predictions = await Tflite.runModelOnFrame(
    //     bytesList: bytes,
    //     // bytesList: cameraImage!.planes.map((plane) {
    //     //   return plane.bytes;
    //     // }).toList(),
    //     imageHeight: decodedImage!.height,
    //     imageWidth: decodedImage!.width,
    //     imageMean: 127.5,
    //     imageStd: 127.5,
    //     rotation: 90,
    //     numResults: 2,
    //     threshold: 0.1,
    //     asynch: true);
    // predictions!.forEach((element) {
    //   print("element=");
    //   print(element);

    //   var model = ImageAnalyzeModel(path, element['label']);

    //   setState(() {
    //     //output = element['label'];
    //     analyzeModelList?.add(model);
    //   });
    // });
  }

  loadModel() async {
    await Tflite.loadModel(
        model: "assets/modelVGoogle.tflite", labels: "assets/labels.txt");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Galery Emotion Detect'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  selectImages();
                },
                child: Text('Select Images'),
              ),
              ElevatedButton(
                onPressed: () {
                  clearImages();
                },
                child: Text('Clear Images'),
              ),
              ElevatedButton(
                onPressed: () {
                  analyzImages();
                },
                child: Text('Analyz Images'),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                      itemCount: imageFileList!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemBuilder: (BuildContext context, int index) {
                        return Image.file(
                          File(imageFileList![index].path),
                          //File("path"),
                          fit: BoxFit.cover,
                        );
                      }),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                      itemCount: analyzeModelList!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemBuilder: (BuildContext context, int index) {
                        return Scaffold(
                            body: SafeArea(
                                child: Column(
                          children: [
                            Text("Analyz= " + analyzeModelList![index].result),
                            Image.file(
                              File(analyzeModelList![index].path),
                              //File("path"),
                              fit: BoxFit.cover,
                            )
                          ],
                        )));
                      }),
                ),
              ),
            ],
          ),
        ));
  }
}
