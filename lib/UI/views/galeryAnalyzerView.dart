import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_emotion/Enums/ImagePredictLabelEnum.dart';
import 'package:flutter_emotion/UI/models/imageAnalyzeLabelModel.dart';
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
  List<ImageAnalyzeLabelModel>? imageAnalyzeLabelModel = [];
  bool _expanded = false;
  var _test = "Full Screen";

  void selectImages() async {
    clearImages();
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
    imageAnalyzeLabelModel = [];
    setState(() {});
  }

  void analyzImages() async {
    //clearImages();
    analyzeModelList = [];
    List<String>? analyzeModelLabelList = [];
    imageAnalyzeLabelModel = [];
    for (var model in imageFileList!) {
      var path = model.path;
      var predictions = await Tflite.runModelOnImage(path: path);
      predictions!.forEach((element) {
        int resultIdTxt = 0;
        ImagePredictLabelEnum.values.forEach((enumEntity) => {
              if (enumEntity == element['label'])
                {resultIdTxt = enumEntity.index}
            });

        var model = ImageAnalyzeModel(path, element['label'], resultIdTxt);

        setState(() {
          analyzeModelList?.add(model);
          analyzeModelLabelList?.add(element['label']);
        });
      });
    }
    analyzeModelLabelList = analyzeModelLabelList?.toSet().toList();

    analyzeModelLabelList!.forEach((labelTxt) {
      var allLabelModelList = analyzeModelList
          ?.where((element) => element.result == labelTxt)
          .toList();
      var modelLabel =
          ImageAnalyzeLabelModel(labelTxt, false, allLabelModelList);
      imageAnalyzeLabelModel?.add(modelLabel);
    });

    setState(() {});
  }

  runModel(String path) async {
    var predictions = await Tflite.runModelOnImage(path: path);
    predictions!.forEach((element) {
      var model = ImageAnalyzeModel(path, element['label'], 0);
      setState(() {
        analyzeModelList?.add(model);
      });
    });
  }

  loadModel() async {
    await Tflite.loadModel(
        model: "assets/model_unquant.tflite", labels: "assets/labels.txt");
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyText2!,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    children: [
                      Container(
                        // A fixed-height child.
                        //  color: const Color(0xffeeee00), // Yellow
                        height: 50.0,
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () {
                            selectImages();
                          },
                          child: Text('Select Images'),
                        ),
                      ),
                      SizedBox(
                        //height: 100,
                        width: 16,
                      ),
                      Container(
                        // A fixed-height child.
                        //  color: const Color(0xffeeee00), // Yellow
                        height: 50.0,
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () {
                            clearImages();
                          },
                          child: Text('Clear Images'),
                        ),
                      ),
                      SizedBox(
                        //height: 100,
                        width: 16,
                      ),
                      Container(
                        // A fixed-height child.
                        // color: const Color(0xffeeee00), // Yellow
                        height: 50.0,
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () {
                            analyzImages();
                          },
                          child: Text('Analyz Images'),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 280.0,
                    alignment: Alignment.center,
                    child: GridView.builder(
                        itemCount: imageFileList!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                        itemBuilder: (BuildContext context, int index) {
                          return Image.file(
                            File(imageFileList![index].path),
                          );
                        }),
                  ),
                  ExpansionPanelList(
                    //expandedHeaderPadding: EdgeInsets.all(10.0),
                    // animationDuration: Duration(milliseconds: 2000),
                    expansionCallback: (int index, bool isExpanded) {
                      setState(() {
                        imageAnalyzeLabelModel![index].expanded =
                            !imageAnalyzeLabelModel![index].expanded;
                      });
                    },
                    children: imageAnalyzeLabelModel!
                        .map<ExpansionPanel>((ImageAnalyzeLabelModel item) {
                      return ExpansionPanel(
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return ListTile(
                            title: Text(item.labelTxt),
                          );
                        },
                        body: SizedBox(
                          height: 200,
                          width: 220,
                          child: SafeArea(
                            child: Expanded(
                              child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3),
                                  padding: const EdgeInsets.all(8),
                                  itemCount: item.modelList?.length,
                                  itemBuilder:
                                      (BuildContext context, int indexModel) {
                                    return Image.file(
                                      File(item.modelList![indexModel].path),
                                      //scale: 0.2,
                                      width: 150,
                                      height: 120,
                                      //fit: BoxFit.fill,
                                    );
                                  }),
                            ),
                          ),
                        ),
     
                        isExpanded: item.expanded,
                      );
                    }).toList(),
                  ),
               
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build2(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Galery Emotion Detect'),
        ),
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                      itemCount: imageAnalyzeLabelModel!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1),
                      itemBuilder: (BuildContext context, int index) {
                        return Scaffold(
                            body: SingleChildScrollView(
                                child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              color: Colors.green,
                              child: ExpansionPanelList(
                                animationDuration: Duration(milliseconds: 2000),
                                children: [
                                  ExpansionPanel(
                                    headerBuilder: (context, isExpanded) {
                                      return ListTile(
                                        title: Text(
                                          // 'Click To Expand' +
                                          imageAnalyzeLabelModel![index]
                                              .labelTxt,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      );
                                    },
                                    body: SizedBox(
                                      height: 210,
                                      child: SafeArea(
                                        child: ListView.builder(
                                            padding: const EdgeInsets.all(8),
                                            itemCount:
                                                imageAnalyzeLabelModel![index]
                                                    .modelList
                                                    ?.length,
                                            // itemBuilder: (_, indexModel) =>
                                            itemBuilder: (BuildContext context,
                                                int indexModel) {
                                              return ListTile(
                                                  title: Image.file(
                                                File(imageAnalyzeLabelModel![
                                                        index]
                                                    .modelList![indexModel]
                                                    .path),
                                                fit: BoxFit.cover,
                                              ));
                                            }),
                                      ),
                                    ),
                                    isExpanded:
                                        imageAnalyzeLabelModel![index].expanded,
                                    canTapOnHeader: true,
                                  ),
                                ],
                                dividerColor: Colors.grey,
                                expansionCallback: (panelIndex, isExpanded) {
                                  imageAnalyzeLabelModel![index].expanded =
                                      !imageAnalyzeLabelModel![index].expanded;
                                  setState(() {});
                                },
                              ),
                            ),
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
