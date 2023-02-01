import 'package:blood_bank_app/domain/entities/donor.dart';
import 'package:blood_bank_app/presentation/methode/shared_method.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

class NotFicationPage extends StatefulWidget {
  NotFicationPage(
      {required this.remoteMessage, required this.dateTime, super.key});
  RemoteNotification remoteMessage;
  DateTime dateTime;
  static const String routeName = "notfication_page";

  @override
  State<NotFicationPage> createState() => _NotFicationPageState();
}

class _NotFicationPageState extends State<NotFicationPage> {
  late Position position;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  getLocation() async {
    print(";;;;;;;;");
    await SharedMethod().checkGps();
    position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      print("++++++++++++++++++++++++++++++555");
      print(value.latitude);
      print(value.longitude);
      Fluttertoast.showToast(msg: widget.remoteMessage.body.toString());
      return value;
    });
    if (_firebaseAuth.currentUser != null) {
      await FirebaseFirestore.instance
          .collection('donors')
          .doc(_firebaseAuth.currentUser!.uid)
          .update({
        DonorFields.lat: position.latitude,
        DonorFields.lon: position.longitude
      }).then((value) async {
        print("okkkkkkkkkkkkkkkkkkkkkkkk");
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    // final RemoteNotification remoteMessager =
    //     ModalRoute.of(context)?.settings.arguments as RemoteNotification;

    print("object+++++++++++++++++++");
    print(widget.remoteMessage.title);
    print(FirebaseMessaging.instance.getToken().then(
          (value) => print(value),
        ));

    return Scaffold(
      appBar: AppBar(
        title: Text("الاشعارات"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Stack(
              children: [
                Container(
                  height: 160,
                  color: Color.fromARGB(255, 255, 251, 251),
                ),
                Positioned(
                    top: 50,
                    right: 10,
                    child: Image.asset(
                      "assets/images/boy.png",
                      height: 80,
                      width: 100,
                    )),
                Positioned(
                    top: 20, left: 60, child: Text("${widget.dateTime}")),
                Positioned(
                    bottom: 80,
                    right: 130,
                    child: Text(
                      "${widget.remoteMessage.title}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
                Positioned(
                    bottom: 50,
                    right: 130,
                    child: Text("${widget.remoteMessage.body}")),
                Positioned(top: 15, right: 40, child: Text("تاريخ ")),
                Positioned(
                    top: 5,
                    left: 0,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.close),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
