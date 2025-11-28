// import 'dart:math' as Math;
//
// import 'package:latlong2/latlong.dart';
//
// class NavigationHelper {
//   final List<LatLng> polyline;
//   final double tolerance;
//
//   NavigationHelper({required this.polyline, this.tolerance = 10.0});
//
//   /// Checks if the user is on the predefined path (within a certain tolerance)
//   bool isUserOnPath(LatLng userLocation) {
//     for (LatLng point in polyline) {
//       double distance = Distance().as(LengthUnit.Meter, userLocation, point);
//       if (distance <= tolerance) {
//         return true;
//       }
//     }
//     return false;
//   }
//
//   /// Determines if the user is going in the correct direction
//   bool isUserGoingCorrectDirection(LatLng prevLocation, LatLng currentLocation) {
//     int closestIndex = _findClosestPointIndex(prevLocation);
//     if (closestIndex == -1 || closestIndex == polyline.length - 1) return false;
//
//     LatLng nextPoint = polyline[closestIndex + 1];
//     double bearingToNext = _calculateBearing(prevLocation, nextPoint);
//     double userBearing = _calculateBearing(prevLocation, currentLocation);
//
//     return (userBearing - bearingToNext).abs() < 30.0; // Allow slight deviation
//   }
//
//   /// Calculates a completion score based on user's progress along the route
//   double calculateCompletionScore(LatLng userLocation) {
//     int closestIndex = _findClosestPointIndex(userLocation);
//     return (closestIndex / (polyline.length - 1)) * 100.0;
//   }
//
//   /// Helper function to find the closest point index in the polyline
//   int _findClosestPointIndex(LatLng location) {
//     double minDistance = double.infinity;
//     int closestIndex = -1;
//
//     for (int i = 0; i < polyline.length; i++) {
//       double distance = Distance().as(LengthUnit.Meter, location, polyline[i]);
//       if (distance < minDistance) {
//         minDistance = distance;
//         closestIndex = i;
//       }
//     }
//     return closestIndex;
//   }
//
//   /// Helper function to calculate bearing between two points
//   double _calculateBearing(LatLng start, LatLng end) {
//     double lat1 = start.latitude * (3.141592653589793 / 180.0);
//     double lat2 = end.latitude * (3.141592653589793 / 180.0);
//     double deltaLon = (end.longitude - start.longitude) * (3.141592653589793 / 180.0);
//
//     double y = Math.sin(deltaLon) * Math.cos(lat2);
//     double x = Math.cos(lat1) * Math.sin(lat2) -
//         Math.sin(lat1) * Math.cos(lat2) * Math.cos(deltaLon);
//
//     double bearing = (Math.atan2(y, x) * (180.0 / 3.141592653589793) + 360) % 360;
//     return bearing;
//   }
// }
