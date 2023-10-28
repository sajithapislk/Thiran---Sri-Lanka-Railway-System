import 'dart:developer';

import 'package:app/Models/ScheduleTimeTableModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controllers/ScheduleTimeTableController.dart';

class ProcessPaymentScreen extends StatefulWidget {
  int index;

  ProcessPaymentScreen({Key? key, required this.index}) : super(key: key);

  @override
  State<ProcessPaymentScreen> createState() => _ProcessPaymentScreenState();
}

class _ProcessPaymentScreenState extends State<ProcessPaymentScreen> {
  final qtyController = TextEditingController(text: '0');
  String optionValue = 'acs';
  final scheduleTimeController = Get.put(ScheduleTimeTableController());
  final price = '0.0'.obs;
  late Schedule row;

  @override
  void initState() {
    row = scheduleTimeController.list[widget.index];
    super.initState();
  }

  void qtyChange() {
    try {
      if (optionValue == 'acs') {
        final _available = row.train.acsMaxSeats - row.acsPSeats;
        log(_available.toString());
        if (_available == 0) {
          Get.defaultDialog(
            title: "Seats ERROR",
            middleText: "Sorry Full Seats booked",
            backgroundColor: Colors.green,
            titleStyle: TextStyle(color: Colors.white),
            middleTextStyle: TextStyle(color: Colors.white),
          );
        }
        // if (_available >= int.parse(qtyController.text)) {
        //   Get.defaultDialog(
        //     title: "Seats ERROR",
        //     middleText:
        //         "Available seat count ${_available - int.parse(qtyController.text)}",
        //     backgroundColor: Colors.green,
        //     titleStyle: TextStyle(color: Colors.white),
        //     middleTextStyle: TextStyle(color: Colors.white),
        //   );
        // }
        final _price = scheduleTimeController.acs_price.value * int.parse(qtyController.text);
        price(_price.toString());
        return;
      }
      if (optionValue == 'os') {
        final _available = row.train.osMaxSeats - row.osPSeats;
        log(_available.toString());
        if (_available == 0) {
          Get.defaultDialog(
            title: "Seats ERROR",
            middleText: "Sorry Full Seats booked",
            backgroundColor: Colors.green,
            titleStyle: TextStyle(color: Colors.white),
            middleTextStyle: TextStyle(color: Colors.white),
          );
        }
        // if (_available >= int.parse(qtyController.text)) {
        //   Get.defaultDialog(
        //     title: "Seats ERROR",
        //     middleText:
        //         "Available seat count ${_available - int.parse(qtyController.text)}",
        //     backgroundColor: Colors.green,
        //     titleStyle: TextStyle(color: Colors.white),
        //     middleTextStyle: TextStyle(color: Colors.white),
        //   );
        // }
        final _price = scheduleTimeController.os_price.value * int.parse(qtyController.text);
        price(_price.toString());
        return;
      }
      if (optionValue == 'scrs') {
        final _available = row.train.scrsMaxSeats - row.scrsPSeats;
        log(_available.toString());
        if (_available == 0) {
          Get.defaultDialog(
            title: "Seats ERROR",
            middleText: "Sorry Full Seats booked",
            backgroundColor: Colors.green,
            titleStyle: TextStyle(color: Colors.white),
            middleTextStyle: TextStyle(color: Colors.white),
          );
        }
        // if (_available >= int.parse(qtyController.text)) {
        //   Get.defaultDialog(
        //     title: "Seats ERROR",
        //     middleText:
        //         "Available seat count ${_available - int.parse(qtyController.text)}",
        //     backgroundColor: Colors.green,
        //     titleStyle: TextStyle(color: Colors.white),
        //     middleTextStyle: TextStyle(color: Colors.white),
        //   );
        // }
        final _price = scheduleTimeController.scrs_price.value * int.parse(qtyController.text);
        price(_price.toString());
        return;
      }
      if (optionValue == 'tcrs') {
        final _available = row.train.tcrsMaxSeats - row.tcrsPSeats;
        log(_available.toString());
        if (_available == 0) {
          Get.defaultDialog(
            title: "Seats ERROR",
            middleText: "Sorry Full Seats booked",
            backgroundColor: Colors.green,
            titleStyle: TextStyle(color: Colors.white),
            middleTextStyle: TextStyle(color: Colors.white),
          );
        }
        // if (_available >= int.parse(qtyController.text)) {
        //   Get.defaultDialog(
        //     title: "Seats ERROR",
        //     middleText:
        //         "Available seat count ${_available - int.parse(qtyController.text)}",
        //     backgroundColor: Colors.green,
        //     titleStyle: TextStyle(color: Colors.white),
        //     middleTextStyle: TextStyle(color: Colors.white),
        //   );
        // }
        final _price = scheduleTimeController.tcrs_price.value * int.parse(qtyController.text);
        price(_price.toString());
        return;
      }
    } catch (e) {
      price('0.0');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Stack(
          // fit: StackFit.passthrough,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(50, 10, 10, 10),
              padding: const EdgeInsets.fromLTRB(80, 10, 10, 10),
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFF2886F1),
                borderRadius: BorderRadius.circular(20),
              ),
              // color: Colors.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text("ABC Train",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "From:",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Colors.white),
                  ),
                  Text(
                    "To:",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Colors.white),
                  ),
                  Text(
                    "Date:",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Colors.white),
                  ),
                  Text(
                    "Time:",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Colors.white),
                  ),
                  Text(
                    "Duration:",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            Positioned(
                top: 30,
                left: 15,
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Color(0xFFFDE248),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset('assets/icon/train_192px.png'),
                )),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 15.0, right: 15.0, top: 15, bottom: 0),
          //padding: EdgeInsets.symmetric(horizontal: 15),
          child: TextField(
            controller: qtyController,
            onChanged: (text) => qtyChange(),
            decoration:
                InputDecoration(border: OutlineInputBorder(), labelText: 'Qty'),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
              left: 15.0, right: 15.0, top: 15, bottom: 0),
          width: double.infinity,
          child: DropdownButton<String>(
            alignment: Alignment.centerLeft,
            value: optionValue,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            onChanged: (String? value) {
              // This is called when the user selects an item..
              if (value == 'acs')
                price(scheduleTimeController.acs_price.toString());
              if (value == 'os')
                price(scheduleTimeController.os_price.toString());
              if (value == 'scrs')
                price(scheduleTimeController.scrs_price.toString());
              if (value == 'tcrs')
                price(scheduleTimeController.tcrs_price.toString());
              qtyChange();
              setState(() {
                optionValue = value!;
              });
            },
            items: [
              DropdownMenuItem<String>(
                value: 'acs',
                child: Text('Air Conditioned Saloon'),
              ),
              DropdownMenuItem<String>(
                value: 'os',
                child: Text('Observation Saloon'),
              ),
              DropdownMenuItem<String>(
                value: 'scrs',
                child: Text('Second Class Reserved Seats'),
              ),
              DropdownMenuItem<String>(
                value: 'tcrs',
                child: Text('Third Class Reserved Seats'),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 15.0, right: 15.0, top: 15, bottom: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("Price"), Obx(() => Text(price.value))],
          ),
        ),
        Center(
          child: ElevatedButton(
            child: Text("Payment"),
            onPressed: () {},
          ),
        )
      ]),
    );
  }
}
