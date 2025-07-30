import 'package:flutter/material.dart';
import 'package:myapp/auth/login.dart';
import 'package:myapp/auth/onboarding.dart';
import 'package:myapp/views/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BottomNavigationBarProvider>(
      create: (context) => BottomNavigationBarProvider(),
      child: MaterialApp(
        title: 'Tridaya Travel',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => Home(),
          '/login': (context) => const Login(),
          '/onboarding': (context) => const OnBoarding(),
        },
      ),
    );
  }
}
