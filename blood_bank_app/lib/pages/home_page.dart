import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';
import '../widgets/home_drawer/home_drawer.dart';
import '../widgets/home/home_about.dart';
import '../widgets/home/home_welcome.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String routeName = "home";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _requestPermission();
    location.changeSettings(
        interval: 1000, accuracy: loc.LocationAccuracy.high);
    location.enableBackgroundMode(enable: true);
  }

  _requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      print('done');
    } else if (status.isDenied) {
      _requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  Future<Position> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Please Turn on Location permissions manually');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;

  Future<void> _listenLocation() async {
    try {
      _locationSubscription = location.onLocationChanged.handleError((onError) {
        print(onError);
        _locationSubscription?.cancel();
        setState(() {
          _locationSubscription = null;
        });
      }).listen((loc.LocationData currentlocation) async {
        print('=========================');
        print(currentlocation.altitude);
        print(currentlocation.longitude);
      });
    } catch (e) {
      print('Error: -----');
      print(e);
    }
  }

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
        onPressed: () {
          _listenLocation();
          print('object');
          // Navigator.of(context).pushNamed(SearchPage.routeName);
        },
      ),
    );
  }
}
