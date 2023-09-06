import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sih_chatbot/common/constants/string.dart';
import 'package:sih_chatbot/features/authentication/views/login_page.dart';
import 'package:sih_chatbot/features/authentication/views/signup_page.dart';
import 'package:sih_chatbot/gen/assets.gen.dart';

class OnboardingScreen extends StatelessWidget {
  static const routeName = '/onboarding';

  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            vertical: currentHeight * 0.05,
            horizontal: currentWidth * 0.06,
          ),
          child: Stack(
            children: [
              //Progress Bar

              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: currentWidth / 3.8,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    Container(
                      width: currentWidth / 3.8,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    Container(
                      width: currentWidth / 3.8,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ],
                ),
              ),

              //Orb

              Positioned(
                top: currentHeight * 0.05,
                left: 0,
                right: 0,
                child: Image.asset(
                  Assets.images.orb.path,
                  scale: 1,
                ),
              ),

              //GovBuzz

              Positioned(
                top: currentHeight * 0.40,
                child: Text(
                  'GovBuzz',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),

              //Title & Subtitle

              Positioned(
                top: currentHeight * 0.43,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Strings().onboardingTitle1(context),
                    Text(
                      'The Citizen Grievance App Connecting you with the power to make a difference.',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
              ),

              //Register Now

              Positioned(
                top: currentHeight * 0.73,
                left: 0,
                right: 0,
                child: FilledButton.tonal(
                  onPressed: () {
                    Routemaster.of(context).push(SignUpPage.routeName);
                  },
                  child: const Text('Register Now'),
                ),
              ),

              //Already have an account

              Positioned(
                top: currentHeight * 0.80,
                left: 0,
                right: 0,
                child: FilledButton(
                  onPressed: () {
                    Routemaster.of(context).push(LoginPage.routeName);
                  },
                  child: const Text('Already have an account'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
