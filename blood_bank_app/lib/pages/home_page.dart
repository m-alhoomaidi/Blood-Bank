import 'package:blood_bank_app/cubit/profile_cubit/profile_cubit.dart';
import 'package:blood_bank_app/pages/edit_main_center_data.dart';
import 'package:blood_bank_app/pages/profile_center.dart';
import 'package:blood_bank_app/presentation/resources/strings_manager.dart';
import 'package:blood_bank_app/presentation/resources/values_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'setting_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:blood_bank_app/dependecy_injection.dart' as di;
import '../presentation/onboarding/introduction_page.dart';
import '../widgets/home/home_about.dart';
import '../widgets/home/home_welcome.dart';
import '../widgets/home/home_drawer/home_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String routeName = "/home";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin fltNotification =
      FlutterLocalNotificationsPlugin();
  final db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    // initMessaging();
    // FirebaseMessaging.onMessage.listen((event) {
    //   print("on backgrounnd");
    //   print(event.data);
    //   Fluttertoast.showToast(msg: event.data.values.first);
    // });
    // pushFCMtoken();
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
  // void pushFCMtoken() async {
  //   String? token = await messaging.getToken();
  //   print("======token=======");
  //   print(token);
  // }
  // void initMessaging() {
  //   var androiInit = const AndroidInitializationSettings('@mipmap/ic_launcher');
  //   var initSetting = InitializationSettings(android: androiInit);
  //   fltNotification = FlutterLocalNotificationsPlugin();
  //   fltNotification.initialize(initSetting);
  //   var androidDetails =
  //       const AndroidNotificationDetails('1', 'notification_channel_id');
  //   var generalNotificationDetails =
  //       NotificationDetails(android: androidDetails);
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     RemoteNotification? notification = message.notification;
  //     AndroidNotification? android = message.notification?.android;
  //     if (android != null) {
  //       fltNotification.show(notification.hashCode, notification?.title,
  //           notification?.body, generalNotificationDetails);
  //       print('notification initialized');
  //     }
  //   });
  // }
  // final List<String> tokens = [
  //   'fJTVExhUSKe581773y-BSD:APA91bGW8hwjQ2SIaNrGDZS4mICEBD3S1Vg2mNU6vunhQWQZDLThOGQv3FQ5jCYqoxravvX4XDs4WEYACgnKecqe0xVNwdXsx5AIejcsvr9kaaTq-vtreoBaw7Wgnr5aGOL1zy4FN8b3',
  //   'e_036JIcR7ei2e7SVOBYbl:APA91bFK_Ije-b8MiFRxKFN1yiwEwE9kvf2RFICGDeOjBm85NUMZ0UVt9yGmsmyjR313xPPoadPww0-AyNHzWJ0LwfEpM6dTZfTrlpQGGLpP16y0pYAJ77Y4sHWHeyLG9Wussp2B9v5d',
  // ];
  // Future<void> sendPushMessage() async {
  //   if (tokens.isEmpty) {
  //     print('Unable to send FCM message, no token exists.');
  //     return;
  //   }
  //   try {
  //     await http.post(
  //       Uri.parse('https://api.rnfirebase.io/messaging/send'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: constructFCMPayload(tokens[1]),
  //     );
  //     print('FCM request for device sent!');
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  // String constructFCMPayload(String? token) {
  //   return jsonEncode({
  //     'token': token,
  //     'data': {
  //       'via': 'FlutterFire Cloud Messaging!!!',
  //       'count': '_messageCount.toString()',
  //     },
  //     'notification': {
  //       'title': 'Hello FlutterFire!',
  //       'body': 'This notification (#_messageCount) was created via FCM!',
  //     },
  //   });
  // }
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
    bool firstTimeState = Hive.box(dataBoxName).get('introduction') ?? true;
    return firstTimeState
        ? const IntroductionPage()
        : Scaffold(
            appBar: AppBar(
              title: const Text(AppStrings.homeAppBarTitle),
              centerTitle: true,
              elevation: AppSize.s0,
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
                  SizedBox(height: AppSize.s20),
                ],
              ),
            ),
            drawer: const HomeDrower(),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.search_rounded),
              onPressed: () async {
                di.initProfile();
                BlocProvider.of<ProfileCubit>(context).getProfileCenterData();
                Navigator.pushNamed(context, ProfileCenterPage.routeName);
                // Get a new write batch
                // final batch = db.batch();
                // for (var donorJson in list) {
                //   var docRef = db.collection("donors").doc();
                //   batch.set(docRef, donorJson);
                // }
                // batch.commit().then((_) {
                //   print("======commit=done======");
                // });
                // Navigator.of(context).pushNamed(SearchPage.routeName);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute<void>(
                //     builder: (BuildContext context) => const SearchMapPage(),
                //   ),
                // );
                // Navigator.of(context).pushNamed(OnBoardingView.routeName);
                // LocationPoint point1 = LocationPoint(
                //       lat: 13.9585003,
                //       lon: 44.1709884,
                //     ),
                //     point2 = LocationPoint(
                //       lat: 13.9556071,
                //       lon: 44.1708585,
                //     );
                // print(getNearbyPoints(
                //   base: point1,
                //   points: [point2],
                //   distanceKm: 0.4,
                // ).length); // 0.3220144142025769
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

//   List list = jsonDecode('''[
//      {
//         "image": "",
//         "is_gps_on": "1",
//         "gender": "male",
//         "is_shown_phone": "1",
//         "brith_date": "",
//         "lon": "44.16640231857082",
//         "password": "123456",
//         "is_shown": "1",
//         "phone": "714296685",
//         "blood_type": "O-",
//         "district": "العدين",
//         "lat": "13.95925347982098",
//         "name": "Ezz",
//         "state": "إب",
//         "neighborhood": "Alsarrah",
//         "id": "WL5996o2WbQwld7YJol11znInkq1",
//         "email": "e@g.com"
//     },
//     {
//         "image": "",
//         "is_gps_on": "1",
//         "gender": "male",
//         "is_shown_phone": "1",
//         "brith_date": "",
//         "lon": "44.16278508375451",
//         "password": "123456",
//         "is_shown": "1",
//         "phone": "714296685",
//         "blood_type": "O-",
//         "district": "العدين",
//         "lat": "13.974279144008882",
//         "name": "Ezz",
//         "state": "إب",
//         "neighborhood": "Annah",
//         "id": "WL5996o2WbQwld7YJol11znInkq1",
//         "email": "e@g.com"
//     },
//      {
//         "image": "",
//         "is_gps_on": "1",
//         "gender": "male",
//         "is_shown_phone": "1",
//         "brith_date": "",
//         "lon": "44.157411483548415",
//         "password": "123456",
//         "is_shown": "1",
//         "phone": "714296685",
//         "blood_type": "A+",
//         "district": "الظهار",
//         "lat": "13.971609757586048",
//         "name": "Ezz",
//         "state": "إب",
//         "neighborhood": "Alsabal",
//         "id": "WL5996o2WbQwld7YJol11znInkq1",
//         "email": "e@g.com"
//     },
//    {
//         "image": "",
//         "is_gps_on": "1",
//         "gender": "male",
//         "is_shown_phone": "1",
//         "brith_date": "",
//         "lon": "44.1669924226502",
//         "password": "123456",
//         "is_shown": "1",
//         "phone": "714296685",
//         "blood_type": "O+",
//         "district": "الظهار",
//         "lat": "13.950156735486098",
//         "name": "Ezz",
//         "state": "إب",
//         "neighborhood": "Harathah",
//         "id": "WL5996o2WbQwld7YJol11znInkq1",
//         "email": "e@g.com"
//     },
//      {
//         "image": "",
//         "is_gps_on": "1",
//         "gender": "male",
//         "is_shown_phone": "1",
//         "brith_date": "",
//         "lon": "44.18167133616689",
//         "password": "123456",
//         "is_shown": "1",
//         "phone": "714296685",
//         "blood_type": "O+",
//         "district": "الظهار",
//         "lat": "13.959390106818676",
//         "name": "Ezz",
//         "state": "إب",
//         "neighborhood": "Qihzah",
//         "id": "WL5996o2WbQwld7YJol11znInkq1",
//         "email": "e@g.com"
//     },
//  {
//         "image": "",
//         "is_gps_on": "1",
//         "gender": "male",
//         "is_shown_phone": "1",
//         "brith_date": "",
//         "lon": "44.193828479571074",
//         "password": "123456",
//         "is_shown": "1",
//         "phone": "714296685",
//         "blood_type": "A+",
//         "district": "شرعب السلام",
//         "lat": "13.964835321745667",
//         "name": "Ezz",
//         "state": "تعز",
//         "neighborhood": "Altibha",
//         "id": "WL5996o2WbQwld7YJol11znInkq1",
//         "email": "e@g.com"
//     }
// ]
// ''');

// const data = [
//   {
//     coords: {
//       lat: 13.974279144008882,
//       lng: 44.16278508375451,
//     },
//     name: "محمد",
//     bloodType: "O+",
//     phoneNumber: "771511569",
//   },
//   {
//     coords: {
//       lat: 13.95925347982098,
//       lng: 44.16640231857082,
//     },
//     name: "سامي",
//     bloodType: "O+",
//     phoneNumber: "771511542",
//   },
//   {
//     coords: {
//       lat: 13.971609757586048,
//       lng: 44.157411483548415,
//     },
//     name: "خالد",
//     bloodType: "O-",
//     phoneNumber: "715015696",
//   },
//   {
//     coords: {
//       lat: 13.950156735486098,
//       lng: 44.1669924226502,
//     },
//     name: "علي",
//     bloodType: "A+",
//     phoneNumber: "717015690",
//   },
//   {
//     coords: {
//       lat: 13.959390106818676,
//       lng: 44.18167133616689,
//     },
//     name: "سامي",
//     bloodType: "B+",
//     phoneNumber: "71501569",
//   },
//   {
//     coords: {
//       lat: 13.964835321745667,
//       lng: 44.193828479571074,
//     },
//     name: "راشد",
//     bloodType: "O+",
//     phoneNumber: "715017569",
//   },
//   {
//     coords: {
//       lat: 13.98106343411635,
//       lng: 44.18574205386784,
//     },
//     name: "سعيد",
//     bloodType: "O-",
//     phoneNumber: "715017569",
//   },
//   {
//     coords: {
//       lat: 13.974390828998246,
//       lng: 44.17589531780745,
//     },
//     name: "سالم",
//     bloodType: "AB-",
//     phoneNumber: "715017569",
//   },
//   {
//     coords: {
//       lat: 13.953817127862079,
//       lng: 44.172464266417265,
//     },
//     name: "خليل",
//     bloodType: "A+",
//     phoneNumber: "715017569",
//   },
//   {
//     coords: {
//       lat: 13.920863446490008,
//       lng: 44.173475415106225,
//     },
//     name: "أشرف",
//     bloodType: "O+",
//     phoneNumber: "715017569",
//   },
// ];

//   function getDistanceFromLatLonInKm(lat1,lon1,lat2,lon2) {
// }
// function deg2rad(deg) {
//   return deg * (Math.PI/180)
// }

  // List<LocationPoint> getNearbyPoints({
  //   required LocationPoint base,
  //   required List<LocationPoint> points,
  //   required double distanceKm,
  // }) {
  //   List<LocationPoint> nearPoints = [];
  //   for (var point in points) {
  //     double far = getDistanceFromLatLonInKM(point1: base, point2: point);
  //     print(far);
  //     print(distanceKm);
  //     if (far < distanceKm) {
  //       nearPoints.add(point);
  //     }
  //   }
  //   return nearPoints;
  // }

  // getDistanceFromLatLonInKM({
  //   required LocationPoint point1,
  //   required LocationPoint point2,
  // }) {
  //   var R = 6371; // Radius of the earth in km
  //   var dLat = deg2rad(point2.lat - point1.lat); // deg2rad below
  //   var dLon = deg2rad(point2.lon - point1.lon);
  //   var a = math.sin(dLat / 2) * math.sin(dLat / 2) +
  //       math.cos(deg2rad(point1.lat)) *
  //           math.cos(deg2rad(point2.lat)) *
  //           math.sin(dLon / 2) *
  //           math.sin(dLon / 2);
  //   var c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
  //   var d = R * c; // Distance in km
  //   return d;
  // }

  // deg2rad(deg) {
  //   return deg * (math.pi / 180);
  // }
}
