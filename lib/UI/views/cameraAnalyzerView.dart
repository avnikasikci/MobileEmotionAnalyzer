import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emotion/main.dart';
import 'package:tflite/tflite.dart';

class CameraAnalyzerView extends StatefulWidget {
  //const CameraAnalyzerView({Key? key}) : super(key: key);

  @override
  _CameraAnalyzerViewState createState() => _CameraAnalyzerViewState();
  late bool isLoading;
}

class _CameraAnalyzerViewState extends State<CameraAnalyzerView> {
  CameraImage? cameraImage;
  CameraController? cameraController;
  String output = '';
  @override
  void initState() {
    super.initState();
    loadCamera();
    loadModel();
  }

  loadCamera() {
    cameraController = CameraController(cameras![0], ResolutionPreset.medium);
    cameraController!.initialize().then((value) {
      if (!mounted) {
        return;
      } else {
        setState(() {
          cameraController!.startImageStream((imageStream) {
            cameraImage = imageStream;
            runModel();
          });
        });
      }
    });
  }

  runModel() async {
    if (cameraImage != null) {
      var bytes = cameraImage!.planes.map((plane) {
        return plane.bytes;
      }).toList();

      var predictions = await Tflite.runModelOnFrame(
          bytesList: cameraImage!.planes.map((plane) {
            return plane.bytes;
          }).toList(),
          imageHeight: cameraImage!.height,
          imageWidth: cameraImage!.width,
          imageMean: 127.5,
          imageStd: 127.5,
          rotation: 90,
          numResults: 2,
          threshold: 0.1,
          asynch: true);
      predictions!.forEach((element) {
        print("element=");
        print(element);
        setState(() {
          output = element['label'];
        });
      });
    }
  }

  loadModel() async {
    await Tflite.loadModel(
        model: "assets/modelVGoogle.tflite", labels: "assets/labels.txt");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Emotion Detect'),
      ),
      body: Column(children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width,
            child: !cameraController!.value.isInitialized
                ? Container()
                : AspectRatio(
                    aspectRatio: cameraController!.value.aspectRatio,
                    child: CameraPreview(cameraController!),
                  ),
          ),
        ),
        Text(
          "Analyz=" + output,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        )
      ]),
    );
  }
}
