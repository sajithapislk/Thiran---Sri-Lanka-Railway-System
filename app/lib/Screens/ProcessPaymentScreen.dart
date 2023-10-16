import 'package:flutter/material.dart';
import 'package:search_choices/search_choices.dart';
import 'package:get/get.dart';

import '../Controllers/StationController.dart';

class ProcessPaymentScreen extends StatefulWidget {
  const ProcessPaymentScreen({Key? key}) : super(key: key);

  @override
  State<ProcessPaymentScreen> createState() => _ProcessPaymentScreenState();
}

class _ProcessPaymentScreenState extends State<ProcessPaymentScreen> {
  final stationController = Get.put(StationController());

  final classController = TextEditingController();
  final passwordController = TextEditingController();

  String? areaSelectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
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
                  )
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 0
            ),
            child: Obx(() => SearchChoices.single(
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
              value: areaSelectedValue,
              hint: "Select one",
              searchHint: "Select one",
              onChanged: (value) {
                setState(() {
                  areaSelectedValue = value;
                });
              },
              isExpanded: true,
            )),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15, bottom: 0
            ),
            child: Obx(() => SearchChoices.single(
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
              value: areaSelectedValue,
              hint: "Select one",
              searchHint: "Select one",
              onChanged: (value) {
                setState(() {
                  areaSelectedValue = value;
                });
              },
              isExpanded: true,
            )),
          ),
        ]
      ),
    );
  }
}
