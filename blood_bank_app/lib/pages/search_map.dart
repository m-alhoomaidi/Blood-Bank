// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:blood_bank_app/cubit/search_cubit/search_cubit.dart';

import '../widgets/home_drawer/home_drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

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
  final UrlLauncherPlatform launcher = UrlLauncherPlatform.instance;

  @override
  void initState() {
    checkGps();
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
      body: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          List<RecivePoint> listPorin = [];
          if (state is SearchSuccess) {
            for (var donor in state.donors) {
              listPorin.add(RecivePoint(
                  latitude: donor.lat,
                  longitude: donor.lon,
                  name: donor.name,
                  phone: donor.phone,
                  bloodType: donor.bloodType));
            }
          }
          final List<Marker> _markBrach =
              List<Marker>.generate(listPorin.length, (index) {
            return Marker(
              markerId: MarkerId("${index}"),
              position: LatLng(double.tryParse(listPorin[index].latitude)!,
                  double.tryParse(listPorin[index].longitude)!),
              infoWindow: InfoWindow(
                onTap: () async {
                  final Uri launchUri = Uri(
                    scheme: 'tel',
                    path: listPorin[index].phone,
                  );
                  await launcher.launch(
                    launchUri.toString(),
                    useSafariVC: false,
                    useWebView: false,
                    enableJavaScript: false,
                    enableDomStorage: false,
                    universalLinksOnly: true,
                    headers: <String, String>{},
                  );
                },
                title: "${listPorin[index].bloodType}",
                snippet:
                    "${listPorin[index].name} • 📞 ${listPorin[index].phone}",
              ),
            );
          });

          _marker.addAll(_markBrach);
          return GoogleMap(
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
          );
        },
      ),
      drawer: const HomeDrower(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search_rounded),
        onPressed: () async {
          if (kDebugMode) {
            print("++++++++++++++++++++");

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
}
// listPorin = [
//   RecivePoint(latitude: "13.9585003", longitude: '44.1709884'),
//   RecivePoint(latitude: "13.9585003", longitude: '44.1709884'),
//   RecivePoint(latitude: "13.9556008", longitude: '44.1708603'),
//   RecivePoint(latitude: "13.9556071", longitude: '44.1708585'),
// ];

class RecivePoint {
  String latitude;
  String longitude;
  String name;
  String bloodType;
  String phone;

  RecivePoint({
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.bloodType,
    required this.phone,
  });
}
