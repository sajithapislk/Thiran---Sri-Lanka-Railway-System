import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TrainFindScreen extends StatefulWidget {
  const TrainFindScreen({Key? key}) : super(key: key);

  @override
  State<TrainFindScreen> createState() => _TrainFindScreenState();
}

class _TrainFindScreenState extends State<TrainFindScreen> {
  final _formKey = GlobalKey<FormState>();

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
                  TextFormField(
                    decoration: InputDecoration(labelText: 'To'),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'From'),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Date'),
                  ),
                  Container(
                    margin: EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return Stack(
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
                    )
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
