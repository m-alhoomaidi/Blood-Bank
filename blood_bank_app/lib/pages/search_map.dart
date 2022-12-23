import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../widgets/home_drawer/home_drawer.dart';

class SearchMapPage extends StatefulWidget {
  const SearchMapPage({Key? key}) : super(key: key);
  static const String routeName = "search_map";

  @override
  State<SearchMapPage> createState() => _SearchMapPageState();
}

class _SearchMapPageState extends State<SearchMapPage> {
  final Completer<GoogleMapController> _mapcontroller = Completer();

  final List<Marker> _marker = [];

//---------------------------------

//--------------------------
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";
  late StreamSubscription<Position> positionStream;

  @override
  void initState() {
    checkGps();
    _marker.addAll(_markBrach);
    // getPolyPoints();
    super.initState();
  }

  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          if (kDebugMode) {
            print('Location permissions are denied');
          }
        } else if (permission == LocationPermission.deniedForever) {
          if (kDebugMode) {
            print("'Location permissions are permanently denied");
          }
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
      if (kDebugMode) {
        print("GPS Service is not enabled, turn on GPS location");
      }
    }

    setState(() {
      //refresh the UI
    });
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    if (kDebugMode) {
      print(position.longitude); //Output: 80.24599079
      print(position.latitude); //Output: 29.6593457
    }

    long = position.longitude.toString();
    lat = position.latitude.toString();

    setState(() {
      //refresh UI
    });

    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high, //accuracy of the location data
      distanceFilter: 100, //minimum distance (measured in meters) a
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
  static const LatLng sourcelocation = LatLng(13.9585005, 44.1709885);
  static const LatLng destination = LatLng(13.9672166, 44.1635721);
  List<LatLng> polylinCoordinates = [];

  // void getPolyPoints() async {
  //   PolylinePoints polylinePoints = PolylinePoints();
  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //     "AIzaSyCl1B3ibzOgquh5yV9lRRmYd1Yf4uE1Yf8",
  //     PointLatLng(sourcelocation.latitude, sourcelocation.longitude),
  //     PointLatLng(destination.latitude, destination.longitude),
  //   );
  //   if (result.points.isNotEmpty) {
  //     result.points.forEach((PointLatLng point) {
  //       polylinCoordinates.add(LatLng(point.latitude, point.longitude));
  //       setState(() {});
  //     });
  //   } else {
  //     if (kDebugMode) {
  //       print("----------------------------");
  //       print(result.errorMessage);
  //     }
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
      body: GoogleMap(
        markers: Set<Marker>.of(_marker),

        // onMapCreated: ((GoogleMapController controller) {
        //   _mapcontroller.complete(controller);
        // }),

        initialCameraPosition:
            const CameraPosition(target: sourcelocation, zoom: 13.5),
        polylines: {
          Polyline(
              polylineId: const PolylineId("route"),
              points: polylinCoordinates,
              color: Colors.black)
        },
      ),
      drawer: const HomeDrower(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search_rounded),
        onPressed: () async {
          if (kDebugMode) {
            print("++++++++++++++++++++");
            print(_listPorin[0].latitude);
            print("===============================");
            print(_markBrach.length);
            print("0000000000000000000000000000000000");
          }

          // getPolyPoints();
          position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);
          if (kDebugMode) {
            print(position.longitude); //Output: 80.24599079
            print(position.latitude); //Output: 29.6593457
          }

          // long = position.longitude.toString();
          // lat = position.latitude.toString();
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

  final List<Marker> _markBrach =
      List<Marker>.generate(_listPorin.length, (index) {
    return Marker(
      markerId: MarkerId("${index}"),
      position: LatLng(double.tryParse(_listPorin[index].latitude)!,
          double.tryParse(_listPorin[index].longitude)!),
      infoWindow: InfoWindow(title: "mohammed+ ${index}"),
    );
  });
}

final List<RecivePoint> _listPorin = [
  RecivePoint(latitude: "13.9585003", longitude: '44.1709884'),
  RecivePoint(latitude: "13.9585003", longitude: '44.1709884'),
  RecivePoint(latitude: "13.9556008", longitude: '44.1708603'),
  RecivePoint(latitude: "13.9556071", longitude: '44.1708585'),
];

class RecivePoint {
  String latitude;
  String longitude;

  RecivePoint({required this.latitude, required this.longitude});
}
