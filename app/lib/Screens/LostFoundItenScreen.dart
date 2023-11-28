import 'package:app/Controllers/ComplainController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LostFoundItenScreen extends StatefulWidget {
  const LostFoundItenScreen({Key? key}) : super(key: key);

  @override
  State<LostFoundItenScreen> createState() => _LostFoundItenScreenState();
}

class _LostFoundItenScreenState extends State<LostFoundItenScreen> {
  final _formKey = GlobalKey<FormState>();

  final complainController = Get.put(ComplainController());
  List<CroppedFile>? _croppedFile;
  String _description = '';
  String dropdownValue = 'FOUND';

  _showmodelbotamsheet_camara_gallery(BuildContext context,int index) {
    return showModalBottomSheet(
        context: context,
        builder: (context) =>
            Column(
              mainAxisSize: MainAxisSize.min,
              children:[
                ListTile(
                  leading: Icon(Icons.camera),
                  title: Text("Camara"),
                  onTap: (){
                    _camarTagPicker(isCamara:true);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo),
                  title: Text("Gallery"),
                  onTap: (){
                    _camarTagPicker(isCamara:false);
                    Navigator.of(context).pop();
                  },
                )
              ],
            )
    );
  }

  _camarTagPicker({ required int index,required bool isCamara }) async {
    final pickedFile = await ImagePicker().pickImage(source: isCamara ? ImageSource.camera : ImageSource.gallery);
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
        setState(() {
          _croppedFile![index] = croppedFile;
        });
      }
    }
  }

  Widget previewimage(int index){
    if(_croppedFile![index] == null ){
      return Column(
          children: [
            Image.file(File(_croppedFile![index].path),height: 90,),
            Text("Tag Image",style: TextStyle(fontSize: 12,color: Colors.black),),
          ]
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Tag"
          ,style: TextStyle(color: Colors.grey),),
        Icon(Icons.camera,color: Colors.grey,),
      ],
    );
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
                      value: dropdownValue,
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValue = value!;
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
                  labelText: 'Description',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value!;
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
                  _description = value!;
                },
                maxLines: 10,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  _formKey.currentState!.save();
                  complainController.create(text: _description);
                },
                child: Text('Submit'),
              ),
              SizedBox(
                height: 300,
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisExtent: 116,
                    ),
                    itemCount: 1,
                    itemBuilder: (context,index)=>Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.grey.withOpacity(0.5)
                          )
                      ),
                      child: InkWell(
                          child: previewimage(index),
                          onTap: ()=>_showmodelbotamsheet_camara_gallery(context,index)

                      ),
                    )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
