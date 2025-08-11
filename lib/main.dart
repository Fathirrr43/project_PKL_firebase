import 'package:flutter/material.dart';
import 'package:myapp/auth/login.dart';
import 'package:myapp/auth/onboarding.dart';
import 'package:myapp/auth/splashscreen.dart';
import 'package:myapp/views/home.dart';
import 'package:myapp/views/panduan.dart';
import 'package:myapp/views/keberangkatan.dart';
import 'package:myapp/views/profile.dart';
import 'package:myapp/views/umrah.dart';
import 'package:myapp/views/lokasi.dart';
import 'package:myapp/views/shalat.dart';
import 'package:myapp/views/faq.dart';
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
          '/home': (context) => const Home(),
          '/umrah': (context) => const PaketUmrah(),
          '/lokasi': (context) => const LokasiCabang(),
          '/sholat': (context) => const WaktuShalat(),
          '/faq': (context) => const Faq(),
          '/jadwal': (context) => const Panduan(),
          '/keberangkatan': (context) => const Keberangkatan(),
          '/profile': (context) => const Profile(),
        },
      ),
    );
  }
}
