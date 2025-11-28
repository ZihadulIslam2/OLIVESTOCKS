// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class GoogleMapScreen extends StatefulWidget {
//   @override
//   _GoogleMapScreenState createState() => _GoogleMapScreenState();
// }
//
// class _GoogleMapScreenState extends State<GoogleMapScreen> {
//   late GoogleMapController mapController;
//
//   final LatLng _center = const LatLng(45.521563, -122.677433);
//
//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }
//
//     // LatLng(37.7749, -122.4194), // Start
//     // LatLng(37.7790, -122.4140),
//     // LatLng(37.7830, -122.4100),
//     // LatLng(37.7880, -122.4080),
//     // LatLng(37.7930, -122.4100),
//     // LatLng(37.7980, -122.4140),
//     // LatLng(37.8000, -122.4194), // Top of Circle
//     // LatLng(37.7980, -122.4250),
//     // LatLng(37.7930, -122.4300),
//     // LatLng(37.7880, -122.4320),
//     // LatLng(37.7830, -122.4300),
//     // LatLng(37.7790, -122.4250),
//     // LatLng(37.7749, -122.4194),
//
//   final List<LatLng> polyline = [
//   LatLng(37.7749, -122.4194), // Start
//   LatLng(37.7790, -122.4140),
//   LatLng(37.7830, -122.4100),
//   LatLng(37.7880, -122.4080),
//   LatLng(37.7930, -122.4100),
//   LatLng(37.7980, -122.4140),
//   LatLng(37.8000, -122.4194), // Top of Circle
//   LatLng(37.7980, -122.4250),
//   LatLng(37.7930, -122.4300),
//   LatLng(37.7880, -122.4320),
//   LatLng(37.7830, -122.4300),
//   LatLng(37.7790, -122.4250),
//   LatLng(37.7749, -122.4194),
//   ];
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     return MaterialApp(
//       theme: ThemeData(
//         useMaterial3: true,
//         colorSchemeSeed: Colors.green[700],
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Maps Sample App'),
//           elevation: 2,
//         ),
//         body: GoogleMap(
//           onMapCreated: _onMapCreated,
//           initialCameraPosition: CameraPosition(
//             target: _center,
//             zoom: 11.0,
//           ),
//           polylines: {
//             Polyline(
//               polylineId: PolylineId("route"),
//               points: polyline,
//               color: Colors.blue,
//               width: 5,
//             )
//           },
//         ),
//       ),
//     );
//
//   }
//
// }