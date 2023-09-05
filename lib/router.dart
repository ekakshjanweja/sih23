import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sih_chatbot/features/authentication/views/login_page.dart';
import 'package:sih_chatbot/features/authentication/views/verify_otp.dart';
import 'package:sih_chatbot/features/home/views/home_page.dart';

final loggedOutRoute = RouteMap(
  routes: {
    LoginPage.routeName: (route) => const MaterialPage(
          child: LoginPage(),
        ),
    VerifyOTP.routeName: (route) => MaterialPage(
          child: VerifyOTP(
            verificationId: route.queryParameters['verificationId']!,
          ),
        ),
  },
);

final loggedInRoute = RouteMap(
  routes: {
    HomePage.routeName: (route) => const MaterialPage(
          child: HomePage(),
        ),
  },
);
