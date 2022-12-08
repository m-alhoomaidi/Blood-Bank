import 'dart:async';

import 'package:blood_bank_app/shared/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import '../widgets/home_drawer/home_drawer.dart';
import '../widgets/home/home_about.dart';
import '../widgets/home/home_welcome.dart';

class SearchMapPage extends StatefulWidget {
  const SearchMapPage({Key? key}) : super(key: key);
  static const String routeName = "search_map";

  @override
  State<SearchMapPage> createState() => _SearchMapPageState();
}

class _SearchMapPageState extends State<SearchMapPage> {
  final Completer<GoogleMapController> _mapcontroller = Completer();

  static const CameraPosition _center =
      CameraPosition(target: LatLng(13.9583, 44.1709), zoom: 14);

  final List<Marker> _marker = [];
  final List<Marker> _branch = const [
    Marker(
        markerId: MarkerId("1"),
        position: LatLng(37.421998333333335, -122.08400000000002),
        infoWindow: InfoWindow(title: "tayeb")),
    Marker(
        markerId: MarkerId("2"),
        position: LatLng(37.421998333333335, -122.08400000000002),
        infoWindow: InfoWindow(title: "ali"))
  ];

  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";
  late StreamSubscription<Position> positionStream;

  @override
  void initState() {
    // _marker.addAll(_branch);
    checkGps();
    getPolyPoints();
    super.initState();
  }

  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          print("'Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        setState(() {
          //refresh the UI
        });

        getLocation();
      }
    } else {
      print("GPS Service is not enabled, turn on GPS location");
    }

    setState(() {
      //refresh the UI
    });
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position.longitude); //Output: 80.24599079
    print(position.latitude); //Output: 29.6593457

    long = position.longitude.toString();
    lat = position.latitude.toString();

    setState(() {
      //refresh UI
    });

    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high, //accuracy of the location data
      distanceFilter: 100, //minimum distance (measured in meters) a
      //device must move horizontally before an update event is generated;
    );

    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      print(position.longitude); //Output: 80.24599079
      print(position.latitude); //Output: 29.6593457

      long = position.longitude.toString();
      lat = position.latitude.toString();

      setState(() {
        //refresh UI on update
      });
    });
  }

//-----------------------------------------------------
  static const LatLng sourcelocation = LatLng(13.9585003, 44.1709884);
  static const LatLng destination = LatLng(13.9672166, 44.1635721);
  List<LatLng> polylinCoordinates = [];

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyCl1B3ibzOgquh5yV9lRRmYd1Yf4uE1Yf8",
      PointLatLng(sourcelocation.latitude, sourcelocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylinCoordinates.add(LatLng(point.latitude, point.longitude));
        print("++++++++++++++++++++++++++++++");
        print(result);
        setState(() {});
      });
    } else {
      print("----------------------------");
      print(result.errorMessage);
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
      body: GoogleMap(
        // markers: Set<Marker>.of(_marker),
        // onMapCreated: ((GoogleMapController controller) {
        //   _mapcontroller.complete(controller);
        // }),
        initialCameraPosition:
            const CameraPosition(target: sourcelocation, zoom: 10.5),
        polylines: {
          Polyline(
              polylineId: PolylineId("route"),
              points: polylinCoordinates,
              color: Colors.black)
        },
        markers: {
          Marker(
            markerId: MarkerId("source"),
            position: sourcelocation,
          ),
          Marker(
            markerId: MarkerId("destination"),
            position: destination,
          )
        },
      ),
      drawer: const HomeDrower(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search_rounded),
        onPressed: () async {
          getPolyPoints();
          position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);
          print(position.longitude); //Output: 80.24599079
          print(position.latitude); //Output: 29.6593457

          long = position.longitude.toString();
          lat = position.latitude.toString();

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
          // // Navigator.of(context).pushNamed(SearchPage.routeName);
        },
      ),
    );
  }
}
