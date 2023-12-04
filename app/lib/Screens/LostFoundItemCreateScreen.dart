import 'dart:io';

import 'package:app/Controllers/ComplainController.dart';
import 'package:app/Controllers/LostFoundItemController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class LostFoundItemCreateScreen extends StatefulWidget {
  const LostFoundItemCreateScreen({Key? key}) : super(key: key);

  @override
  State<LostFoundItemCreateScreen> createState() => _LostFoundItemCreateScreenState();
}

class _LostFoundItemCreateScreenState extends State<LostFoundItemCreateScreen> {
  final _formKey = GlobalKey<FormState>();

  final lostFoundItemController = Get.put(LostFoundItemController());

  CroppedFile? _croppedFile1;
  CroppedFile? _croppedFile2;
  CroppedFile? _croppedFile3;
  CroppedFile? _croppedFile4;
  String description = '';
  String itemName = '';
  String type = 'FOUND';

  _showmodelbotamsheet_camara_gallery(BuildContext context, int index) {
    return showModalBottomSheet(
        context: context,
        builder: (context) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.camera),
                  title: Text("Camara"),
                  onTap: () {
                    _camarTagPicker(index: index, isCamara: true);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo),
                  title: Text("Gallery"),
                  onTap: () {
                    _camarTagPicker(index: index, isCamara: false);
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  _camarTagPicker({required int index, required bool isCamara}) async {
    final pickedFile = await ImagePicker()
        .pickImage(source: isCamara ? ImageSource.camera : ImageSource.gallery);
    if (pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
          WebUiSettings(
            context: context,
            presentStyle: CropperPresentStyle.dialog,
            boundary: const CroppieBoundary(
              width: 520,
              height: 520,
            ),
            viewPort:
                const CroppieViewPort(width: 480, height: 480, type: 'circle'),
            enableExif: true,
            enableZoom: true,
            showZoomer: true,
          ),
        ],
      );
      if (croppedFile != null) {
        if (index == 1) {
          setState(() {
            _croppedFile1 = croppedFile;
          });
        } else if (index == 2) {
          setState(() {
            _croppedFile2 = croppedFile;
          });
        } else if (index == 3) {
          setState(() {
            _croppedFile3 = croppedFile;
          });
        } else {
          setState(() {
            _croppedFile1 = croppedFile;
          });
        }
      }
    }
  }

  Widget previewimage(int index) {
    if (_croppedFile1 != null && index == 0) {
      return Column(children: [
        Image.file(
          File(_croppedFile1!.path),
          height: 90,
        ),
        Text(
          "Image",
          style: TextStyle(fontSize: 12, color: Colors.black),
        ),
      ]);
    } else if (_croppedFile2 != null && index == 2) {
      return Column(children: [
        Image.file(
          File(_croppedFile1!.path),
          height: 90,
        ),
        Text(
          "Image",
          style: TextStyle(fontSize: 12, color: Colors.black),
        ),
      ]);
    } else if (_croppedFile3 != null && index == 3) {
      return Column(children: [
        Image.file(
          File(_croppedFile1!.path),
          height: 90,
        ),
        Text(
          "Image",
          style: TextStyle(fontSize: 12, color: Colors.black),
        ),
      ]);
    } else if (_croppedFile4 != null && index == 4) {
      return Column(children: [
        Image.file(
          File(_croppedFile1!.path),
          height: 90,
        ),
        Text(
          "Image",
          style: TextStyle(fontSize: 12, color: Colors.black),
        ),
      ]);
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Image",
          style: TextStyle(color: Colors.grey),
        ),
        Icon(
          Icons.camera,
          color: Colors.grey,
        ),
      ],
    );
  }

  void submitData(){
    final data = {
      "type":type,
      "item_name":itemName,
      "description":description,
      "img1":_croppedFile1!.path,
      "img2":_croppedFile2!.path,
      "img3":_croppedFile3!.path,
      "img4":_croppedFile4!.path,
    };
    lostFoundItemController.create(data:data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text("Type"),
                SizedBox(width: 50),
                Container(
                  height: 40,
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    border: Border.all(
                        color: Colors.grey,
                        style: BorderStyle.solid,
                        width: 0.80),
                  ),
                  child: DropdownButton(
                      value: type,
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          type = value!;
                        });
                      },
                      items: const [
                        DropdownMenuItem(
                          value: 'FOUND',
                          child: Text("Found"),
                        ),
                        DropdownMenuItem(
                          value: "LOST",
                          child: Text('Lost'),
                        )
                      ]),
                ),
              ]),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Itme Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Itme Name';
                  }
                  return null;
                },
                onSaved: (value) {
                  description = value!;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) {
                  description = value!;
                },
                maxLines: 10,
              ),
              SizedBox(
                height: 300,
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 116,
                    ),
                    itemCount: 4,
                    itemBuilder: (context, index) => Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.5))),
                          child: InkWell(
                              child: previewimage(index),
                              onTap: () => _showmodelbotamsheet_camara_gallery(
                                  context, index)),
                        )),
              ),
              ElevatedButton(
                onPressed: () {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  _formKey.currentState!.save();
                  submitData();
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
