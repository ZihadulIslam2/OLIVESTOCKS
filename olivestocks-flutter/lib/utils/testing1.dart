// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class MapScreen extends StatefulWidget {
//   @override
//   _MapScreenState createState() => _MapScreenState();
// }
//
// class _MapScreenState extends State<MapScreen> {
//   Completer<GoogleMapController> _controller = Completer();
//
//   // Initial camera position
//   static final CameraPosition _initialPosition = CameraPosition(
//     target: LatLng(40.7128, -74.0060), // New York
//     zoom: 14.0,
//   );
//
//   // Marker to represent the moving object
//   late Marker _marker;
//
//   // Polyline points
//   PolylinePoints polylinePoints = PolylinePoints();
//   Map<PolylineId, Polyline> polylines = {};
//   List<LatLng> polylineCoordinates = [];
//
//   // Start and end locations
//   LatLng startLocation = LatLng(40.7128, -74.0060); // New York
//   LatLng endLocation = LatLng(40.741895, -73.989308); // Somewhere in NYC
//
//   // Index to track the current position in the polyline
//   int _polylineIndex = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _marker = Marker(
//       markerId: MarkerId("movingMarker"),
//       position: startLocation,
//       icon: BitmapDescriptor.defaultMarker,
//     );
//     // _getPolyline();
//   }
//
//   // Function to get the polyline between start and end locations
//   // void _getPolyline() async {
//   //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//   //     googleApiKey: "YOUR_GOOGLE_MAPS_API_KEY", // Replace with your Google Maps API key
//   //     PointLatLng(startLocation.latitude, startLocation.longitude),
//   //     PointLatLng(endLocation.latitude, endLocation.longitude), request: null,
//   //
//   //   );
//   //
//   //   if (result.points.isNotEmpty) {
//   //     result.points.forEach((PointLatLng point) {
//   //       polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//   //     });
//   //
//   //     setState(() {
//   //       PolylineId id = PolylineId("poly");
//   //       Polyline polyline = Polyline(
//   //         polylineId: id,
//   //         color: Colors.blue,
//   //         points: polylineCoordinates,
//   //         width: 5,
//   //       );
//   //       polylines[id] = polyline;
//   //     });
//   //
//   //     // Start the marker animation
//   //     _animateMarker();
//   //   }
//   // }
//
//   // Function to animate the marker along the polyline
//
//   void _animateMarker() {
//     Timer.periodic(Duration(milliseconds: 500), (timer) {
//       if (_polylineIndex < polylineCoordinates.length - 1) {
//         setState(() {
//           _marker = Marker(
//             markerId: MarkerId("movingMarker"),
//             position: polylineCoordinates[_polylineIndex],
//             icon: BitmapDescriptor.defaultMarker,
//           );
//           _polylineIndex++;
//         });
//       } else {
//         timer.cancel();
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Polyline Navigation'),
//       ),
//       body: GoogleMap(
//         mapType: MapType.normal,
//         initialCameraPosition: _initialPosition,
//         markers: {_marker},
//         polylines: Set<Polyline>.of(polylines.values),
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//       ),
//     );
//   }
// }