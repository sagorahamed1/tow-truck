
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;

import '../helpers/prefs_helper.dart';
import '../utils/app_constant.dart';

class LiveLocationChangeController extends GetxController {


  @override
  void onInit() {
    listenToLocationChanges();
    super.onInit();
  }

  final loc.Location location = loc.Location();
  LatLng center = const LatLng(0, 0);
  GoogleMapController? mapController;



  ///=====================  Live Location Changing ======================>>>
  bool isMapReady = false;

  void listenToLocationChanges() async {
    var userId = await PrefsHelper.getString(AppConstants.userId); // Cache this once

    if (userId.isEmpty) {
      debugPrint("❌ User ID not found.");
      return;
    }

    location.onLocationChanged.listen((loc.LocationData newLocation) {
      double? lat = newLocation.latitude;
      double? lng = newLocation.longitude;

      if (lat != null && lng != null) {
        LatLng newCenter = LatLng(lat, lng);

        // Only emit if location has changed significantly
        if (_hasLocationChanged(center, newCenter)) {
          center = newCenter;

          debugPrint("📍 Location changed: $lat, $lng");

          // SocketServices().emit("location-share", {
          //   "userId": userId,
          //   "lng": lng,
          //   "lat": lat,
          // });

          update();
        }
      }
    });
  }

  bool _hasLocationChanged(LatLng oldLoc, LatLng newLoc, {double threshold = 0.00001}) {
    return (oldLoc.latitude - newLoc.latitude).abs() > threshold ||
        (oldLoc.longitude - newLoc.longitude).abs() > threshold;
  }


}
