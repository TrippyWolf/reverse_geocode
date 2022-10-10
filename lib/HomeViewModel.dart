import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';

class HomeViewModel {
  String latitude;
  String longitude;
  String addressFromPlaceMark;
  String addressFromMethodChannel;
  int timeTakenFromPlaceMark;
  int timeTakenFromMethodChannel;

  HomeViewModel(
      this.latitude,
      this.longitude,
      this.addressFromPlaceMark,
      this.addressFromMethodChannel,
      this.timeTakenFromPlaceMark,
      this.timeTakenFromMethodChannel);

  MethodChannel platform = const MethodChannel("flutter.native/helper");

  ///use native for better and proper result
  Future<void> responseFromNativeCode(String latitude, String longitude) async {
    int startTime = DateTime.now().millisecondsSinceEpoch;
    try {
      addressFromMethodChannel = await platform.invokeMethod(
          "getAddressFromLatLong", {"lat": latitude, "long": longitude});
    } on PlatformException catch (e) {
      addressFromMethodChannel = "Failed to Invoke: '${e.message}'.";
    }
    int endTime = DateTime.now().millisecondsSinceEpoch;
    timeTakenFromMethodChannel = endTime - startTime;
  }

  void getGeoCodeAddress(double latitude, double longitude) async {
    addressFromPlaceMark = "Error";
    int startTime = DateTime.now().millisecondsSinceEpoch;
    List<Placemark> myList =
        await placemarkFromCoordinates(latitude, longitude);
    Placemark placemark = myList.first;
    addressFromPlaceMark = "${placemark.toString()}";
    int endTime = DateTime.now().millisecondsSinceEpoch;
    timeTakenFromPlaceMark = endTime - startTime;
  }

  Function() onPressed(BuildContext context) {
    return () async {
      getGeoCodeAddress(double.parse(latitude), double.parse(longitude));
      if (Platform.isAndroid) {
        await responseFromNativeCode(latitude, longitude);
      } else if (Platform.isIOS) {
        addressFromMethodChannel = " N/A";
        timeTakenFromMethodChannel = 0;
      }
      Element e = (context) as Element;
      e.markNeedsBuild();
    };
  }
}
