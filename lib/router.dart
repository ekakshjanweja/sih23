import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sih_chatbot/features/authentication/views/login_page.dart';
import 'package:sih_chatbot/features/authentication/views/signup_page.dart';
import 'package:sih_chatbot/features/authentication/views/verify_otp.dart';
import 'package:sih_chatbot/features/home/views/home_page.dart';
import 'package:sih_chatbot/features/home/views/ticket_generation.dart';
import 'package:sih_chatbot/features/onboarding/views/onboarding_screen.dart';

final loggedOutRoute = RouteMap(
  routes: {
    '/': (route) => const MaterialPage(
          child: OnboardingScreen(),
        ),
    LoginPage.routeName: (route) => const MaterialPage(
          child: LoginPage(),
        ),
    SignUpPage.routeName: (route) => const MaterialPage(
          child: SignUpPage(),
        ),
    VerifyOTP.routeName: (route) => const MaterialPage(
          child: VerifyOTP(),
        ),
  },
);

final loggedInRoute = RouteMap(
  routes: {
    '/': (route) => const MaterialPage(
          child: HomePage(),
        ),
    TicketGeneration.routeName: (route) => const MaterialPage(
          child: TicketGeneration(),
        ),
  },
);
