import 'dart:convert';

import 'dart:math' as math;
import 'package:blood_bank_app/models/location_point.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../widgets/home/home_about.dart';
import '../widgets/home/home_welcome.dart';
import '../widgets/home_drawer/home_drawer.dart';
import 'search_map.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String routeName = "home";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin fltNotification =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    pushFCMtoken();
    initMessaging();
    FirebaseMessaging.onMessage.listen((event) {
      print("on backgrounnd");
      print(event.data);
      Fluttertoast.showToast(msg: event.data.values.first);
    });
    // LocationManager().interval = 1;
    // LocationManager().distanceFilter = 0;
    // LocationManager().notificationTitle = 'CARP Location Example';
    // LocationManager().notificationMsg = 'CARP is tracking your location';
    // _requestPermission();
    // location.changeSettings(
    //     interval: 1000, accuracy: loc.LocationAccuracy.high);
    // location.enableBackgroundMode(enable: true);
  }

// From Meduim "Push Notification In Flutter in Background"

  void pushFCMtoken() async {
    String? token = await messaging.getToken();
    print(token);
  }

  void initMessaging() {
    var androiInit = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initSetting = InitializationSettings(android: androiInit);
    fltNotification = FlutterLocalNotificationsPlugin();
    fltNotification.initialize(initSetting);
    var androidDetails =
        const AndroidNotificationDetails('1', 'notification_channel_id');
    var generalNotificationDetails =
        NotificationDetails(android: androidDetails);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (android != null) {
        fltNotification.show(notification.hashCode, notification?.title,
            notification?.body, generalNotificationDetails);
        print('notification initialized');
      }
    });
  }

  final List<String> tokens = [
    'fJTVExhUSKe581773y-BSD:APA91bGW8hwjQ2SIaNrGDZS4mICEBD3S1Vg2mNU6vunhQWQZDLThOGQv3FQ5jCYqoxravvX4XDs4WEYACgnKecqe0xVNwdXsx5AIejcsvr9kaaTq-vtreoBaw7Wgnr5aGOL1zy4FN8b3',
    'e_036JIcR7ei2e7SVOBYbl:APA91bFK_Ije-b8MiFRxKFN1yiwEwE9kvf2RFICGDeOjBm85NUMZ0UVt9yGmsmyjR313xPPoadPww0-AyNHzWJ0LwfEpM6dTZfTrlpQGGLpP16y0pYAJ77Y4sHWHeyLG9Wussp2B9v5d',
  ];

  Future<void> sendPushMessage() async {
    if (tokens.isEmpty) {
      print('Unable to send FCM message, no token exists.');
      return;
    }

    try {
      await http.post(
        Uri.parse('https://api.rnfirebase.io/messaging/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: constructFCMPayload(tokens[1]),
      );
      print('FCM request for device sent!');
    } catch (e) {
      print(e);
    }
  }

  String constructFCMPayload(String? token) {
    return jsonEncode({
      'token': token,
      'data': {
        'via': 'FlutterFire Cloud Messaging!!!',
        'count': '_messageCount.toString()',
      },
      'notification': {
        'title': 'Hello FlutterFire!',
        'body': 'This notification (#_messageCount) was created via FCM!',
      },
    });
  }

  // _requestPermission() async {
  //   var status = await Permission.location.request();
  //   if (status.isGranted) {
  //     print('done');
  //   } else if (status.isDenied) {
  //     _requestPermission();
  //   } else if (status.isPermanentlyDenied) {
  //     openAppSettings();
  //   }
  // }
  // Future<Position> getLocation() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     return Future.error('Location services are disabled.');
  //   }
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error('Location permissions are denied');
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     return Future.error('Please Turn on Location permissions manually');
  //   }
  //   return await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  // }
  // final loc.Location location = loc.Location();
  // StreamSubscription<loc.LocationData>? _locationSubscription;
  // Future<void> _listenLocation() async {
  //   try {
  //     _locationSubscription = location.onLocationChanged.handleError((onError) {
  //       print(onError);
  //       _locationSubscription?.cancel();
  //       setState(() {
  //         _locationSubscription = null;
  //       });
  //     }).listen((loc.LocationData currentlocation) async {
  //       print('=========================');
  //       print(currentlocation.altitude);
  //       print(currentlocation.longitude);
  //     });
  //   } catch (e) {
  //     print('Error: -----');
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("بنك الدم الإلكتروني"),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async {},
            icon: const Icon(
              Icons.notifications,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            HomeWelcome(),
            HomeAbout(),
            SizedBox(height: 20),
          ],
        ),
      ),
      drawer: const HomeDrower(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search_rounded),
        onPressed: () async {
          // Navigator.of(context).pushNamed(SearchPage.routeName);
          // Navigator.push(
          //   context,
          //   MaterialPageRoute<void>(
          //     builder: (BuildContext context) => const SearchMapPage(),
          //   ),
          // );
          LocationPoint point1 = LocationPoint(
                lat: 13.9585003,
                lon: 44.1709884,
              ),
              point2 = LocationPoint(
                lat: 13.9556071,
                lon: 44.1708585,
              );
          print(getNearbyPoints(
            base: point1,
            points: [point2],
            distanceKm: 0.4,
          ).length); // 0.3220144142025769

          // // get the current location
          // await LocationManager().getCurrentLocation();
          // // start listen to location updates
          // StreamSubscription<LocationDto> locationSubscription =
          //     LocationManager().locationStream.listen((LocationDto dto) {
          //   print('======================');
          //   print(dto.altitude);
          //   print(dto.longitude);
          // });
          // // cancel listening and stop the location manager
          // locationSubscription.cancel();
          // LocationManager().stop();
        },
      ),
    );
  }

// function getDistanceFromLatLonInKm(lat1,lon1,lat2,lon2) {
// }
// function deg2rad(deg) {
//   return deg * (Math.PI/180)
// }

  List<LocationPoint> getNearbyPoints({
    required LocationPoint base,
    required List<LocationPoint> points,
    required double distanceKm,
  }) {
    List<LocationPoint> nearPoints = [];
    for (var point in points) {
      double far =getDistanceFromLatLonInKM(point1: base, point2: point);
      print(far);
      print(distanceKm);
      if ( far < distanceKm) {
        nearPoints.add(point);
      }
    }
    return nearPoints;
  }

  getDistanceFromLatLonInKM({
    required LocationPoint point1,
    required LocationPoint point2,
  }) {
    var R = 6371; // Radius of the earth in km
    var dLat = deg2rad(point2.lat - point1.lat); // deg2rad below
    var dLon = deg2rad(point2.lon - point1.lon);
    var a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(deg2rad(point1.lat)) *
            math.cos(deg2rad(point2.lat)) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);
    var c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    var d = R * c; // Distance in km
    return d;
  }

  deg2rad(deg) {
    return deg * (math.pi / 180);
  }
}
