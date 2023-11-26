import 'package:app/Controllers/ComplainController.dart';
import 'package:app/Controllers/ComplainController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComplainScreen extends StatefulWidget {
  const ComplainScreen({Key? key}) : super(key: key);

  @override
  State<ComplainScreen> createState() => _ComplainScreenState();
}

class _ComplainScreenState extends State<ComplainScreen> {
  final _formKey = GlobalKey<FormState>();

  final complainController = Get.put(ComplainController());

  String _description = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
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
          ],
        ),
      ),
    );
  }
}
