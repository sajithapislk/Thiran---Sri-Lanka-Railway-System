import 'dart:developer';

import 'package:app/Controllers/ScheduleTimeTableController.dart';
import 'package:app/Models/StationModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:search_choices/search_choices.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../Controllers/StationController.dart';

class TrainFindScreen extends StatefulWidget {
  const TrainFindScreen({Key? key}) : super(key: key);

  @override
  State<TrainFindScreen> createState() => _TrainFindScreenState();
}

class _TrainFindScreenState extends State<TrainFindScreen> {
  final stationController = Get.put(StationController());
  final scheduleTimeController = Get.put(ScheduleTimeTableController());

  String? toSelectedValue;
  String? fromSelectedValue;

  final _formKey = GlobalKey<FormState>();
  DateTime date = DateTime.now();

  // This function displays a CupertinoModalPopup with a reasonable fixed height
  // which hosts CupertinoDatePicker.
  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system
        // navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Obx(() => SearchChoices.single(
                    fieldPresentationFn: (Widget fieldWidget,
                        {bool? selectionIsValid}) {
                      return Container(
                        child: InputDecorator(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'From'),
                          child: fieldWidget,
                        ),
                      );
                    },
                    items: stationController.list
                        .map((element) => DropdownMenuItem(
                      child: Text(element.name),
                      value: "${element.id}|${element.name}",
                    ))
                        .toList(),
                    value: fromSelectedValue,
                    hint: "Select one",
                    searchHint: "Select one",
                    onChanged: (value) {
                      setState(() {
                        fromSelectedValue = value;
                      });
                    },
                    isExpanded: true,
                  )),
                  SizedBox(
                    height: 15,
                  ),
                  Obx(() => SearchChoices.single(
                    fieldPresentationFn: (Widget fieldWidget,
                        {bool? selectionIsValid}) {
                      return Container(
                        child: InputDecorator(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'To'),
                          child: fieldWidget,
                        ),
                      );
                    },
                    items: stationController.list
                        .map((element) => DropdownMenuItem(
                      child: Text(element.name),
                      value: "${element.id}|${element.name}",
                    ))
                        .toList(),
                    value: toSelectedValue,
                    hint: "Select one",
                    searchHint: "Select one",
                    onChanged: (value) {
                      setState(() {
                        toSelectedValue = value;
                      });
                    },
                    isExpanded: true,
                  )),
                  _DatePickerItem(
                    children: <Widget>[
                      const Text('Date'),
                      CupertinoButton(
                        // Display a CupertinoDatePicker in date picker mode.
                        onPressed: () => _showDialog(
                          CupertinoDatePicker(
                            initialDateTime: date,
                            mode: CupertinoDatePickerMode.date,
                            use24hFormat: true,
                            // This is called when the user changes the date.
                            onDateTimeChanged: (DateTime newDate) {
                              setState(() => date = newDate);
                            },
                          ),
                        ),
                        // In this example, the date is formatted manually. You can
                        // use the intl package to format the value based on the
                        // user's locale settings.
                        child: Text(
                          '${date.year}-${date.month}-${date.day}',
                          style: const TextStyle(
                            fontSize: 22.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        scheduleTimeController.getList(from: fromSelectedValue!.split('|')[0], to: toSelectedValue!.split('|')[0], date: date.toString());
                      },
                      child: Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Obx(()=>ListView.builder(
              itemCount: scheduleTimeController.list.length,
              itemBuilder: (context, index) {
                var row = scheduleTimeController.list[index];
                int _fromId = row.route.stationList[0];
                int _toId = row.route.stationList[row.route.stationList.length-1];

                StationModel? fromStation = stationController.findById(_fromId);
                StationModel? toStation = stationController.findById(_toId);
                return Stack(
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
                            width:double.infinity,
                            child: Text(
                                "ABC Train",
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
                            "From: ${fromStation!.name}",
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                                color: Colors.white),
                          ),
                          Text(
                            "To: ${toStation!.name}",
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                                color: Colors.white),
                          ),
                          Text(
                            "Date: ${DateFormat('yyyy-MM-dd').format(row.startAt)}",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "	Arrival Time: ${DateFormat('HH:mm:ss').format(row.startAt)}",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "End At: ${DateFormat('HH:mm:ss').format(row.endAt)}",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Price:",
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                                color: Colors.white),
                          ),
                          Container(
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text('Payment'),
                            ),
                            alignment: Alignment.center,
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
                        )
                    )
                  ],
                );
              },
            ),
            )
          )
        ],
      ),
    );
  }
}

class _DatePickerItem extends StatelessWidget {
  const _DatePickerItem({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: CupertinoColors.inactiveGray,
            width: 0.0,
          ),
          bottom: BorderSide(
            color: CupertinoColors.inactiveGray,
            width: 0.0,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children,
        ),
      ),
    );
  }
}
