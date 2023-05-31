import 'package:flutter/material.dart';
import 'presentation/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'presentation/screens/routes/appRouteConfig.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'application/auth/user_data/user_data_bloc.dart';

SharedPreferences? prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Welcome',
      theme: ThemeData(
          primaryColor: kPrimaryColor, scaffoldBackgroundColor: Colors.white),
      routeInformationParser: MyAppRoute().router.routeInformationParser,
      routerDelegate: MyAppRoute().router.routerDelegate,

    );
  }
}
