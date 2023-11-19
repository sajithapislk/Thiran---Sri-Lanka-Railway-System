import 'package:app/Screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controllers/BookController.dart';

class MyReservation extends StatefulWidget {
  const MyReservation({Key? key}) : super(key: key);

  @override
  State<MyReservation> createState() => _MyReservationState();
}

class _MyReservationState extends State<MyReservation> {
  final bookController = Get.put(BookController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => bookController.list.isEmpty
            ? Center(child: Text('Empty'))
            : ListView.builder(
                itemCount: bookController.list.length,
                itemBuilder: (context, index) {
                  var row = bookController.list[index];
                  return Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
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
                        Text(
                            "Train Name                : ${row.scheduleTime.train.name}",
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                        Text(
                            "Start At                       : ${row.scheduleTime.startAt}",
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                        Text(
                            "End At                         : ${row.scheduleTime.endAt}",
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                        Text(
                            "Distance                     : ${row.distance} KM",
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                        Text("Payment Amount      : ${row.payment.amount} LKR",
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  Get.to(()=>MapScreen());
                                },
                                child: Text("Map",style: TextStyle(
                                  color: Colors.black
                                ),),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.amber,
                                )),
                            ElevatedButton(
                                onPressed: () {},
                                child: Text("Cancel Book",style: TextStyle(
                                    color: Colors.black
                                ),),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.amber,
                                )),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
      ),
      // body: Center(
      //   child: Text("asd"),
      // ),
    );
  }
}
