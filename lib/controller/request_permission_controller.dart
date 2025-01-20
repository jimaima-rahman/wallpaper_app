import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> requestStoragePermission() async {
  // Request storage permission
  var status = await Permission.storage.request();

  if (status.isGranted) {
    // Permission granted
    // ignore: avoid_print
    Text('Downloaded!!');
    log("Storage permission granted");
  } else if (status.isDenied) {
    // Permission denied
    log("Storage permission denied");
  } else if (status.isPermanentlyDenied) {
    // Permission permanently denied
    log("Storage permission permanently denied. Opening app settings...");
    await openAppSettings();
  }
}
