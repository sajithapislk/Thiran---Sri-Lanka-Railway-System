import 'package:app/Controllers/LostFoundItemController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'LostFoundItemCreateScreen.dart';

class LostFoundItemScreen extends StatefulWidget {
  const LostFoundItemScreen({Key? key}) : super(key: key);

  @override
  State<LostFoundItemScreen> createState() => _LostFoundItemScreenState();
}

class _LostFoundItemScreenState extends State<LostFoundItemScreen> {
  final lostFoundItemController = Get.put(LostFoundItemController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Lost Found Item List"
        ),
        actions: [
          TextButton(
              onPressed: ()=> Get.to(()=>LostFoundItemCreateScreen()),
              child: Text("create",style: TextStyle(
                color: Colors.amberAccent
              ),)
          )
        ],
      ),
      body: Obx(() => lostFoundItemController.list.length>0 ? ListView.builder(
          itemCount: lostFoundItemController.list.length,
          itemBuilder: (context, index) {
            final data = lostFoundItemController.list[index];
            return Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              width: 100,
              decoration: BoxDecoration(
                color:Color(0xffefefef),
                borderRadius: BorderRadius.circular(20),
              ),
              // color: Colors.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${data.type} - ${data.itemName}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black),
                  ),
                  Text(
                    data.description,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Colors.black
                    ),
                  ),
                ],
              ),
            );
          }) : Center(child: Text("empty"))),
    );
  }
}
