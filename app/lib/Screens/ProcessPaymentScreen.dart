import 'package:app/Models/ScheduleTimeTableModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../Controllers/ScheduleTimeTableController.dart';
import '../Models/StationModel.dart';
import 'PaymentScreen.dart';

class ProcessPaymentScreen extends StatefulWidget {
  int index;
  Schedule row;
  StationModel? fromStation;
  StationModel? toStation;

  ProcessPaymentScreen(
      {Key? key,
      required this.index,
      required this.row,
      required this.fromStation,
      required this.toStation})
      : super(key: key);

  @override
  State<ProcessPaymentScreen> createState() => _ProcessPaymentScreenState();
}

class _ProcessPaymentScreenState extends State<ProcessPaymentScreen> {
  final qtyController = TextEditingController(text: '0');
  String optionValue = 'acs';
  final scheduleTimeController = Get.put(ScheduleTimeTableController());
  final price = '0.0'.obs;
  late Schedule row;
  bool _isAvailable = true;

  @override
  void initState() {
    row = scheduleTimeController.list[widget.index];
    super.initState();
  }

  void qtyChange() {
    try {
      if (optionValue == 'acs') {
        final _available = widget.row.train.acsMaxSeats - widget.row.acsPSeats;
        if (_available == 0) {
          Get.defaultDialog(
            title: "Seats ERROR",
            middleText: "Sorry Full Seats booked",
            backgroundColor: Colors.green,
            titleStyle: TextStyle(color: Colors.white),
            middleTextStyle: TextStyle(color: Colors.white),
          );
          setState(() {
            _isAvailable = false;
          });
          return;
        }
        if (_available <= int.parse(qtyController.text)) {
          Get.defaultDialog(
            title: "Seats ERROR",
            middleText:
                "Available seat count ${_available - int.parse(qtyController.text)}",
            backgroundColor: Colors.green,
            titleStyle: TextStyle(color: Colors.white),
            middleTextStyle: TextStyle(color: Colors.white),
          );
          setState(() {
            _isAvailable = false;
          });
          return;
        }
        setState(() {
          _isAvailable = true;
        });
        final _price = scheduleTimeController.acs_price.value *
            int.parse(qtyController.text);
        price(_price.toString());
      }
      if (optionValue == 'os') {
        final _available = widget.row.train.osMaxSeats - widget.row.osPSeats;
        if (_available == 0) {
          Get.defaultDialog(
            title: "Seats ERROR",
            middleText: "Sorry Full Seats booked",
            backgroundColor: Colors.green,
            titleStyle: TextStyle(color: Colors.white),
            middleTextStyle: TextStyle(color: Colors.white),
          );
          setState(() {
            _isAvailable = false;
          });
          return;
        }
        if (_available <= int.parse(qtyController.text)) {
          Get.defaultDialog(
            title: "Seats ERROR",
            middleText:
                "Available seat count ${_available - int.parse(qtyController.text)}",
            backgroundColor: Colors.green,
            titleStyle: TextStyle(color: Colors.white),
            middleTextStyle: TextStyle(color: Colors.white),
          );
          setState(() {
            _isAvailable = false;
          });
          return;
        }
        final _price = scheduleTimeController.os_price.value *
            int.parse(qtyController.text);
        price(_price.toString());
      }
      if (optionValue == 'scrs') {
        final _available =
            widget.row.train.scrsMaxSeats - widget.row.scrsPSeats;
        if (_available == 0) {
          Get.defaultDialog(
            title: "Seats ERROR",
            middleText: "Sorry Full Seats booked",
            backgroundColor: Colors.green,
            titleStyle: TextStyle(color: Colors.white),
            middleTextStyle: TextStyle(color: Colors.white),
          );
          setState(() {
            _isAvailable = false;
          });
          return;
        }
        if (_available <= int.parse(qtyController.text)) {
          Get.defaultDialog(
            title: "Seats ERROR",
            middleText:
                "Available seat count ${_available - int.parse(qtyController.text)}",
            backgroundColor: Colors.green,
            titleStyle: TextStyle(color: Colors.white),
            middleTextStyle: TextStyle(color: Colors.white),
          );
          setState(() {
            _isAvailable = false;
          });
          return;
        }
        setState(() {
          _isAvailable = true;
        });
        final _price = scheduleTimeController.scrs_price.value *
            int.parse(qtyController.text);
        price(_price.toString());
      }
      if (optionValue == 'tcrs') {
        final _available =
            widget.row.train.tcrsMaxSeats - widget.row.tcrsPSeats;
        if (_available == 0) {
          Get.defaultDialog(
            title: "Seats ERROR",
            middleText: "Sorry Full Seats booked",
            backgroundColor: Colors.green,
            titleStyle: TextStyle(color: Colors.white),
            middleTextStyle: TextStyle(color: Colors.white),
          );
          setState(() {
            _isAvailable = false;
          });
          return;
        }
        if (_available <= int.parse(qtyController.text)) {
          Get.defaultDialog(
            title: "Seats ERROR",
            middleText:
                "Available seat count ${_available - int.parse(qtyController.text)}",
            backgroundColor: Colors.green,
            titleStyle: TextStyle(color: Colors.white),
            middleTextStyle: TextStyle(color: Colors.white),
          );
          setState(() {
            _isAvailable = false;
          });
          return;
        }
        setState(() {
          _isAvailable = true;
        });
        final _price = scheduleTimeController.tcrs_price.value *
            int.parse(qtyController.text);
        price(_price.toString());
      }
    } catch (e) {
      price('0.0');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Stack(
            // fit: StackFit.passthrough,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(50, 10, 10, 10),
                padding: const EdgeInsets.fromLTRB(80, 10, 10, 10),
                height: 200,
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
                      child: Text(widget.row.train.name,
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
                      "From: ${widget.fromStation!.name}",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: Colors.white),
                    ),
                    Text(
                      "To: ${widget.toStation!.name}",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: Colors.white),
                    ),
                    Text(
                      "Date: ${DateFormat('yyyy-MM-dd').format(widget.row.startAt)}",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Arrival Time: ${DateFormat('HH:mm:ss').format(widget.row.startAt)}",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "End At: ${DateFormat('HH:mm:ss').format(widget.row.endAt)}",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "acs Price: ${scheduleTimeController.acs_price.value}LKR",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: Colors.white),
                    ),
                    Text(
                      "os Price: ${scheduleTimeController.os_price.value}LKR",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: Colors.white),
                    ),
                    Text(
                      "scrs Price: ${scheduleTimeController.scrs_price.value}LKR",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: Colors.white),
                    ),
                    Text(
                      "tcrs Price: ${scheduleTimeController.tcrs_price.value}LKR",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: Colors.white),
                    )
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
                  ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 0),
            //padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              controller: qtyController,
              onChanged: (text) => qtyChange(),
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Qty'),
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
              child: Text(_isAvailable ? "Payment" : "ERROR"),
              onPressed: () =>
                  _isAvailable ? Get.to(() => PaymentScreen()) : null,
            ),
          )
        ]),
      ),
    );
  }
}
