// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:math' as math;

import 'package:blood_bank_app/presentation/methode/shared_method.dart';

import '../../domain/entities/blood_types.dart';
import '../../domain/entities/donor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../cubit/search_cubit/search_cubit.dart';
import 'package:location/location.dart' as loc;

import '../widgets/home/home_drawer/home_drawer.dart';
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
  bool hasCurrentLocation = false;
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";
  late StreamSubscription<Position> positionStream;
  final UrlLauncherPlatform launcher = UrlLauncherPlatform.instance;
  var location = loc.Location();

  @override
  void initState() {
    checkGps();
    super.initState();
  }

  refreshDeviceLocation() async {
    loc.Location location = loc.Location();
    location.getLocation().then(
      (location) {
        location = location;
      },
    );
    GoogleMapController googleMapController = await _mapcontroller.future;
    location.onLocationChanged.listen(
      (newLoc) {
        final currentLocation = newLoc;
        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 13.5,
              target: LatLng(
                newLoc.latitude!,
                newLoc.longitude!,
              ),
            ),
          ),
        );
        setState(() {});
      },
    );
  }

  checkGps() async {
    servicestatus = await location.serviceEnabled();
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
        getLocation();
      }
    } else {
      if (!await location.serviceEnabled()) {
        await location.requestService();
        checkGps();
      }
      if (kDebugMode) {
        print("GPS Service is not enabled, turn on GPS location");
      }
    }
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
      hasCurrentLocation = true;
    });
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high, //accuracy of the location data
      distanceFilter: 100, //minimum distance (measured in meters) a
    );
    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      long = position.longitude.toString();
      lat = position.latitude.toString();
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
            String selectedBloodType =
                BlocProvider.of<SearchCubit>(context).selectedBloodType!;
            List<Donor> suitableDonors = state.donorsInState
                .where((donor) =>
                    BloodTypes.canReceiveFrom(bloodType: selectedBloodType)
                        .contains(donor.bloodType))
                .toList();
            for (var donor in suitableDonors) {
              listPorin.add(RecivePoint(
                lat: double.tryParse(donor.lat) ?? 0.0,
                lon: double.tryParse(donor.lon) ?? 0.0,
                name: donor.name,
                phone: donor.phone,
                bloodType: donor.bloodType,
              ));
            }
          }

          RecivePoint me = RecivePoint(
            lat: 13.9585005, //currentLatLon.latitude,
            lon: 44.1709885, //currentLatLon.longitude,
            name: "أنا",
            bloodType: "",
            phone: "",
          );

          // print("===========points length before filtering");
          // print(listPorin.length);

          // Filtering Points
          deg2rad(deg) {
            return deg * (math.pi / 180);
          }

          getDistanceFromLatLonInKM({
            required RecivePoint point1,
            required RecivePoint point2,
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

          List<RecivePoint> getNearbyPoints({
            required RecivePoint base,
            required List<RecivePoint> points,
            required double distanceKm,
          }) {
            List<RecivePoint> nearPoints = [];
            print(distanceKm);
            for (var point in points) {
              double far =
                  getDistanceFromLatLonInKM(point1: base, point2: point);
              print("========far====distanceKm=====");
              print(far);
              if (far < distanceKm) {
                nearPoints.add(point);
              }
            }
            return nearPoints;
          }

          listPorin =
              getNearbyPoints(base: me, points: listPorin, distanceKm: 5.0);

          final List<Marker> _markBrach =
              List<Marker>.generate(listPorin.length, (index) {
            return Marker(
              markerId: MarkerId("$index"),
              position: LatLng(listPorin[index].lat, listPorin[index].lon),
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
                title: listPorin[index].bloodType,
                snippet:
                    "${listPorin[index].name} • 📞 ${listPorin[index].phone}",
              ),
            );
          });

          _marker.addAll(_markBrach);
          return (hasCurrentLocation)
              ? GoogleMap(
                  markers: Set<Marker>.of(_marker),

                  // onMapCreated: ((GoogleMapController controller) {
                  //   _mapcontroller.complete(controller);
                  // }),

                  initialCameraPosition: CameraPosition(
                      target: LatLng(position.latitude, position.longitude),
                      zoom: 13.5),
                  polylines: {
                    Polyline(
                        polylineId: const PolylineId("route"),
                        points: polylinCoordinates,
                        color: Colors.black)
                  },
                )
              : const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      "يرجى تشغيل الموقع GPS ومنح صلاحية للوصول إلى الموقع",
                      textAlign: TextAlign.center,
                      style: TextStyle(height: 1.5),
                    ),
                  ),
                );
        },
      ),
      drawer: const HomeDrower(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search_rounded),
        onPressed: () async {
          position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);
          if (kDebugMode) {
            print(position.longitude); //Output: 80.24599079
            print(position.latitude); //Output: 29.6593457
          }

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
  double lat;
  double lon;
  String name;
  String bloodType;
  String phone;

  RecivePoint({
    required this.lat,
    required this.lon,
    required this.name,
    required this.bloodType,
    required this.phone,
  });
}
