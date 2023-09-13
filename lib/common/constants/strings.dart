import 'package:flutter/material.dart';

class Strings {
  Text onboardingTitle1(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: 'Be the ',
        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
              fontWeight: FontWeight.bold,
            ),
        children: [
          TextSpan(
            text: 'eyes and ears ',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          TextSpan(
            text: 'of Government',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }

  //Ministry List

  static const List<String> depts = [
    'Ministry of Road Transport & Highways',
    'Ministry of Jal Shakti',
  ];
}
