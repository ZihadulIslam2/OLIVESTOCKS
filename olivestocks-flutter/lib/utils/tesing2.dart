// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:permission_handler/permission_handler.dart';
// //import 'package:flutter_tts/flutter_tts.dart';
//
// class NavigationScreen extends StatefulWidget {
//   @override
//   _NavigationScreenState createState() => _NavigationScreenState();
// }
//
// class _NavigationScreenState extends State<NavigationScreen> {
//   GoogleMapController? _controller;
//   LatLng? _userLocation;
//   List<dynamic> _steps = [];
//   String _currentInstruction = "";
//   double _distanceToNextTurn = 0.0;
//   String _eta = "--";
//   String _totalTime = "--";
//   double _speedLimit = 50.0; // Example speed limit in km/h
//   //FlutterTts _tts = FlutterTts();
//   List<LatLng> _routePoints = [];
//   Set<Polyline> _polylines = {};
//   Set<Marker> _markers = {};
//
//   final LatLng _startPoint = LatLng(23.7657892, 90.4268089);
//   final LatLng _endPoint = LatLng(23.7821, 90.4161);
//   final String _googleApiKey = "AIzaSyBxA6N8pU61iOKdCVfphQCpV4VC907uT94";
//
//   @override
//   void initState() {
//     super.initState();
//     _requestPermissions();
//   }
//
//   Future<void> _requestPermissions() async {
//     var status = await Permission.location.request();
//     if (status.isGranted) {
//       _startTracking();
//       _getRoute();
//     } else {
//       print("Location permission denied.");
//     }
//   }
//
//   Future<void> _getRoute() async {
//     String url =
//         "https://maps.googleapis.com/maps/api/directions/json?origin=${_startPoint.latitude},${_startPoint.longitude}&destination=${_endPoint.latitude},${_endPoint.longitude}&mode=driving&key=$_googleApiKey";
//
//     final response = await http.get(Uri.parse(url));
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       if (data['routes'].isNotEmpty) {
//         setState(() {
//           _steps = data['routes'][0]['legs'][0]['steps'];
//           _eta = data['routes'][0]['legs'][0]['duration']['text'];
//           _totalTime = data['routes'][0]['legs'][0]['duration']['text'];
//           _updateNavigationInfo();
//           _routePoints =
//               _decodePolyline(data['routes'][0]['overview_polyline']['points']);
//           _polylines = {
//             Polyline(
//               polylineId: PolylineId("route"),
//               points: _routePoints,
//               color: Colors.blue,
//               width: 5,
//             ),
//           };
//           _markers = {
//             Marker(
//               markerId: MarkerId("start"),
//               position: _startPoint,
//               icon: BitmapDescriptor.defaultMarkerWithHue(
//                   BitmapDescriptor.hueBlue),
//             ),
//             Marker(
//               markerId: MarkerId("end"),
//               position: _endPoint,
//               icon: BitmapDescriptor.defaultMarkerWithHue(
//                   BitmapDescriptor.hueGreen),
//             ),
//           };
//         });
//       }
//     } else {
//       print("Error fetching directions: ${response.statusCode}");
//     }
//   }
//
//   List<LatLng> _decodePolyline(String encoded) {
//     List<LatLng> points = [];
//     int index = 0, len = encoded.length;
//     int lat = 0, lng = 0;
//     while (index < len) {
//       int shift = 0, result = 0;
//       do {
//         result = encoded.codeUnitAt(index++) - 63;
//         lat += (result & 0x1F) << shift;
//         shift += 5;
//       } while (result >= 0x20);
//       shift = 0;
//       result = 0;
//       do {
//         result = encoded.codeUnitAt(index++) - 63;
//         lng += (result & 0x1F) << shift;
//         shift += 5;
//       } while (result >= 0x20);
//       points.add(LatLng(
//         (lat & 1 != 0 ? ~(lat >> 1) : lat >> 1) / 1E5,
//         (lng & 1 != 0 ? ~(lng >> 1) : lng >> 1) / 1E5,
//       ));
//       lat = 0;
//       lng = 0;
//     }
//     return points;
//   }
//
//   void _startTracking() {
//     Geolocator.getPositionStream(
//       locationSettings: LocationSettings(
//         accuracy: LocationAccuracy.bestForNavigation,
//         distanceFilter: 5,
//       ),
//     ).listen((Position position) {
//       LatLng newPosition = LatLng(position.latitude, position.longitude);
//       double speed = position.speed * 3.6;
//       setState(() {
//         _userLocation = newPosition;
//         _updateNavigationInfo();
//         _markers.add(
//           Marker(
//             markerId: MarkerId("user"),
//             position: newPosition,
//             icon: BitmapDescriptor.defaultMarkerWithHue(
//                 BitmapDescriptor.hueRed),
//           ),
//         );
//         if (speed > _speedLimit) {
//           //_tts.speak("You are exceeding the speed limit!");
//         }
//       });
//     });
//   }
//
//   void _updateNavigationInfo() {
//     if (_steps.isNotEmpty && _userLocation != null) {
//       for (var step in _steps) {
//         double lat = step['end_location']['lat'];
//         double lng = step['end_location']['lng'];
//         double distance = Geolocator.distanceBetween(
//           _userLocation!.latitude,
//           _userLocation!.longitude,
//           lat,
//           lng,
//         );
//
//         if (distance < 30) { // Consider a turn within 30m
//           _currentInstruction = step['html_instructions']
//               .replaceAll(RegExp(r'<[^>]*>'), ''); // Remove HTML tags
//           _distanceToNextTurn = distance;
//
//           // Speak the instruction using Text-to-Speech
//           //_tts.speak(_currentInstruction);
//           break;
//         }
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           GoogleMap(
//             onMapCreated: (GoogleMapController controller) {
//               _controller = controller;
//             },
//             initialCameraPosition: CameraPosition(
//               target: _startPoint,
//               zoom: 14.0,
//             ),
//             myLocationEnabled: true,
//             myLocationButtonEnabled: false,
//             polylines: _polylines,
//             markers: _markers,
//           ),
//           Positioned(
//             top: 40,
//             left: 20,
//             right: 20,
//             child: Container(
//               padding: EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.black.withOpacity(0.7),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Column(
//                 children: [
//                   Text(
//                     "$_currentInstruction",
//                     style: TextStyle(color: Colors.white, fontSize: 18),
//                     textAlign: TextAlign.center,
//                   ),
//                   Text("Next Turn: ${_distanceToNextTurn.toStringAsFixed(1)} m"),
//                   Text("ETA: $_eta"),
//                   Text("Total Time: $_totalTime"),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
