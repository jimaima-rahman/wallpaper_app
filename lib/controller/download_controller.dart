// import 'package:dio/dio.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:wallpapper_app/main.dart';

// Future<void> downloadImage(String url, String fileName) async {
//   try {
//     // Get the application's documents directory
//     final directory = await getApplicationDocumentsDirectory();
//     final filePath = '${directory.path}/$fileName';

//     // Download the image
//     await Dio().download(url, filePath);

//     // Show a notification on successful download
//     const AndroidNotificationDetails androidDetails =
//         AndroidNotificationDetails(
//       'download_channel',
//       'Downloads',
//       channelDescription: 'Notifications for downloads',
//       importance: Importance.high,
//       priority: Priority.high,
//     );
//     const NotificationDetails notificationDetails =
//         NotificationDetails(android: androidDetails);

//     await flutterLocalNotificationsPlugin.show(
//       0,
//       'Download Complete',
//       'Image saved as $fileName',
//       notificationDetails,
//     );

//     print('Downloaded: $filePath');
//   } catch (e) {
//     print('Download failed: $e');
//   }
// }
