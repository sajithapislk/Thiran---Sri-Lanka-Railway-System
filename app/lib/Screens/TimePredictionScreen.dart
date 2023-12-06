import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimePredictionScreen extends StatefulWidget {
  const TimePredictionScreen({Key? key}) : super(key: key);

  @override
  State<TimePredictionScreen> createState() => _TimePredictionScreenState();
}

class _TimePredictionScreenState extends State<TimePredictionScreen> {
  // final trainPredictionController = Get.put()
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Time Prediction"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {  },
          child: Text("Get Prediction"),
        ),
      ),
    );
  }
}
