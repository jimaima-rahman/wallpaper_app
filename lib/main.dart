import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpapper_app/controller/request_permission_controller.dart';
import 'package:wallpapper_app/provider/unplash_provider.dart';
import 'package:wallpapper_app/view/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await requestStoragePermission();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => CollectionsProvider()..loadCollections()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
