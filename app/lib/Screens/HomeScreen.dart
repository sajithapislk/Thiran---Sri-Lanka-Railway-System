import 'package:app/Screens/LostFoundItemCreateScreen.dart';
import 'package:app/Screens/MyReservation.dart';
import 'package:app/Screens/TrainFindScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controllers/UserController.dart';
import 'ComplainScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Items> myList = [
    Items(
        title: "Reservations",
        subtitle: "",
        event: () => Get.to(() => TrainFindScreen()),
        img: "assets/icon/train_192px.png"),
    Items(
        title: "My Reservations",
        subtitle: "",
        event: () => Get.to(() => MyReservation()),
        img: "assets/icon/train_192px.png"),
    Items(
        title: "News",
        subtitle: "",
        event: () {},
        img: "assets/icon/train_192px.png"),
    Items(
        title: "Complain",
        subtitle: "",
        event: () => Get.to(() => ComplainScreen()),
        img: "assets/icon/train_192px.png"),
    Items(
        title: "Lost And Found Item",
        subtitle: "",
        event: () => Get.to(() => LostFoundItemCreateScreen()),
        img: "assets/icon/train_192px.png")
  ];
  var color = 0xff453658;
  final userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff392850),
      body: Column(children: <Widget>[
        SizedBox(
          height: 50,
        ),
        Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Thiran",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Home",
                    style: TextStyle(
                        color: Color(0xffa29aac),
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              IconButton(
                  onPressed: () {
                    userController.logout();
                  },
                  icon: Icon(
                    Icons.output,
                    color: Colors.white,
                  ))
            ],
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Flexible(
          child: GridView.count(
              childAspectRatio: 1.0,
              padding: EdgeInsets.only(left: 16, right: 16),
              crossAxisCount: 2,
              crossAxisSpacing: 18,
              mainAxisSpacing: 18,
              children: myList.map((data) {
                return GestureDetector(
                  onTap: data.event,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(color),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          data.img,
                          width: 42,
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Text(
                          data.title,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          data.subtitle,
                          style: TextStyle(
                              color: Colors.white38,
                              fontSize: 10,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList()),
        )
      ]),
    );
  }
}

class Items {
  String title;
  String subtitle;
  Function()? event;
  String img;

  Items(
      {required this.title,
      required this.subtitle,
      required this.event,
      required this.img});
}
