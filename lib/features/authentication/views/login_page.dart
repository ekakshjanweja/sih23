import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sih_chatbot/features/authentication/controller/auth_controller.dart';
import 'package:sih_chatbot/gen/assets.gen.dart';

class LoginPage extends ConsumerStatefulWidget {
  static const routeName = '/login';

  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final formKey = GlobalKey<FormState>();

  bool isOtpSent = false;

  //Text Editing Controllers

  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    final currentHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 60,
          scrolledUnderElevation: 0,
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Image.asset(
            Assets.images.orb.path,
            scale: 4,
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            vertical: currentHeight * 0.035,
            horizontal: currentWidth * 0.06,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Mobile Number Verification

                  Text(
                    'Mobile Number Verification',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),

                  SizedBox(
                    height: currentHeight * 0.03,
                  ),

                  //Phone Inputfield

                  TextFormField(
                    autofocus: true,
                    controller: phoneController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Phone number must not be empty.';
                      }
                      if (value.length != 10) {
                        return 'Enter a valid phone number';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: currentHeight * 0.03,
                  ),

                  //Enter OTP

                  TextField(
                    controller: otpController,
                    keyboardType: TextInputType.phone,
                    enabled: isOtpSent,
                    decoration: InputDecoration(
                      labelText: 'Enter OTP',
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: currentHeight * 0.1,
                  ),

                  //Request OTP

                  isOtpSent
                      ? SizedBox(
                          width: currentWidth,
                          child: FilledButton(
                            onPressed: () {
                              setState(() {
                                isOtpSent = true;
                              });

                              ref
                                  .watch(authControllerProvider.notifier)
                                  .verifyOTP(
                                    context: context,
                                    ref: ref,
                                    userOTP: otpController.text.trim(),
                                  );
                            },
                            child: const Text('Confirm OTP'),
                          ),
                        )
                      : SizedBox(
                          width: currentWidth,
                          child: FilledButton(
                            onPressed: () {
                              setState(() {
                                isOtpSent = true;
                              });

                              ref
                                  .watch(authControllerProvider.notifier)
                                  .signInWithPhone(
                                    context: context,
                                    ref: ref,
                                    phoneNumber: ref
                                        .watch(
                                            newUserOnboardingProvider.notifier)
                                        .state!
                                        .phone,
                                  );
                            },
                            child: const Text('Request OTP'),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
